require_relative 'word_search'

class Response

  def root
    #do nothing
  end

  def hello(requests)
    "Hello, World! (#{requests})\n\n"
  end

  def datetime
    Time.now.strftime("%I:%M%p on %A, %B %e, %Y") + "\n\n"
  end

  def shutdown(requests)
    "Total Requests: #{requests}\n\n"
  end

  def word_search(value)
    word = WordSearch.new(value)
    word.word_search + "\n\n"
  end

  def start_game
    "Good Luck!"
  end

  def game(game_guesses, current_guess, guess_status)
    "You have taken #{game_guesses}\nYour Guess of #{current_guess} is #{guess_status}"
  end

  def build_response_headers(content_length)
    ["http/1.1 200 ok",
     "date: #{Time.now.strftime('%a, %e %b %Y %H %M %S %z')}",
     "server: ruby",
     "content-type: text/html; charset=iso-8859-1",
     "content-length: #{content_length}\r\n\r\n"].join("\r\n")
  end

end
