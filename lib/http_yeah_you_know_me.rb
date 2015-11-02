require 'pry'
require 'socket'

class HttpYeahYouKnowMe

  # def initialize(port)
  #   @server = TCPServer.new(port)
  #   @client = @server.accept
  # end

  tcp_server = TCPServer.new(9292)
  request_counter = 0

  loop do
    client = tcp_server.accept

    response = "<pre>" + ("Hello, World (#{request_counter})\n") + "</pre>"
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ["http/1.1 200 ok",
               "date: #{Time.now.strftime('%a, %e %b %Y %H %M %S %z')}",
               "server: ruby",
               "content-type: text/html; charset=iso-8859-1",
               "content-length: #{output.length}\r\n\r\n"].join("\r\n")

    request_counter += 1
    client.puts headers
    client.puts output
  end

  client.close

end
