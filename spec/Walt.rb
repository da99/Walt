
describe "Walt" do
  
  it "parses example from README.md" do
    Walt(%@
    This is a line.
    This is a line with a block:
      
      I am a block.


    @).should == [ 
      [ "This is a line.", nil],
      [ "This is a line with a block", "  I am a block."]
    ]
  end

  it "parses lines" do
    Walt(%@
      This is A.
      This is B.
    @).should == [["This is A.", nil], ["This is B.", nil]]
  end

  it "parses blocks surrounded by empty lines of spaces with irregular indentation." do
    Walt(%@
      This is A.
      This is B:
          
        Block
       
    @).should == [["This is A.", nil], ["This is B", "  Block"] ]
  end
  
  it "removes empty lines surrounding block" do
    Walt(%@
      This is A.
      This is B:
          
        Block line 1.
        Block line 2.
       
    @).should == [["This is A.", nil], ["This is B", "  Block line 1.\n  Block line 2."] ]
  end
  
  it "does not remove last colon if line has no block." do
    Walt(%@
      This is A.
      This is :memory:
      This is B.
    @).should == ["This is A.", "This is :memory:", "This is B."].zip([nil, nil, nil])
  end

end # === Walt

