module Messiah::Common
  def app
    Rack::Builder.new {
      run Messiah::RackCGIApp.new
    }
  end
end