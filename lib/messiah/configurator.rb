class Messiah::Configurator
  def initialize(config)
    @config = config
  end

  def self.configure!(config)
    world = new(config)

    Object.send(:include, Messiah::Supports::RSpec) if world.rspec?
    Object.send(:include, Messiah::Supports::Cucumber) if world.cucumber?
    Object.send(:include, Messiah::Supports::TestUnit) if world.test_unit?
    
    world.configure_rack!
  end

  def configure_rack!
    Webrat.configure do |config|
      config.mode = :rack
    end
  end

  def rspec?
    defined?(Spec::Runner)
  end

  def cucumber?
    defined?(Cucumber)
  end

  def test_unit?
    defined?(Test::Unit)
  end
end
