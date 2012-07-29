
describe "Walt parsing sentences" do
  
  it "multiple sentences." do
    Walt(%@
    This is a line.
    This is another line.
    @).should == [ 
      [ "This is a line.", nil],
      [ "This is another line.", nil]
    ]
  end
  
  it "sentences continued on another line" do
    Walt(%@
    This is a line.
    This is a 
      continued line.
    @).should == [ 
      [ "This is a line.", nil],
      [ "This is a    continued line.", nil]
    ]
  end

  it "multiple sentences separated by whitespace lines." do
    Walt(%@
    This is a line.
       
    This is line 2.
              
    This is line 3.
         
    @).should == [ 
      [ "This is a line.", nil],
      [ "This is line 2.", nil],
      [ "This is line 3.", nil],
    ]
  end

end # === Walt sentences

describe "Walt blocks" do

  it "parses blocks surrounded by empty lines of spaces with irregular indentation." do
    Walt(%@
      This is A.
      This is B:
          
        Block
       
    @).should == [["This is A.", nil], ["This is B:", "  Block"] ]
  end
  
  it "removes empty lines surrounding block" do
    Walt(%@
      This is A.
      This is B:
          
        Block line 1.
        Block line 2.
       
    @).should == [["This is A.", nil], ["This is B:", "  Block line 1.\n  Block line 2."] ]
  end
  
  it "does not remove last colon if line has no block." do
    Walt(%@
      This is A.
      This is :memory:
      This is B.
    @).should == ["This is A.", "This is :memory:", "This is B."].zip([nil, '', nil])
  end

end # === Walt blocks

describe "Walt raising Parse_Error" do
  
  it "if incomplete sentence is found" do
    lambda {
      Walt(%@
        This is one line.
        This is an incomp sent
      @)
    }.should.raise(Walt::Parse_Error)
    .message.should.match %r!incomp sent!
  end

  it "if incomplete sentence is found before start of a block" do
    lambda {
      Walt(%@
        This is one line.
        This is an incomp sent
        This is a block:
          Block
      @)
    }.should.raise(Walt::Parse_Error)
    .message.should.match %r!incomp sent\Z!
  end
  
end # === Walt parsing errors

