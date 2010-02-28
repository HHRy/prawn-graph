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

Gem version 0.3 is compatible with the latest 0.8 stable release
of prawn. If you're still using 0.7, then install version 0.2 of
prawn-graph.

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

## Documentation

Documentation for Prawn::Graph is available in available at [its project page on my website][2] and also 
on [the project's wiki on github][1]. 

## Using Themes

At the moment, work is underway on implementing 'Themes' within
Prawn::Graph, which are hugely inspired by (and are indeed based on
the actual themes from) Gruff. 

To find the list of available themes, use:

    Prawn::Chart::Themes.list 

The default theme which will be used for rendering is:

    Prawn::Chart::Theme.monochrome

This in-line with the design decision of Prawn::Graph to render in
monochrome by default, since most of our users are likely to be 
printing these documents!

[1]: http://wiki.github.com/HHRy/prawn-graph/
[2]: http://bit.ly/aKNukb