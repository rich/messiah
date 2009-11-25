module Messiah::RSpec
  def self.included(base)
    base.send(:include, Webrat::Methods)
    base.send(:include, Rack::Test::Methods)
    base.send(:include, Webrat::Matchers)
  end
  
  def app
    Rack::Builder.new {
      run Messiah::RackCGIApp.new
    }
  end
end