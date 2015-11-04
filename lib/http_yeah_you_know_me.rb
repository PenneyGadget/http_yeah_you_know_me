require 'pry'
require 'socket'
require_relative 'parser'

class HttpYeahYouKnowMe #(aka the server)

  def initialize(port)
    @server = TCPServer.new(port)
    @hello_requests = 0
    @all_requests = 0
    @do_shutdown = false
  end

  def run
    loop do
      client = @server.accept
      request_lines = Parser.new(client).parse_request
      output = build_response_body(request_lines)
      headers = build_response_headers(output)
      return_response(client, headers, output)
    end
    client.close
  end

  def word_search

  end

  def build_response_body(request_lines)
    response = "<pre>"

    case request_lines["Path"]
      when "/"
        #do nothing
      #when "/word_search"
        #search through dictionary
        #response += dictionary_search(parse_request["Value"])
      when "/hello"
        response += "Hello, World! (#{@hello_requests})\n\n"
        @hello_requests += 1
      when "/datetime"
        response += Time.now.strftime("%I:%M%p on %A, %B %e, %Y") + "\n\n"
      when "/shutdown"
        response += "Total Requests: #{@all_requests}\n\n"
        @do_shutdown = true
      else
        response += "ERROR: Path not found."
    end

    request_lines.each do |key, value|
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
    @all_requests += 1
    if @do_shutdown
      exit
    end
  end

end


if __FILE__ == $0
  server = HttpYeahYouKnowMe.new(9292)
  server.run
end
