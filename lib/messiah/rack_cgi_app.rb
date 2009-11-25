require 'open3'

class Messiah::RackCGIApp
  def call(env)
    env['HTTP_HOST'] = Messiah.host
    env['DOCUMENT_ROOT'] = Messiah.root
    env['SCRIPT_NAME'] = (Messiah.script || env['PATH_INFO']).gsub(/^\//, '')
    env['SCRIPT_FILENAME'] = env['PATH_TRANSLATED'] = File.join(env['DOCUMENT_ROOT'], env['SCRIPT_NAME'])

    env_strings = env.inject([]) do |a, item|
      a << "#{item.first}=\"#{item.last}\""
      a
    end
    
    stdin, stdout, stderr = Open3.popen3("env #{env_strings.join(' ')} #{Messiah.command}")
    response = stdout.read
    # puts stderr.read
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