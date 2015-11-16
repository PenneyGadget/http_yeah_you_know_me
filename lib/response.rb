class Response

  def hello(requests)
    "Hello, World! (#{requests})\n\n"
  end

  def datetime
    Time.now.strftime("%I:%M%p on %A, %B %e, %Y\n\n")
  end

  def shutdown(requests)
    "Total Requests: #{requests}\n\n"
  end

  def word_search(word) ##runs in the browser like so: http://0.0.0.0:9292/word_search?param=hello
    dictionary = File.read("/usr/share/dict/words").split("\n")
    if dictionary.include?(word.downcase)
      "#{word.upcase} is a word!\n\n"
    else
      "You are very bad at English.\n\n"
    end
  end

  def start_game
    "Good Luck!"
  end

  def game_stats(game_guesses, current_guess, guess_status)
    "You have taken #{game_guesses} guesses.\nYour Guess of #{current_guess} is #{guess_status}.\n\n"
  end

  def build_response_headers(content_length)
    ["http/1.1 200 ok",
     "date: #{Time.now.strftime('%a, %e %b %Y %H %M %S %z')}",
     "server: ruby",
     "content-type: text/html; charset=iso-8859-1",
     "content-length: #{content_length}\r\n\r\n"].join("\r\n")
  end

end
