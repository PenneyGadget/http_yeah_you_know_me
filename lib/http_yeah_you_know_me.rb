require 'socket'
require_relative 'parser'
require_relative 'path'
require_relative 'response'
require_relative 'diagnostics'

class HttpYeahYouKnowMe #(aka the server)

  attr_accessor :hello_requests, :all_requests, :game_running, :game_guesses, :current_guess, :guess_status, :do_shutdown

  def initialize(port)
    @server = TCPServer.new(port)
    @hello_requests = 0
    @all_requests = 1
    @do_shutdown = false
    @game_running = false
    @game_guesses = 0
    @current_guess = 0
    @guess_status = ""

    @parser = Parser.new
    @path = Path.new
    @response = Response.new
    @diagnostics = Diagnostics.new
  end

  def run
    loop do
      client = @server.accept
      request = @parser.parse_request(client)

      request_path = request["Path"]
      case request_path
      when "/hello"
        @hello_requests += 1
        @path.hello_requests = @hello_requests
        @path.all_requests = @all_requests
      when "/shutdown"
        @do_shutdown = true
      when "/start_game"
        if request["Verb"] == "POST"
          @game_running = true
          @path.game_running = @game_running
        end
      when "/game"
        #process game
        if request["Verb"] == "POST"
          @game_guesses += 1
          @path.game_guesses = @game_guesses
        elsif request["Verb"] == "GET"
          @path.all_requests = @all_requests
        end
      else
        @path.all_requests = @all_requests
      end

      response = @path.process_path(request)
      headers = @response
      diagnostics = @diagnostics.output_diagnostics(request)
      return_response(client, response, headers, diagnostics)
    end
    @client.close
  end

  def return_response(client, response, headers, diagnostics)
    content = "<html><head></head><body>#{response}#{diagnostics}</body></html>"
    headers = headers.build_response_headers(content.length)
    client.puts headers
    client.puts content
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
