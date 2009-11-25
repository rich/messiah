module Messiah
  autoload :RSpec, 'messiah/rspec'
  autoload :RackCGIApp, 'messiah/rack_cgi_app'
  
  class << self
    attr_accessor :root, :script, :command, :host
  end
end

Webrat.configure do |config|
  config.mode = :rack
end