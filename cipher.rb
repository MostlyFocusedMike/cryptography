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
  return [encoded_msg, cipher]
end
