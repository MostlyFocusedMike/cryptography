RSpec::Expectations.configuration.on_potential_false_positives = :nothing
#  context "input test" do
#    it "should return what is given" do
#      expect(self).to receive(:gets).and_return("bar")
#      expect(test_input).to eq("bar")
#    end
#
#  end
#
#  context "output tests" do
#    it "should check puts is ok" do
#      expect($stdout).to receive(:puts).with("hello there")
#      test_puts
#    end
#    it "should check puts is ok new version" do
#      expect{test_puts}.to output("hello there\n").to_stdout
#    end
#    it "should check print is ok new version" do
#      expect{test_print}.to output("hello there").to_stdout
#    end
#
#  end
require_relative "../cipher.rb"
           # expect(sa.has_vowels? test_string).to be false

describe "cipher prep" do

  context "make cipher" do 
    it "generates a number" do 
      expect(make_cipher.kind_of?(Integer)).to be true
    end
    it "makes a random number" do
      expect(make_cipher.class).to eq(Fixnum)
    end
    it "should never be0 or 26" do 
      nums = []
      10000.times {nums << make_cipher.to_s} 
      any_0_26 = nums.include?("26") || nums.include?("26") 
      expect(any_0_26).not_to be true
    end
  end

  context "convert string to array" do 
    it "it should return an array" do
      str = "HelLo"
      expect(string_prep(str).kind_of?(Array)).to be true
    end
    it "should preserve spaces and punctuatuion" do
      str = "Hello there, friend!"
      expect(string_prep(str).join("")).to eq(str)
    end
  end

  
  context "capital test" do
    it "should return true if a letter is capital" do
      expect(capital?("A")).to be true
    end
    it "should return false if letter is lowercase" do
      expect(capital?("a")).to be false
    end
    it "should return false if punctuation" do
      chars = [" ", ",", ".", "!","?","'","\"","1","0","(",")","{","}","[","]","<",">","/"]
      chars.each do |char|
        expect(capital?(char)).to be false
      end
    end
    it "should raise an error if given 2 args" do
      expect {capital?(1, "h")}.to raise_error(ArgumentError) 
    end

  end
 
  context "check if a non letter" do
    it "should return true if punct" do
      chars = [" ", ",", ".", "!","?","'","\"","1","0","(",")","{","}","[","]","<",">","/"]
      chars.each do |char|
        expect(non_letter?(char)).to be true
      end
    end

    it "should return false if number" do
      expect(non_letter?(1)).to be true
      expect(non_letter?(0)).to be true
    end
    
    it "should return false if upperlower lettter" do
      expect(non_letter?("a")).to be false
      expect(non_letter?("A")).to be false
    end
  end

  context "looping tests" do
    it "should be able to stay itself" do
      expect(encode_letter("g",0)).to eq("g")  
    end
    it "should move one letter past the end" do
      expect(encode_letter("z",1)).to eq("a")  
    end

    it "should be able to loop back to itself" do
      expect(encode_letter("a",26)).to eq("a")  
    end

    it "should do multiple loops to itself" do
      expect(encode_letter("a",52)).to eq("a")  
    end

    it "should do multiple loops past itself" do
      expect(encode_letter("a",53)).to eq("b")  
    end
    it "should return capitals" do
      expect(encode_letter("A",53)).to eq("B")  
    end
    it "should return lowercase" do
      expect(encode_letter("a",53)).to eq("b")  
    end
    it "should return punctuation as is" do
      expect(encode_letter(".", 0)).to eq(".")
    end
    it "should return punctuation as is even with move" do
      expect(encode_letter(".", 0)).to eq(".")
    end

  end

  context "encode message" do 
    it "should work with just a string argument" do
      expect {encode_msg("hey") }.not_to raise_error(ArgumentError)
    end
    it "should work with a string and cipher argument" do
      expect {encode_msg("hey", 3) }.not_to raise_error(ArgumentError)
    end
    it "should return a string" do
      expect(encode_msg("hh").kind_of?(String)).to be true
    end
    it "should return a new message" do
      msg = "hello"
      expect(encode_msg(msg)).not_to eq(msg)
    end
    it "should return a new message of same length" do
      msg = "hello"

      expect(encode_msg(msg).length).to eq(msg.length)
    end
    it "should return 'def' when given 'abc'' with cpher 3" do
      expect(encode_msg("abc", 3)).to eq("def")
    end
    it "should conserve spaces in message" do
      msg = "Hello there"
      expect(encode_msg(msg, 0)).to eq("Hello there")
    end
    it "should conserve punctuiation" do
      msg = "Hello, there."
      expect(encode_msg(msg, 0)).to eq(msg)
    end

  end

  context "final message format" do
    it "should take a string and integer" do 
      expect{ final_msg("hey", 1)}.not_to raise_error(ArgumentError)
    end
    it "should output a string" do
      expect{final_msg("hey", 1)}.to output("hey\n\tcipher: 1\n").to_stdout
    end
  end

  context "encoder class" do
    before(:each) do
      @machine = Encoder.new
      @machine.msg = "abc"
      @machine.cipher = 3
    end
    it "should use a class to encode a msg" do
      expect {@machine.encode_user_msg}.to output("def\n\tcipher: 3\n").to_stdout
    end
    it "should work without a defined cipher" do
      new_machine = Encoder.new
      new_machine.msg = "abc"
      expect{@machine.encode_user_msg}.to output(/[a-z]{3}\s+cipher: \d*/).to_stdout
    end




  end

  context "run test" do
    it "should take a gets" do
      machine = Encoder.new
      expect(machine).to receive(:gets).and_return("abc")
      expect{machine.encode_user_msg}.to output(/[a-z]{3}\s+cipher: \d*/).to_stdout
    end
  end  

