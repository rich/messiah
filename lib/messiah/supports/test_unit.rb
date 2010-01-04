module Messiah::Supports::TestUnit
  def self.included(base)
    base.send(:include, Messiah::Supports::Common)
  end  
end
