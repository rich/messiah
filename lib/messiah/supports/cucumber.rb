module Messiah::Supports::Cucumber
  def self.included(base)
    base.send(:include, Messiah::Supports::Common)
  end
end
