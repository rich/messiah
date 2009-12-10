begin
  require 'jeweler'
  
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "messiah"
    gemspec.summary = "The beauty of Ruby integration tests for PHP"
    gemspec.description = "Messiah enables using Ruby testing tools for integration testing with platforms that support CGI. Notably, PHP."
    gemspec.email = "rich@withoutscope.com"
    gemspec.homepage = "http://github.com/rich/messiah"
    gemspec.authors = ["Rich Cavanaugh"]

    gemspec.add_dependency('webrat')
    gemspec.add_dependency('rack')
    gemspec.add_dependency('rack-test')
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end
