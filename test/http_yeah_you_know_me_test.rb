require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http_yeah_you_know_me'

class HttpYeahYouKnowMeTest < Minitest::Test

  def test_build_response_method_outputs_diagnostics_correctly
    http = HttpYeahYouKnowMe.new(9292)
    request_lines = ["POST / HTTP/1.1",
                     "Host: 127.0.0.1:9292",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
                     "Accept-Language: en-us",
                     "Connection: keep-alive",
                     "Accept-Encoding: gzip, deflate",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/601.2.7 (KHTML, like Gecko) Version/9.0.1 Safari/601.2.7"]
    expected =       "<pre>\n" +
                     "Verb: POST\n" +
                     "Path: /\n" +
                     "Protocol: HTTP/1.1\n" +
                     "Host: 127.0.0.1\n" +
                     "Port: 9292\n" +
                     "Origin: 127.0.0.1\n" +
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8\n" +
                     "</pre>"

    assert_equal expected, http.build_response_body(0, request_lines)
  end

end
