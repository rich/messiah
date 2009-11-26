require "test/unit/assertions"

module Messiah::TestUnit
  def self.included(base)
    base.send(:include, Messiah::Common)
  end  
end