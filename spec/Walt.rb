
describe "Walt" do
  
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
       
    @).should == [["This is A.", nil], ["This is B", "  Block\n "] ]
  end
  
  it "does not remove last colon if line has no block." do
    Walt(%@
      This is A.
      This is :memory:
      This is B.
    @).should == ["This is A.", "This is :memory:", "This is B."].zip([nil, nil, nil])
  end
  
end # === Walt

