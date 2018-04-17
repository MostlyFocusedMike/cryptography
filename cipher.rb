# def test_input
#   foo = gets.strip
#   return foo
# end
# def test_puts 
#   puts "hello there"
# end
# def test_print
#   print "hello there"
# end
# 
ALPHABET = ["a","b","c","d","e","f","g","h","i","j","k","l",
            "m","n",'o','p','q','r','s','t','u','v','w','x',
            'y','z']
def make_cipher
  return rand(1..25)
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

def encode_letter(letter, move)
  return letter if non_letter?(letter)
  index = ALPHABET.index(letter.downcase)
  move.times do
    index += 1 
    index = index > 25 ? 0 : index  
  end 
  return capital?(letter) ? ALPHABET[index].upcase : ALPHABET[index]
end

def encode_msg(msg, cipher=nil)
  cipher ||= make_cipher()
  plain_msg = string_prep(msg)
  encoded_msg = plain_msg.map do |char| 
    encode_letter(char,cipher)
  end.join("")
  return encoded_msg
end

def final_msg(msg, cipher)
  puts "#{msg}\n\tcipher: #{cipher}\n"
end


class Encoder
  ALPHABET = ["a","b","c","d","e","f","g","h","i","j","k","l",
            "m","n",'o','p','q','r','s','t','u','v','w','x',
            'y','z']
  attr_accessor :cipher 
  def initialize
    self.make_cipher
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

  def encode_letter(letter, move)
    return letter if non_letter?(letter)
    index = ALPHABET.index(letter.downcase)
    move.times do
      index += 1 
      index = index > 25 ? 0 : index  
    end 
    return capital?(letter) ? ALPHABET[index].upcase : ALPHABET[index]
  end

  def scramble_msg(msg)
    plain_msg = string_prep(msg)
    encoded_msg = plain_msg.map do |char| 
      encode_letter(char,@cipher)
    end.join("")
    return encoded_msg
  end

  # basically the "run" method of the class
  def encode(msg, cipher=nil)
    @cipher = cipher || @cipher
    encoded_msg = scramble_msg(msg)
    puts "#{encoded_msg}\n\tcipher: #{@cipher}"
  end


end



