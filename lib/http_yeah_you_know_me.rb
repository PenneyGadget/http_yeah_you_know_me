require 'pry'
require 'socket'

class HttpYeahYouKnowMe

  # def initialize(port)
  #   @server = TCPServer.new(port)
  #   @client = @server.accept
  # end
  tcp_server = TCPServer.new(9292)
  client = tcp_server.accept

  # def response
  #   "Hello, World"
  # end
  response = "Hello, World"
  # output = "<html><head></head><body>#{response}</body></html>"

  client.puts response
  client.close

end
