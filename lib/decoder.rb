class Decoder < Base
  attr_accessor  :rolled_back_msg, :matches, :fin_decoded_msg
  def initialize
    @matches = []
  end

  def get_user_encoded_msg
    @encoded_msg = gets.strip
  end

  def roll_back_message
    encoded_array = string_prep(@encoded_msg)
    @rolled_back_msg = encoded_array.map do |char|
      roll_back_letter(char,1)
    end.join("")
  end

  def has_words? 
    @rolled_back_msg.split.any? do |word|
      word = word.match(/\b(\w+)\b/)[0]
      COMMON_WORDS.include?(word.downcase)
    end
  end

  def count_words 
    @rolled_back_msg.split.count do |word|
      word = word.match(/\b(\w+)\b/)[0]
      COMMON_WORDS.include?(word.downcase) 
    end
  end

  def sort_phrase
    if self.has_words?
      wc = self.count_words
      self.matches.push({msg: @rolled_back_msg, wc: wc})
    end
  end 

  def fill_matches_misses
    25.times do 
      self.roll_back_message
      self.sort_phrase
      @encoded_msg = @rolled_back_msg
    end
  end

  def sort_matches
    self.matches.sort_by {|match| match[:wc]}
  end

  def decode_user_msg
    @encoded_msg ||= self.get_user_encoded_msg
    self.fill_matches_misses
    self.fin_decoded_msg = self.sort_matches[-1][:msg]
  end

end
