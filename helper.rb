require "rubygems"
require 'webrat'
require 'rack/request'
require 'rack/response'
require "test/unit/assertions"
require "rack/test"
require "redgreen"
gem "rspec"
require "spec"

Webrat.configure do |config|
  config.mode = :rack
end

Spec::Runner.configure do |config|
end

