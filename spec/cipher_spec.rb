require_relative "../cipher.rb"
           # expect(sa.has_vowels? test_string).to be false

describe "cipher prep" do

  context "make cipher" do
    it "generates a number" do 
      expect(make_cipher.kind_of?(Integer)).to be true
    end
    it "makes a random number" do
      expect(make_cipher).not_to eq(make_cipher)
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
      expect(capital?(".")).to be false
      expect(capital?(",")).to be false
      expect(capital?("!")).to be false
      expect(capital?("?")).to be false
      expect(capital?("$")).to be false
      expect(capital?('"')).to be false
      expect(capital?("'")).to be false
      expect(capital?("/")).to be false
    end
    it "should raise an error if given 2 args" do
      expect {capital?(1, "h")}.to raise_error(ArgumentError) 
    end

  end
 
  context "check if a non letter" do
    it "should return true if punct" do
      expect(non_letter?(".")).to be true
      expect(non_letter?(" ")).to be true
      expect(non_letter?(",")).to be true
      expect(non_letter?("!")).to be true
      expect(non_letter?("?")).to be true
      expect(non_letter?("$")).to be true
      expect(non_letter?('"')).to be true
      expect(non_letter?("'")).to be true
      expect(non_letter?("/")).to be true
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
      expect {encode_msgi("hey") }.not_to raise_error(ArgumentError)
    end
    it "should work with a string and cipher argument" do
      expect {encode_msgi("hey", 3) }.not_to raise_error(ArgumentError)
    end
    it "should return an array" do
      expect(encode_msg("hh").kind_of?(Array)).to be true
    end
    it "should have a string in the first index" do
      expect(encode_msg("hh")[0].kind_of?(String)).to be true
    end
    it "should have an int in the 2nd index" do
      expect(encode_msg("hh")[1].kind_of?(Integer)).to be true
    end
    it "should return a new message" do
      msg = "hello"
      expect(encode_msg(msg)[0]).not_to eq(msg)
    end
    it "should return a new message of same length" do
      msg = "hello"

      expect(encode_msg(msg)[0].length).to eq(msg.length)
    end
    it "should return 'def' when given 'abc'' with cpher 3" do
      expect(encode_msg("abc", 3)[0]).to eq("def")
    end
    it "should conserve spaces in message" do
      msg = "Hello there"
      expect(encode_msg(msg, 0)[0]).to eq("Hello there")
    end
    it "should conserve punctuiation" do
      msg = "Hello, there."
      expect(encode_msg(msg, 0)[0]).to eq(msg)
    end

  end

end

