$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'messiah'
require 'spec'
require 'spec/autorun'

Messiah.configure do
  root File.join(File.dirname(__FILE__), 'fixtures', 'www')
  command 'php-cgi -d cgi.force_redirect=0'
end

Spec::Runner.configure do |config|
end
