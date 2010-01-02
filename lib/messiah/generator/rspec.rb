class Messiah::Generator::RSpec < Templater::Generator
  def self.source_root
    File.join(Messiah::Generator.template_path, 'rspec')
  end

  glob!
  empty_directory :models, File.join('spec/fixtures/models')
end
