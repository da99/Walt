require 'Walt/version'
require 'Split_Lines'
require 'indentation'

module Kernel

  private

  WALT_HEAD_WHITE_SPACE = %r!\A\s!
  def Walt str
    lines = str.reset_indentation.split("\n")

    i = -1
    in_block = false
    arr = []
    while i < lines.size-1 do
      i+=1

      next if lines[i].strip.empty? && !in_block

      if lines[i].index(WALT_HEAD_WHITE_SPACE) == 0  || lines[i].empty?
        
        if in_block
          # do nothing. all set.
        else
          arr.last[0] = arr.last[0].sub(%r!:\Z!, '')
          in_block = arr.last
          in_block[1] = []
        end
        
        in_block[1] << lines[i]

      else
        in_block = nil
        arr << [ lines[i], nil ]
        
      end # === if
      
    end # === while


    arr.map { |pair|
      
      first = pair.first
      last  = pair.last
      
      if last
        last = last.join("\n")
      end
      
      [ first, last ]
    }
  end
  
end # === Kernel
