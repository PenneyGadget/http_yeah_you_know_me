require 'minitest/autorun'
require 'minitest/emoji'
require_relative '../lib/response'
require 'timecop'

class ResponseTest < Minitest::Test

  def test_hello_response_output
    r = Response.new
    output = r.hello(1)

    assert_equal "Hello, World! (1)\n\n", output
  end

  def test_datetime_response_output
    r = Response.new
    time = Time.now.strftime("%I:%M%p on %A, %B %e, %Y\n\n")
    Timecop.freeze(time)

    assert_equal time, r.datetime
  end

  def test_shutdown_response_output
    r = Response.new
    output = r.shutdown(12)

    assert_equal "Total Requests: 12\n\n", output
  end

  def test_word_search_response_for_a_valid_word
    r = Response.new
    word = r.word_search("eggplant")

    assert_equal "EGGPLANT is a word!\n\n", word
  end

  def test_word_search_response_is_case_insensitive
    r = Response.new
    word = r.word_search("ExCELLent")

    assert_equal "EXCELLENT is a word!\n\n", word
  end

  def test_word_search_response_for_an_invalid_word
    r = Response.new
    word = r.word_search("Blarg")

    assert_equal "You are very bad at English.\n\n", word
  end

  def test_start_game_response
    r = Response.new
    output = r.start_game

    assert_equal "Good Luck!", output
  end

  def test_game_stats_response
    r = Response.new
    output = r.game_stats(4, 2, "too low")

    assert_equal "You have taken 4 guesses.\nYour Guess of 2 is too low.\n\n", output
  end

  def test_build_response_headers_method
    r = Response.new
    output = r.build_response_headers(43)
    time = Time.now.strftime('%a, %e %b %Y %H %M %S %z')
    Timecop.freeze(time)

    assert_equal ["http/1.1 200 ok",
                  "date: #{time}",
                  "server: ruby",
                  "content-type: text/html; charset=iso-8859-1",
                  "content-length: 43\r\n\r\n"].join("\r\n"), output
  end

end
