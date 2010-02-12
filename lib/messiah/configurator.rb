class Messiah::Configurator
  def initialize(config)
    @config = config
    configure_framework
    configure_world
    configure_webrat
    configure_database if @config.database
  end

  def self.configure!(config)
    new(config)
  end

  def configure_framework
    @framwork = case @config.framework
    when :code_igniter
      Messiah::Supports::CodeIgniter.new(@config)
    end
  end

  def configure_webrat
    Webrat.configure do |config|
      config.mode = :rack
    end
  end

  def configure_world
    Spec::Example::ExampleGroup.send(:include, Messiah::Supports::RSpec) if rspec?
    Object.send(:include, Messiah::Supports::Cucumber) if cucumber?
    Object.send(:include, Messiah::Supports::TestUnit) if test_unit?
  end

  def configure_database
    require 'active_record'
    ActiveRecord::Base.establish_connection(@config.database)

    require 'dr_nic_magic_models'
    DrNicMagicModels.extend_module_class!
    DrNicMagicModels::Schema.new(Object).load_schema

    require 'factory_girl'
    require 'database_cleaner'
    DatabaseCleaner.strategy = :truncation
  end

  def rspec?
    defined?(Spec::Example::ExampleGroup)
  end

  def cucumber?
    defined?(Cucumber)
  end

  def test_unit?
    defined?(Test::Unit)
  end
end
