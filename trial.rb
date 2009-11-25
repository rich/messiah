require File.dirname(__FILE__) + '/helper'
require File.dirname(__FILE__) + '/messiah'

Messiah.root = '/Users/rich/Projects/sandbox/messiah/www'
# Messiah.script = 'index.php'
Messiah.command = 'php-cgi -d cgi.force_redirect=0'

# class WebratRackTest < Test::Unit::TestCase
#   include Rack::Test::Methods
#   include Webrat::Methods
#   include Webrat::Matchers
#   include Webrat::HaveTagMatcher
# 
#   def test_visits_pages
#      visit "/index.php"
#      assert_contain "Hello"
#   end
# 
  # def test_clicks_a_link
  #   visit "/index.php"
  #   click_link "Click Me"
  #   assert_contain "another page"
  # end
  # 
  # def test_cookies
  #   visit "/index.php"
  #   click_link "Click Me"
  #   assert_contain "Hello thing"
  # end
# end
# 
# require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Creating blog posts" do
  include Webrat::Methods
  include Rack::Test::Methods
  include Webrat::Matchers
  include Test::Unit::Assertions
  
  def app
    Rack::Builder.new {
      use Rack::ShowExceptions
      use Rack::CommonLogger
      use Rack::Lint
      run Messiah::CGIApp.new
    }
  end
  
  def body
    last_response.body
  end
  
  it "should accept headers" do
    header "NOPE", "woohoo"
    visit "index.php"
    body.should contain("woohoo")
  end
  
  it "visits the page" do
    request("/index.php").should be_ok
  end
  
  it "doesn't respond positively to unknown files" do
    request("/nope.php").should_not be_ok
  end

  it "clicks a link" do
    visit "/index.php"
    click_link "Click Me"
    body.should contain("another page")
  end
  
  it "handles cookies properly" do
    visit "/index.php"
    click_link "Click Me"
    body.should contain("Hello thing")
  end
  
  it "handles redirects" do
    visit "/redirector.php"
    body.should contain("arrived")
  end
end
