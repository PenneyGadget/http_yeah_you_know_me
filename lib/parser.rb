
class Parser

  def parse_request(client)
    counter = 0
    info = Hash.new
    while line = client.gets and !line.chomp.empty?
        if counter == 0
          info["Verb"] = line.split(" ").first
          path = line.split(" ")[1]
          components = path.scan(/([^\?]*)\??([^=]*)=?(.*)/)
          #[["word", "Hello"], ["param2", "value2"], ["param3", "value3"]]
          info["Path"] = components[0][0]
          info["Param"] = components[0][1]
          info["Value"] = components[0][2]

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
