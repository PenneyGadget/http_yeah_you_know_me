require 'pry'
require 'socket'

class HttpYeahYouKnowMe

  def initialize(port)
    @server = TCPServer.new(port)
    # @path = "#{request_lines.first.split(" ")[1]}\n"
  end

  def run
    request_counter = 0
    loop do
      client = @server.accept
      request_counter += 1
      request_lines = parse_request(client)
      output = build_response_body(request_counter, request_lines)
      headers = build_response_headers(output)
      return_response(client, headers, output)
    end
    client.close
  end

  def parse_request(client)
    counter = 0
    info = Hash.new
    while line = client.gets and !line.chomp.empty?
        if counter == 0
          info["Verb"] = line.split(" ").first
          info["Path"] = line.split(" ")[1]
          info["Protocol"] = line.split(" ")[2]
        else
          keyval = line.scan(/([^:]*):(.*$)/)
          info[keyval[0][0]] = keyval[0][1]
        end
        counter += 1
      end
    info
  end

  def build_response_body(request_counter, parse_request)
    response  = "<pre>" + "Hello, World! (#{request_counter})\n\n"
    parse_request.each do |key, value|
      response += "#{key}" + ": " + "#{value}\n"
    end
    response += "</pre>"
    output = "<html><head></head><body>#{response}</body></html>"
  end

  def build_response_headers(output)
    ["http/1.1 200 ok",
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
