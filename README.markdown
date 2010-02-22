# Prawn::Graph - Easy Graphing for Prawn

Prawn::Graph copyrighted free software by Ryan Stenhouse
<ryan@ryanstenhouse.eu> with contributions form the community.

It extends Prawn::Core to add the ability for people to natively
draw graphs and charts in their PDFs.

Because Prawn::Graph only uses the native PDF drawing functions
exposed by Prawn, it removes the need to depend on projects like
Gruff to insert graphs in your documents. The results may not be
as pretty (yet), but the file-size differences are dramatic.

By default, graphs are drawn in monochrome, as that's likely how
they will be printed. You can pass an option to each of the graph
methods which will draw them in colour.

**Notice!** Much like Prawn, this software should be considered to
be in early alpha state at best. It's not recommended for use in 
a production environment unless you're happy to put up with bugs and
are willing to help fix them!

## Installing & Using through RubyGems

Installing and running prawn-graph is very easy:

  * <tt>gem install prawn-graph</tt>

Will give you the latest 'stable' version of Prawn and the latest
compatible version of prawn-graph. 

Using graphs in your PDF is as straightforward as:

<pre>
  require 'rubygems'
  require 'prawn/core'
  require 'prawn/graph'

  data = [ ['A', 10], ['B', 11], ['C' 12] ]

  Prawn::Document.generate('test.pdf') do
    test 'Graph Example'
    bar_graph data at => [10,10]
  end
</pre>
