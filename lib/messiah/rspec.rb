module Messiah::RSpec
  def self.included(base)
    base.send(:include, Webrat::Methods)
    base.send(:include, Rack::Test::Methods)
    base.send(:include, Webrat::Matchers)
    base.send(:include, Messiah::Common)
  end  
end