require 'optparse'

class Messiah::Generator::Options < Hash
  attr_reader :opts

  def initialize(args)
    super()
    
    @opts = OptionParser.new do |o|
      o.banner = "Usage: #{File.basename($0)} options\ne.g. #{File.basename($0)} --rspec --cucumber"

      o.on('--rspec', 'generate rspec support files') do
        self[:rspec] = true
      end

      o.on('--cucumber', 'generate cucumber support files') do
        self[:cucumber] = true
      end

      o.on('--testunit', 'generate testunit support files') do
        self[:testunit] = true
      end

      o.separator ""

      o.on_tail('-h', '--help', 'display this help and exit') do
        self[:show_help] = true
      end
    end

    begin
      @opts.parse!(args)
      self[:directory] = args.shift || Dir.pwd
    rescue OptionParser::InvalidOption => e
      self[:invalid_argument] = e.message
    end
  end
end
