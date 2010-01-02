class Messiah::Generator::RSpec < Templater::Generator
  def self.source_root
    File.join(Messiah::Generator.template_path, 'rspec')
  end

  first_argument :root, :default => %q|File.join(File.dirname(__FILE__), '..')|
  second_argument :command, :default => 'php-cgi -d cgi.force_redirect=0'
  third_argument :script

  empty_directory :models, File.join('spec/fixtures/models')
  template :spec_helper, 'spec/spec_helper.rb'
end
