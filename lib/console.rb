def run
  print "Enter your message here: "
  encoder = Encoder.new 
  decoder = Decoder.new
  encoder.encode_user_msg
  encoder.show_encoded_msg
  decoder.decode_user_msg
  puts decoder.fin_decoded_msg
end
