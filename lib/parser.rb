require 'pry'

class Parser

  def initialize(client)
    @client = client
  end

  def parse_request
    counter = 0
    info = Hash.new
    while line = @client.gets and !line.chomp.empty?
        if counter == 0
          info["Verb"] = line.split(" ").first
          info["Path"] = line.split(" ")[1]
          #info["Param"] =
          #info["Value"]
          info["Protocol"] = line.split(" ")[2]
        else
          keyval = line.scan(/([^:]*):(.*$)/)
          info[keyval[0][0]] = keyval[0][1]
        end
        counter += 1
      end
    info
  end

  def verb
    parse_request["Verb"]
  end

  def path
    parse_request["Path"]
  end

end
