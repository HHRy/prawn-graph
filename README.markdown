# prawn-graph - Easy Graphing for Prawn

Ryan Stenhouse <ryan@ryanstenhouse.eu> 
February 2010.

## Branches

The master branch of this repository tracks edge Prawn and will
be updated to reflect any changes there. If you need to work on
a version which is compatible with the current stable release,
0.7.*, then please use the <tt>stable-compat</tt> branch instead.

## Installing & Using through RubyGems

Installing and running prawn-graph is very easy:

  * <tt>gem install prawn prawn-graph</tt>

Will give you the latest stable version of Prawn and the latest
compatible version of prawn-graph. 

Using graphs in your PDF is as straightforward as:

<code>
  # test.rb
  require 'rubygems'
  require 'prawn/core'
  require 'prawn/graph'

  data = [ ['A', 10], ['B', 11], ['C' 12] ]

  Prawn::Document.generate('test.pdf') do
    test 'Graph Example'
    bar_graph data at => [10,10]
  end
</code>
