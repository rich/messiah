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

  add :cucumber, Cucumber
  add :rspec, RSpec

  desc "Setup a testing framework supported by Messiah in the current directory."
end
