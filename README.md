
This is obsolete:
================

This project is no longer maintained.

If you want
a node/npm version of this project, try looking at this one:
[englishy](https://github.com/da99/englishy)

Walt
================

A Ruby gem providing simple line and blockquote parsing (w/o paragraphs):

    This is a line.
    This is a 2-line
      line.
    This is a line with a block:

      I am a block.
      I am also part of a block.

    # -->
    [
      [ "This is a line", nil],
      [ "This is a 2-line line", nil],
      [ "This is a line with a block", "  I am a block.\n  I am also part of a block."]
    ]

The following raises `Walt:Parse\_Error`:

          Bad indentation.

    # -----------------------

    Multi-line with an

      an empty line in between.

    # -----------------------

    A block without:
      surrounding blank lines.



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

