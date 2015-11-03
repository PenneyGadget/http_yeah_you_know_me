require 'pry'
require 'socket'

class HttpYeahYouKnowMe

  def initialize(port)
    @server = TCPServer.new(port)
  end

  def run
    request_counter = 0
    loop do
      client = @server.accept
      request_lines = parse_request(client)
      request_counter += 1
      output = build_response_body(request_counter, request_lines)
      headers = build_response_headers(output)
      return_response(client, headers, output)
    end
    client.close
  end

  def parse_request(client)
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    request_lines
  end

  def build_response_body(request_counter, request_lines)
    response = "<pre>" + ("Hello, World! (#{request_counter})\n\n#{request_lines}") + "</pre>"
    output = "<html><head></head><body>#{response}</body></html>"
  end

  def build_response_headers(output)
    headers = ["http/1.1 200 ok",
               "date: #{Time.now.strftime('%a, %e %b %Y %H %M %S %z')}",
               "server: ruby",
               "content-type: text/html; charset=iso-8859-1",
               "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def return_response(client, headers, output)
    client.puts headers
    client.puts output
  end

end


if __FILE__ == $0
  server = HttpYeahYouKnowMe.new(9292)
  server.run
end
