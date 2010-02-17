require 'webrat'
require 'rack/request'
require 'rack/response'
require "rack/test"
require 'open3'

module Messiah
  autoload :Rack,         'messiah/rack'
  autoload :Common,       'messiah/common'
  autoload :Config,       'messiah/config'
  autoload :Configurator, 'messiah/configurator'
  autoload :Generator,    'messiah/generator'

  module Supports
    autoload :Common,     'messiah/supports/common'
    autoload :RSpec,      'messiah/supports/rspec'
    autoload :Cucumber,   'messiah/supports/cucumber'
    autoload :TestUnit,   'messiah/supports/test_unit'
    autoload :CodeIgniter,'messiah/supports/code_igniter'
  end

  VERSION = File.read(File.join(File.dirname(__FILE__), '..', 'VERSION'))

  class << self
    attr_accessor :config, :frozen_config

    def configure(&block)
      @config ||= Config.new
      @config.instance_eval(&block)

      Configurator.configure!(@config)
    end

    def method_missing(key, *args, &block)
      @config.send(key, *args, &block)
    end

    def freeze_config!
      @frozen_config = @config.values.clone
    end

    def reset_config!
      @config.values = @frozen_config.clone
    end

    def rspec(config)
      config.before(:suite, &Messiah.method(:before_suite))
      config.before(:each, &Messiah.method(:before_test))
      config.after(:each, &Messiah.method(:after_test))
    end

    def cucumber(world)
      world.AfterConfiguration(&Messiah.method(:before_suite))
      world.Before(&Messiah.method(:before_test))
    end

    def before_suite(*args)
      Messiah.freeze_config!
    end

    def before_test(*args)
      Messiah.reset_config!
      DatabaseCleaner.clean if Messiah.database
    end

    def after_test
    end
  end
end
