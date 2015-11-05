
class Parser

  def parse_request(client)
    counter = 0
    info = Hash.new
    while line = client.gets and !line.chomp.empty?
        if counter == 0
          info["Verb"] = line.split(" ").first
          info["Path"] = line.split(" ")[1]
          info["Protocol"] = line.split(" ")[2]
        else
          keyval = line.scan(/([^:]*):(.*$)/)
          info[keyval[0][0]] = keyval[0][1]
        end
        counter += 1
      end
    info
  end

end
