require_relative 'response'

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
    @path = request_lines["Path"]
    @verb = request_lines["Verb"]
    @param = request_lines["Param"]
    @value = request_lines["Value"]

    case @path
    when "/"
      #do nothing
    when "/datetime"
      @response.datetime
    when "/word_search"
      @response.word_search(@value)
    when "/hello"
      @response.hello(@hello_requests)
    when "/shutdown"
      @response.shutdown(@all_requests)
    when "/start_game"
      if @verb == "POST"
        #begin game
        @response.start_game
      end
    when "/game"
      #process game
      if @verb == "GET"
        @response.game(@game_guesses, @current_guess, @guess_status)
      elsif @verb == "POST"
        #redirect to /game
      end
    else
      #path doesn't exist
    end
  end

end