end




# take in a string
#
# chop that string into an array
#
# move each letter  one place over
#
# if the char is not a letter, do nothing
#
# join the new array into a string
#
# check if new string contains any of the basic words
#
# if so, add it to an array, "pos matches" 
#
# if not, ignore it
#
# repeat steps with the new string
#
# continue for 25 times
#
# of the pos matches array, check how many words are in each
#
# return the one with the most matches
#
# as well as an array of all the pos matches, in order as well


describe "descramble message" do
  context "getting user encoded msg" do
    before(:each) do
      @machine = Encoder.new
    end
    it "get user encoded message should get input to set message" do
      allow(@machine).to receive(:gets).and_return("bar")
      @machine.get_user_encoded_msg
      expect(@machine.encoded_msg).to eq("bar") 
    end
    it "should take an encoded msg by variable assignment" do
      @machine.encoded_msg = "bar"
      expect(@machine.encoded_msg).to eq("bar") 
    end
  end

  context "descramble letter" do 
    before(:each) do
      @machine = Encoder.new
    end
    it "should only take one argument" do 
      expect{@machine.descramble_letter("b","b")}.to raise_error(ArgumentError)
      expect{@machine.descramble_letter("b")}.not_to raise_error(ArgumentError)
    end 
    it "should move each letter back one spot" do
      expect(@machine.descramble_letter("b")).to eq("a")
    end
    it "should leave non letters alone" do
      chars = [" ", ",", ".", "!","?","'","\"","1","0","(",")","{","}","[","]","<",">","/"]
      chars.each do |char|
        expect(@machine.descramble_letter(char)).to eq(char)
      end
    end
    it "should match capital state" do
      expect(@machine.descramble_letter("b")).to eq("a")
      expect(@machine.descramble_letter("B")).to eq("A")
    end
  end

  context "descramble_encoded_msg" do
    before(:each) do
      @machine = Encoder.new
    end

    it "should take no arguments" do
      expect{@machine.descramble_msg("b")}.to raise_error(ArgumentError)
      expect{@machine.descramble_msg}.not_to raise_error(ArgumentError)
    end
    it "should return a string" do
      @machine.encoded_msg = "abc"
      @machine.descramble_msg
      puts @machine.newly_decoded_msg
      expect(@machine.newly_decoded_msg.class).to eq(String)
    end
    
    it "should move all letters back one spot" do
      @machine.encoded_msg = "bcd"
      @machine.descramble_msg
      expect(@machine.newly_decoded_msg).to eq("abc")
    end
    
    it "should leave capitalization alone" do 
      @machine.encoded_msg = "BbBbBb"
      @machine.descramble_msg
      expect(@machine.newly_decoded_msg).to eq("AaAaAa")
    end

    it "should leave punctuation and spaces alone" do
      @machine.encoded_msg = ". , ! ? $ / #"
      @machine.descramble_msg
      expect(@machine.newly_decoded_msg).to eq(". , ! ? $ / #")
    end
  end

end

describe "sorting descrambled messages" do
  context "has words?" do
    before(:each) do
      @machine = Encoder.new
    end
    it "returns true when english words are present" do
      @machine.newly_decoded_msg = "about all also a"
      expect(@machine.has_words?).to be true
    end
    it "returns false when no english words are present" do
      @machine.newly_decoded_msg = "asdd jgoo asddee helloooooo"
      expect(@machine.has_words?).to be false
    end
    it "returns true when english words are present and capitalized" do
      @machine.newly_decoded_msg = "About All Also"
      expect(@machine.has_words?).to be true
    end
    it "returns true when english words are present and connected to punctuation" do
      tricky_words = ["a.", "a,","a/","a<","a>",".a","\"a","'a"]
      tricky_words.each do |word|
        @machine.newly_decoded_msg = word
        expect(@machine.has_words?).to be true
      end
    end
    it "returns false when face with numbers" do
      @machine.newly_decoded_msg = "1 2 3 4 1994"
      expect(@machine.has_words?).to be false
    end
  end

  context "put message in matches or no matches array" do 
    before(:each) do
      @machine = Encoder.new
    end
    it "machine should have pos_matches and rejects arrays" do
      expect(@machine.pos_matches.is_a?(Array)).to be true
      expect(@machine.rejects.is_a?(Array)).to be true
    end
    it "should add strings with english words into pos_matches" do
      @machine.newly_decoded_msg = "All about a" 
      @machine.sort_decoded_msgs
      expect(@machine.pos_matches.length).to eq(1)
    end
    it "should add strings with no english words into rejects" do
      @machine.newly_decoded_msg = "asdfa fasdgfag asdfa s"
      @machine.sort_decoded_msgs
      expect(@machine.rejects.length).to eq(1)
    end

  end

  context "word_count" do
    before(:each) do
      @machine = Encoder.new
    end
    it "should return an int" do
       @machine.newly_decoded_msg = "All about a" 
       expect(@machine.word_count.is_a?(Fixnum)).to be true
    end
    it "should return the number of words in a string" do
       @machine.newly_decoded_msg = "All about a" 
       expect(@machine.word_count).to eq(3)
    end
    it "should ignore non english words" do
       @machine.newly_decoded_msg = "gh alsdj kasd" 
       expect(@machine.word_count).to eq(0)
    end
    it "should count english words while ignoring non english words" do
       @machine.newly_decoded_msg = "gh alsdj for this kasd" 
       expect(@machine.word_count).to eq(2)
    end
  end

end


