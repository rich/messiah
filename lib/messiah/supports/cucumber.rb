module Messiah::Supports::Cucumber
  def self.included(base)
    base.send(:include, Messiah::Common)
  end
end