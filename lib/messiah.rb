require 'webrat'
require 'rack/request'
require 'rack/response'
require "rack/test"
require 'open3'

module Messiah
  autoload :RSpec,      'messiah/rspec'
  autoload :TestUnit,   'messiah/test_unit'
  autoload :RackCGIApp, 'messiah/rack_cgi_app'
  autoload :Common,     'messiah/common'
  autoload :Config,     'messiah/config'

  class << self
    attr_accessor :config

    def configure(&block)
      @config ||= Config.new
      @config.instance_eval(&block)
    end
    
    def method_missing(key, *args, &block)
      @config.send(key, *args, &block)
    end
  end
end

Webrat.configure do |config|
  config.mode = :rack
end