module Messiah::Common
  def self.included(base)
    base.send(:include, Webrat::Methods)
    base.send(:include, Rack::Test::Methods)
    base.send(:include, Webrat::Matchers)
  end  
  
  def app
    Rack::Builder.new {
      run Messiah::Rack::CGI.new
    }
  end
end
