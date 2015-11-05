class WordSearch

  def initialize(word)
    @word = word.downcase
  end

  def word_search
    is_word = File.read("/usr/share/dict/words").split("\n").include?(@word)
    if is_word
      "#{@word.upcase} is a word!"
    else
      "You are very bad at English."
    end
  end

end
