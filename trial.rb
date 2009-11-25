require File.dirname(__FILE__) + '/helper'
require File.dirname(__FILE__) + '/messiah'

Messiah.root = '/Users/rich/Projects/sandbox/messiah/www'
# Messiah.script = 'index.php'
Messiah.command = 'php-cgi -d cgi.force_redirect=0'

class WebratRackTest < Test::Unit::TestCase
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers
  include Webrat::HaveTagMatcher

  def test_visits_pages
     visit "/index.php"
     assert_contain "Hello"
  end

  def test_clicks_a_link
    visit "/index.php"
    click_link "Click Me"
    assert_contain "another page"
  end
  
  def test_cookies
    visit "/index.php"
    click_link "Click Me"
    assert_contain "Hello thing"
  end
end