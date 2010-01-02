class Messiah::Generator::Application
  def self.run!(*args)
    options = Messiah::Generator::Options.new(args)

    if options[:invalid_argument]
      $stderr.puts options[:invalid_argument]
      options[:show_help] = true
    end

    if options[:show_help]
      $stderr.puts options.opts
      return 1
    end
    
    generator = Messiah::Generator.new(options)
    generator.run!
    return 0
  end
end
