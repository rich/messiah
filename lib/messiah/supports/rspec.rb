module Messiah::Supports::RSpec
  def self.included(base)
    base.send(:include, Messiah::Supports::Common)
    base.send(:include, ExampleGroup)
  end

  module ExampleGroup
    def visit(url)
      u = url =~ /^\// ? url : "/#{url}"
      super(u)
    end

    def host(val)
      Messiah.config.host val
    end
  end
end
