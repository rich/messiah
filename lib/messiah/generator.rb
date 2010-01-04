require 'templater'

module Messiah::Generator
  extend Templater::Manifold

  class << self
    def template_path
      File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
    end
  end
  
  autoload :Cucumber,   'messiah/generator/cucumber'
  autoload :RSpec,      'messiah/generator/rspec'
  autoload :TestUnit,   'messiah/generator/test_unit'

  add :cucumber,  Cucumber
  add :rspec,     RSpec
  add :test_unit, TestUnit

  desc "Setup a testing framework supported by Messiah in the current directory."
end
