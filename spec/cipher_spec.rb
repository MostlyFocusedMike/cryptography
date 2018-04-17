
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
    it "should use a class to encode a msg" do
      machine = Encoder.new
      expect {machine.encode("abc", 3)}.to output("def\n\tcipher: 3\n").to_stdout
    end

  end
end

