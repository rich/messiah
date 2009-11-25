module Messiah
  autoload :RSpec,      'messiah/rspec'
  autoload :TestUnit,   'messiah/test_unit'
  autoload :RackCGIApp, 'messiah/rack_cgi_app'
  autoload :Common,     'messiah/common'
  
  class << self
    attr_accessor :root, :script, :command, :host
  end
end

Webrat.configure do |config|
  config.mode = :rack
end