require "rubygems"
require 'webrat'
require 'rack/request'
require 'rack/response'
require "test/unit"
require "rack/test"
require "redgreen"

Webrat.configure do |config|
  config.mode = :rack
end

class Test::Unit::TestCase
  def app
    Rack::Builder.new {
      use Rack::ShowExceptions
      use Rack::CommonLogger
      use Rack::Lint
      run Messiah::CGIApp.new
    }
  end
end