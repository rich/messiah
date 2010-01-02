module Messiah::Supports::RSpec
  def self.included(base)
    base.send(:include, Messiah::Common)
  end
end
