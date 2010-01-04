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
    autoload :Common,   'messiah/supports/common'
    autoload :RSpec,    'messiah/supports/rspec'
    autoload :Cucumber, 'messiah/supports/cucumber'
    autoload :TestUnit, 'messiah/supports/test_unit'
  end

  VERSION = File.read(File.join(File.dirname(__FILE__), '..', 'VERSION'))

  class << self
    attr_accessor :config

    def configure(&block)
      @config ||= Config.new
      @config.instance_eval(&block)

      Configurator.configure!(@config)
    end

    def method_missing(key, *args, &block)
      @config.send(key, *args, &block)
    end
  end
end
