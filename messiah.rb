module Messiah
  class << self
    attr_accessor :root, :script, :command
  end
  
  class CGIApp
    def call(env)
      env['DOCUMENT_ROOT'] = Messiah.root
      env['SCRIPT_NAME'] = (Messiah.script || env['PATH_INFO']).gsub(/^\//, '')
      env['SCRIPT_FILENAME'] = env['PATH_TRANSLATED'] = File.join(env['DOCUMENT_ROOT'], env['SCRIPT_NAME'])

      env_strings = env.inject([]) do |a, item|
        a << "#{item.first}=\"#{item.last}\""
        a
      end

      response = %x|env #{env_strings.join(' ')} #{Messiah.command}|
      header, body = response.split("\n\r", 2)

      headers = header.split("\n").inject({}) do |h, line|
        key, val = line.split(':').map(&:strip)
        h[key] = val
        h
      end
      status = headers.delete('Status') || 200
      [status, headers, [body]]
    end
  end
end