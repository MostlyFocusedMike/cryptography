RSpec::Expectations.configuration.on_potential_false_positives = :nothing

require_relative "../cipher.rb"

describe "cipher prep" do

  context "make cipher" do 
    before(:each) do 
      @machine = Encoder.new
    end 
    it "generates a number" do 
      expect(@machine.make_cipher.kind_of?(Integer)).to be true
    end
    it "makes a random number" do
      expect(@machine.make_cipher.class).to eq(Fixnum)
    end
    it "should never be0 or 26" do 
      nums = []
      10000.times {nums << @machine.make_cipher.to_s} 
      any_0_26 = nums.include?("26") || nums.include?("26") 
      expect(any_0_26).not_to be true
    end
  end

  context "convert string to array" do 
    before(:each) do 
      @machine = Encoder.new
    end 
    it "it should return an array" do
      str = "HelLo"
      expect(@machine.string_prep(str).kind_of?(Array)).to be true
    end
    it "should preserve spaces and punctuatuion" do
      str = "Hello there, friend!"
      expect(@machine.string_prep(str).join("")).to eq(str)
    end
  end

  
  context "capital test" do
    before(:each) do 
      @machine = Encoder.new
    end 
    it "should return true if a letter is capital" do
      expect(@machine.capital?("A")).to be true
    end
    it "should return false if letter is lowercase" do
      expect(@machine.capital?("a")).to be false
    end
    it "should return false if punctuation" do
      chars = [" ", ",", ".", "!","?","'","\"","1","0","(",")","{","}","[","]","<",">","/"]
      chars.each do |char|
        expect(@machine.capital?(char)).to be false
      end
    end
    it "should raise an error if given 2 args" do
      expect {@machine.capital?(1, "h")}.to raise_error(ArgumentError) 
    end

  end
 
  context "check if a non letter" do
    before(:each) do 
      @machine = Encoder.new
    end 
    it "should return true if punct" do
      chars = [" ", ",", ".", "!","?","'","\"","1","0","(",")","{","}","[","]","<",">","/"]
      chars.each do |char|
        expect(@machine.non_letter?(char)).to be true
      end
    end

    it "should return false if number" do
      expect(@machine.non_letter?(1)).to be true
      expect(@machine.non_letter?(0)).to be true
    end
    
    it "should return false if upperlower lettter" do
      expect(@machine.non_letter?("a")).to be false
      expect(@machine.non_letter?("A")).to be false
    end
  end

  context "looping tests" do
    before(:each) do 
      @machine = Encoder.new
    end 
    it "should be able to stay itself" do
      expect(@machine.scramble_letter("g",0)).to eq("g")  
    end
    it "should move one letter past the end" do
      expect(@machine.scramble_letter("z",1)).to eq("a")  
    end

    it "should be able to loop back to itself" do
      expect(@machine.scramble_letter("a",26)).to eq("a")  
    end

    it "should do multiple loops to itself" do
      expect(@machine.scramble_letter("a",52)).to eq("a")  
    end

    it "should do multiple loops past itself" do
      expect(@machine.scramble_letter("a",53)).to eq("b")  
    end
    it "should return capitals" do
      expect(@machine.scramble_letter("A",53)).to eq("B")  
    end
    it "should return lowercase" do
      expect(@machine.scramble_letter("a",53)).to eq("b")  
    end
    it "should return punctuation as is" do
      expect(@machine.scramble_letter(".", 0)).to eq(".")
    end
    it "should return punctuation as is even with move" do
      expect(@machine.scramble_letter(".", 0)).to eq(".")
    end

  end

  context "encode message" do 
    before(:each) do 
      @machine = Encoder.new
    end 
    it "should work with just a string argument" do
      expect {@machine.encode_msg("hey") }.not_to raise_error(ArgumentError)
    end
    it "should work with a string and cipher argument" do
      expect {@machine.encode_msg("hey", 3) }.not_to raise_error(ArgumentError)
    end
    it "should return a string" do
      @machine.msg = "hh"
      @machine.encode_user_msg
      expect(@machine.newly_encoded_msg.kind_of?(String)).to be true
    end
    it "should return a new message" do
      t_msg = "hello"
      @machine.msg = t_msg
      @machine.encode_user_msg
      expect(@machine.newly_encoded_msg).not_to eq(t_msg)
    end
    it "should return a new message of same length" do
      t_msg = "hello"
      @machine.msg = t_msg
      @machine.encode_user_msg
      expect(@machine.newly_encoded_msg.length).to eq(t_msg.length)
    end
    it "should return 'def' when given 'abc'' with cpher 3" do
      t_msg = "abc"
      @machine.msg = t_msg
      @machine.cipher = 3
      @machine.encode_user_msg
      expect(@machine.newly_encoded_msg).to eq("def")    
    end
    it "should conserve spaces in message" do
      t_msg = "abc def"
      @machine.msg = t_msg
      @machine.cipher = 0
      @machine.encode_user_msg
      expect(@machine.newly_encoded_msg).to eq("abc def") 
    end
    it "should conserve punctuiation" do
      t_msg = "Hello, there."
      @machine.msg = t_msg
      @machine.cipher = 0
      @machine.encode_user_msg
      expect(@machine.newly_encoded_msg).to eq("Hello, there.") 
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
      expect{@machine.roll_back_letter("b","b")}.to raise_error(ArgumentError)
      expect{@machine.roll_back_letter("b")}.not_to raise_error(ArgumentError)
    end 
    it "should move each letter back one spot" do
      expect(@machine.roll_back_letter("b")).to eq("a")
    end
    it "should leave non letters alone" do
      chars = [" ", ",", ".", "!","?","'","\"","1","0","(",")","{","}","[","]","<",">","/"]
      chars.each do |char|
        expect(@machine.roll_back_letter(char)).to eq(char)
      end
    end
    it "should match capital state" do
      expect(@machine.roll_back_letter("b")).to eq("a")
      expect(@machine.roll_back_letter("B")).to eq("A")
    end
  end

  context "descramble_encoded_msg" do
    before(:each) do
      @machine = Encoder.new
    end

    it "should take no arguments" do
      expect{@machine.roll_back_message("b")}.to raise_error(ArgumentError)
      expect{@machine.roll_back_message}.not_to raise_error(ArgumentError)
    end
    it "should return a string" do
      @machine.encoded_msg = "abc"
      @machine.roll_back_message
      puts @machine.newly_decoded_msg
      expect(@machine.newly_decoded_msg.class).to eq(String)
    end
    
    it "should move all letters back one spot" do
      @machine.encoded_msg = "bcd"
      @machine.roll_back_message
      expect(@machine.newly_decoded_msg).to eq("abc")
    end
    
    it "should leave capitalization alone" do 
      @machine.encoded_msg = "BbBbBb"
      @machine.roll_back_message
      expect(@machine.newly_decoded_msg).to eq("AaAaAa")
    end

    it "should leave punctuation and spaces alone" do
      @machine.encoded_msg = ". , ! ? $ / #"
      @machine.roll_back_message
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

  context "put message in matches or misses array" do 
    before(:each) do
      @machine = Encoder.new
    end
    it "machine should have matches and misses arrays" do
      expect(@machine.matches.is_a?(Array)).to be true
      expect(@machine.misses.is_a?(Array)).to be true
    end
  end

  context "word_count" do
    before(:each) do
      @machine = Encoder.new
    end
  end 

end


