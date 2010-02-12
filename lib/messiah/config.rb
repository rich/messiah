class Messiah::Config
  attr_accessor :values

  def respond_to?(key)
    true
  end

  def method_missing(key, *val, &block)
    @values ||= {}
    if val.first || block
      @values[key.to_s.gsub(/=/, '')] = val.first || block
    else
      @values[key.to_s]
    end
  end
end
