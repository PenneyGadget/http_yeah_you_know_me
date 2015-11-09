class Diagnostics

  def hidden_keys
    %w(Param Value)
  end

  def output_diagnostics(request)
    response = "<pre>\n"

    request.each do |key, value|
      unless hidden_keys.include?(key)
        response += "  #{key}: #{value}\n"
      end
    end

    response += "</pre>"
    response
  end

end
