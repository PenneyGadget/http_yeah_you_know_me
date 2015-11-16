require_relative 'http_yeah_you_know_me'

class Path

  attr_accessor :hello_requests, :all_requests, :game_running, :game_guesses, :current_guess, :guess_status, :do_shutdown

  def initialize
    @hello_requests = 0
    @all_requests = 0
    @game_running = false
    @game_guesses = 0
    @current_guess = 0
    @guess_status = ""
    @do_shutdown = false

    @response = Response.new
  end

  def process_path(request_lines)
    components = request_lines["Path"].scan(/([^\?]*)\??([^=]*)=?(.*)/)

    path = components[0][0]
    param = components[0][1]
    value = components[0][2]
    verb = request_lines["Verb"]

    case path
    when "/"
      #do nothing
    when "/datetime"
      @response.datetime
    when "/word_search"
      @response.word_search(value)
    when "/hello"
      @response.hello(@hello_requests)
    when "/shutdown"
      @response.shutdown(@all_requests)
    when "/start_game"
      if verb == "POST"
        #begin game
        @response.start_game
      end
    when "/game"
      #process game
      if verb == "GET"
        @response.game_stats(@game_guesses, @current_guess, @guess_status)
      elsif verb == "POST"
        #redirect to /game
      end
    else
      #path doesn't exist
    end
  end

end
