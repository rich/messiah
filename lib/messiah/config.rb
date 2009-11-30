class Messiah::Config
  attr_accessor :values
  
  def method_missing(key, *val, &block)
    @values ||= {}
    if val.first || block
      @values[key.to_s] = val.first || block
    else
      @values[key.to_s]
    end
  end
end