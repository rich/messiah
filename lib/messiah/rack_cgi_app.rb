class Messiah::RackCGIApp
  def call(env)
    add_to_environment!(env)
    header_string, body = call_cgi(env)
    headers, status = parse_headers(header_string)
    [status, headers, [body]]
  end
  
  def add_to_environment!(env)
    env['HTTP_HOST'] = Messiah.host
    env['DOCUMENT_ROOT'] = Messiah.root
    env['SCRIPT_NAME'] = (Messiah.script || env['PATH_INFO']).gsub(/^\//, '')
    env['SCRIPT_FILENAME'] = env['PATH_TRANSLATED'] = File.join(env['DOCUMENT_ROOT'], env['SCRIPT_NAME'])
  end
  
  def build_environment_string(env)
    env.inject([]) do |a, item|
      a << "#{item.first}=\"#{item.last}\""
      a
    end.join(' ')
  end
  
  def call_cgi(env)
    env_string = build_environment_string(env)

    stdin, stdout, stderr = Open3.popen3("env #{env_string} #{Messiah.command}")
    stdin.write env['rack.input'].read if env['REQUEST_METHOD'] == 'POST'
    stdin.close
    
    stdout.read.split("\n\r", 2)
  end
  
  def parse_headers(header)
    headers = header.split("\n").inject({}) do |h, line|
      key, val = line.split(':').map(&:strip)
      h[key] = val
      h
    end
    status = headers.delete('Status') || 200
    
    [headers, status]
  end
end