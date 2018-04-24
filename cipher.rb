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
class Encoder
  ALPHABET = ["a","b","c","d","e","f","g","h","i","j","k","l",
            "m","n",'o','p','q','r','s','t','u','v','w','x',
            'y','z']
  COMMON_WORDS = ["a", "about", "all", "also", "and", "as", "at", "be", "because", "but", 
                  "by", "can", "come", "could", "day", "do", "even", "find", "first", "for", 
                  "from", "get", "give", "go", "have", "he", "her", "here", "him", "his", 
                  "how", "I", "if", "in", "into", "it", "its", "just", "know", "like", "look", 
                  "make", "man", "many", "me", "more", "my", "new", "no", "not", "now", "of", 
                  "on", "one", "only", "or", "other", "our", "out", "people", "say", "see", 
                  "she", "so", "some", "take", "tell", "than", "that", "the", "their", "them", 
                  "then", "there", "these", "they", "thing", "think", "this", "those", "time", 
                  "to", "two", "up", "use", "very", "want", "way", "we", "well", "what", 
                  "when", "which", "who", "will", "with", "would", "year", "you", "your"]

  attr_accessor :cipher, :msg, :encoded_msg, :newly_decoded_msg, :pos_matches, :rejects
  def initialize
    self.make_cipher
    @pos_matches = @rejects = []
  end
  def get_user_msg
    @msg = gets.strip
  end

  def get_user_encoded_msg
    @encoded_msg = gets.strip
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

  # scramble refers to internal encoding and decoding, while encode and decode are
  # reserved for functions that actually interact with the user 
  # and msg and encoded_msg refer to user entered input, while newly_encoded_msg and 
  # newly_decoded_msg refer to encrypted and decrypted messages generated by functions 

  def scramble_letter(letter, move)
    return letter if non_letter?(letter)
    index = ALPHABET.index(letter.downcase)
    move.times do
      index += 1 
      index = index > 25 ? 0 : index  
    end 
    return capital?(letter) ? ALPHABET[index].upcase : ALPHABET[index]
  end

  def descramble_letter(letter)
    return letter if non_letter?(letter)
    index = ALPHABET.index(letter.downcase)
    index -= 1 
    index = index < 0 ? 25 : index  
    return capital?(letter) ? ALPHABET[index].upcase : ALPHABET[index]
  end

  def scramble_msg
    msg_array = string_prep(@msg)
    @newly_encoded_msg = msg_array.map do |char| 
      scramble_letter(char,@cipher)
    end.join("")
  end

  def descramble_msg
    encoded_array = string_prep(@encoded_msg)
    @newly_decoded_msg = encoded_array.map do |char|
      descramble_letter(char)
    end.join("")
  end

  def has_words? 
    # returns true if any eng
    @newly_decoded_msg.split.any? do |word|
      word = word.match(/\b(\w+)\b/)[0]
      COMMON_WORDS.include?(word.downcase)
    end
  end

  def word_count
    @newly_decoded_msg.split.map do |word|
      if COMMON_WORDS.include?(word.downcase)
        1
      else
       0
      end 
    end.reduce(0, :+)

  end
  def sort_decoded_msgs
   if has_words? 
     @pos_matches << @newly_decoded_msg
   else
     @rejects << @newly_decoded_msg
   end
  end


  # basically the "run" method of the class
  def encode_user_msg
    # these two are either generated at this point, or accept 
    # previously given values to aid with testing
    @msg ||= self.get_user_msg 
    @cipher ||= self.make_cipher
    self.scramble_msg
    puts "#{@newly_encoded_msg}\n\tcipher: #{@cipher}"
  end

  def decode_user_msg
    @encoded_msg ||= self.get_user_encoded_msg
  end


end

def run
  print "Enter your message here: "
  encoder = Encoder.new 
  encoder.encode_user_msg
end































# initial procedural functions
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


