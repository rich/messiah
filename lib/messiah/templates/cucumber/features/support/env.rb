require 'cucumber/formatter/unicode' # Remove this line if you don't want Cucumber Unicode support
require 'active_record'
require 'cucumber/web/tableish'

require 'webrat'
require 'webrat/core/matchers'

require 'messiah'

Messiah.configure do
  root File.join(File.dirname(__FILE__), '..', '..', 'spec', 'fixtures', 'www')
  command 'php-cgi -d cgi.force_redirect=0'
end

# How to clean your database when transactions are turned off. See
# http://github.com/bmabey/database_cleaner for more info.
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

