xml.instruct!
xml.Response do
    xml.Gather(:action => @post_to, :numDigits => 1) do
      xml.Say "@sometext"
      xml.Say "Please press 1 to repeat this menu. Press 2 for directions. Or press 3 if you are done."
    end
end


