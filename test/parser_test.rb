require 'minitest/autorun'
require 'minitest/pride'
require 'stringio'
require_relative '../lib/parser'

class ParserTest < Minitest::Test

  def test_parse_request_parses_the_first_line_correctly
    client = StringIO.new("GET / HTTP/1.1")
    parse = Parser.new(client)

    assert_equal({"Verb"=>"GET",
                  "Path"=>"/",
                  "Protocol"=>"HTTP/1.1"}, parse.parse_request)
  end

  def test_parse_request_method_formats_diagnostics_correctly
    skip
    http = HttpYeahYouKnowMe.new(9292)
    request_lines = ["GET / HTTP/1.1",
                      "Host: 127.0.0.1:9292",
                      "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
                      "Accept-Language: en-us",
                      "Connection: keep-alive",
                      "Accept-Encoding: gzip, deflate",
                      "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/601.2.7 (KHTML, like Gecko) Version/9.0.1 Safari/601.2.7"
                    ]
    # client = StringIO.new(request_lines)
    expected =       "Verb: GET\n" +
                     "Path: /\n" +
                     "Protocol: HTTP/1.1\n" +
                     "Host: 127.0.0.1\n" +
                     "Port: 9292\n" +
                     "Origin: 127.0.0.1\n" +
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\n"

    assert_equal expected, http.parse_request(request_lines)
  end

  def test_we_can_extricate_the_verb

  end

  def test_we_can_extricate_the_path

  end

end
