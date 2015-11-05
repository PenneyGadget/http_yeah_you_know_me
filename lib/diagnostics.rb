class Diagnostics

  def output_diagnostics(request)
    response = "<pre>"
    request.each do |key, value|
      if key != "Param" && key != "Value"
        response += "#{key}" + ": " + "#{value}\n"
      end
    end
    response += "</pre>"
    response
  end

end
