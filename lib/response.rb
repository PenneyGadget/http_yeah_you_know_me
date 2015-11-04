
class Response

  def initialize(request_lines)
    @request_lines = request_lines
    @content_length = 0
  end

  def build_response
    body = build_response_body
    headers = build_response_headers
    output = headers + body
  end

  def build_response_body
    response = "<pre>"

    case @request_lines["Path"]
      when "/"
        #do nothing
      #when "/word_search"
        #search through dictionary
        #response += dictionary_search(parse_request["Value"])
      when "/hello"
        response += "Hello, World! (#{$hello_requests})\n\n"
        $hello_requests += 1
      when "/datetime"
        response += Time.now.strftime("%I:%M%p on %A, %B %e, %Y") + "\n\n"
      when "/shutdown"
        response += "Total Requests: #{$all_requests}\n\n"
        $do_shutdown = true
      else
        response += "ERROR: Path not found."
    end

    @request_lines.each do |key, value|
      response += "#{key}" + ": " + "#{value}\n"
    end

    response += "</pre>"
    response = "<html><head></head><body>#{response}</body></html>"
    @content_length = response.length
    response
  end

  def build_response_headers
    ["http/1.1 200 ok",
     "date: #{Time.now.strftime('%a, %e %b %Y %H %M %S %z')}",
     "server: ruby",
     "content-type: text/html; charset=iso-8859-1",
     "content-length: #{@content_length}\r\n\r\n"].join("\r\n")
  end

end
