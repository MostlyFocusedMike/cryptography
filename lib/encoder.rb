class Encoder < Base
  attr_accessor :cipher, :msg, :encoded_msg, :encoded_msg
  def initialize
    self.make_cipher
  end
   def get_user_msg
     @msg = gets.strip
   end

   def make_cipher
     @cipher = rand(1..25)
   end

  def string_prep(str) 
    return str.split("")
  end

   def capital?(letter)
     return /[[:upper:]]/.match(letter) ? true : false
   end

  def non_letter?(letter)
    return /[[a-zA-Z]]/.match(letter.to_s) ? false : true 
  end

  def scramble_msg
    msg_array = string_prep(@msg)
    @encoded_msg = msg_array.map do |char| 
      roll_back_letter(char,@cipher)
    end.join("")
  end

  def encode_user_msg
    # these two are either generated at this point, or accept 
    # previously given values to aid with testing
    @msg ||= self.get_user_msg 
    @cipher ||= self.make_cipher
    self.scramble_msg
  end

  def show_encoded_msg
    puts "#{@encoded_msg}\ncipher: #{@cipher}"
  end
end 
