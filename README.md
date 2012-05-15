
Walt
================

A Ruby gem providing simple line and blockquote parsing (w/o paragraphs):

    This is a line.
    This is a line with a block:
      
      I am a block.

    # -->
    [ 
      [ String, nil],
      [ String, "I am a block"]
    ]

Installation
------------

    gem install Walt

Usage
------

    require "Walt"
    
    Walt str


Run Tests
---------

    git clone git@github.com:da99/Walt.git
    cd Walt
    bundle update
    bundle exec bacon spec/lib/main.rb

Know of a better way?
-----------------------------

If you know of existing software that makes the above redundant,
please tell me.

