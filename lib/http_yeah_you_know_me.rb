require 'pry'
require 'socket'
require_relative 'parser'
require_relative 'response'

$hello_requests = 0
$all_requests = 0
$do_shutdown = false

class HttpYeahYouKnowMe #(aka the server)

  def initialize(port)
    @server = TCPServer.new(port)
  end

  def run
    loop do
      client = @server.accept
      request_lines = Parser.new(client).parse_request
      output = Response.new(request_lines).build_response
      # headers = Response.new(output).build_response_headers
      return_response(client, output)
    end
    client.close
  end

  def return_response(client, output)
    # client.puts headers
    client.puts output
    $all_requests += 1
    if $do_shutdown
      exit
    end
  end

end


if __FILE__ == $0
  server = HttpYeahYouKnowMe.new(9292)
  server.run
end
