require "rubygems"
require 'webrat'
require 'rack/request'
require 'rack/response'
require "test/unit/assertions"
require "rack/test"
require "redgreen"
gem "rspec"
require "spec"
require 'messiah'


Spec::Runner.configure do |config|
  include Messiah::RSpec
end

