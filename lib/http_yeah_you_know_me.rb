require 'pry'
require 'socket'

class HttpYeahYouKnowMe

  def initialize(port)
    @server = TCPServer.new(port)
    # @path = "#{request_lines.first.split(" ")[1]}\n"
  end

  def run
    request_counter = 0
    loop do
      client = @server.accept
      request_lines = parse_request(client)
      request_counter += 1
      output = build_response_body(request_counter, parse_request_info(request_lines))
      headers = build_response_headers(output)
      return_response(client, headers, output)
    end
    client.close
  end

  def parse_request(client)
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    request_lines
  end

  def parse_request_info(request_lines)
    info = Hash.new
    info["Verb: "] = request_lines.first.split(" ").first
    info["Path: "] = request_lines.first.split(" ")[1]
    info["Protocol: "] = request_lines.first.split(" ")[2]

    request_lines.each do |line|
      if line.start_with?("Host")
        info["Host: "] = line.split(":")[1]
      end
    end

    request_lines.each do |line|
      if line.start_with?("Host")
        info["Port: "] = line.split(":")[-1]
      end
    end

    request_lines.each do |line|
      if line.start_with?("Host")
        info["Origin: "] = line.split(":")[1]
      end
    end

    request_lines.each do |line|
      if line.start_with?("Accept: ")
        info["Accept: "] = line.split(" ")[1]
      end
    end
    info
  end

  def choose_path

  end

  def build_response_body(request_counter, clean_request_info)
    response = "<pre>" + ("Hello, World! (#{request_counter})\n\n#{parse_request_info}") + "</pre>"
    output = "<html><head></head><body>#{response}</body></html>"
  end

  def build_response_headers(output)
    ["http/1.1 200 ok",
     "date: #{Time.now.strftime('%a, %e %b %Y %H %M %S %z')}",
     "server: ruby",
     "content-type: text/html; charset=iso-8859-1",
      "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def return_response(client, headers, output)
    client.puts headers
    client.puts output
  end

end


if __FILE__ == $0
  server = HttpYeahYouKnowMe.new(9292)
  server.run
end
