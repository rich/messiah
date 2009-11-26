$: << './lib'
require 'messiah'
require File.dirname(__FILE__) + '/helper'


Messiah.root = File.join(File.dirname(__FILE__), 'www')
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
  
  let(:body) {last_response.body}
  
  def visit(url)
    u = url =~ /^\// ? url : "/#{url}"
    super(u)
  end
  
  def host(val)
    Messiah.host = val
  end
  
  before(:each) do
    host "tycoonu.dev"
  end
  
  it "should accept headers" do
    header "NOPE", "woohoo"
    visit "index.php"
    body.should contain("woohoo")
  end
  
  it "visits the page" do
    request("index.php").should be_ok
  end
  
  it "doesn't respond positively to unknown files" do
    request("nope.php").should_not be_ok
  end

  it "clicks a link" do
    visit "index.php"
    click_link "Click Me"
    body.should contain "another page"
  end
  
  it "handles cookies properly" do
    visit "index.php"
    click_link "Click Me"
    body.should contain "Hello thing"
  end
  
  it "handles redirects" do
    visit "redirector.php"
    body.should contain "arrived"
  end

  it "sets the host dynamically" do
    host "sectorhunter.dev"
    visit "index.php"
    body.should contain "Host is sectorhunter.dev"
  end
  
  it "sets the host statically" do
    visit "index.php"
    body.should contain "Host is tycoonu.dev"
  end
  
  it "handles post variables" do
    visit "form.php"
    fill_in "name", :with => 'Rich'
    click_button "Submit"
    body.should contain "Your name is Rich"
  end
  
  it "handles get variables" do
    visit "get_vars.php?first_name=Rich&last_name=Cavanaugh"
    body.should contain "Your name is Rich Cavanaugh"
  end
  
  it "handles file uploads" do
    visit "uploader.php"
    attach_file "File", __FILE__, "text/ruby"
    click_button "Upload"
    body.should contain "[uploaded_file]"
  end
end
