require 'Walt/version'
require 'Split_Lines'
require 'indentation'

class Walt
  
  Parse_Error = Class.new(RuntimeError)

  def initialize 
    @lines = []
  end

  def last_line 
    @lines.last && @lines.last[0]
  end

  def last_block
    @lines.last && @lines.last[1]
  end

  def append_to_line l
    @lines.last[0] = last_line + " " + l
  end

  def append_to_block l
    @lines.last[1] << l
  end

  def push_new_line l
    pair = if start_of_block?(l)
             [l, []]
           else
             [l, nil]
           end
    @lines << pair
  end

  def array
    @lines
  end

  def in_sentence?
    return false if last_line.nil?
    return false if in_block?
    l = last_line.strip
    period_index = l.index(WALT_END_PERIOD) 
    return true if period_index.nil?
    !( period_index == (l.size - 1) )
  end
  
  def in_block?
    !last_block.nil?
  end

  def start_of_block?(line)
    l = line.strip
    l.index(WALT_END_COLON) == (l.size - 1)
  end

  def full_sentence? line
    l = line.strip
    l.index(WALT_END_PERIOD) == (l.size - 1)
  end

end # === Walt

module Kernel

  private

  WALT_HEAD_WHITE_SPACE = %r!\A\s!
  WALT_END_PERIOD = %r!\.\Z!
  WALT_END_COLON  = %r!\:\Z!
  
  def Walt str
    lines = str.reset_indentation.split("\n")
    i     = -1
    walt  = Walt.new
    
    while i < lines.size-1 do
      i+=1
      line = lines[i]
      l    = line.strip

      next if l.empty? && !walt.in_block?

      begins_with_whitespace = line.index(WALT_HEAD_WHITE_SPACE) == 0
      if walt.in_block? && (begins_with_whitespace || l.empty?)
        walt.append_to_block( line )
        next
      end

      if !walt.in_sentence? && ( walt.start_of_block?(l) || walt.full_sentence?(l) )
        walt.push_new_line line
        next
      end # start of block check
      
      # Are we continuing a previous sentence?
      if walt.in_sentence? 
        # See if sentence ends or continues.
        walt.append_to_line( line )
        next
      end

      if !walt.in_block? && !walt.full_sentence?(l)
        walt.push_new_line( line )
        next
      end

      raise(Walt::Parse_Error, "Unknown fragment: #{line}")
      
    end # === while

    if walt.in_sentence?
      raise Walt::Parse_Error, "Incomplete sentence: #{walt.last_line}"
    end

    walt.array.map { |pair|
      
      first = pair.first
      last  = pair.last
      
      # Remove first and last empty lines, if block.
      if last
        last.shift if last.first && last.first.strip.empty?
        last.pop   if last.last  && last.last.strip.empty?
        last = last.join("\n")
      end
      
      [ first, last ]
    }
  end
  
end # === Kernel
