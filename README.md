# Prawn::Graph - Easy Graphing for Prawn

[![Gem Version](https://badge.fury.io/rb/prawn-graph.svg)](https://badge.fury.io/rb/prawn-graph)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://sujrd.mit-license.org)

An extension for the [prawn pdf library][5] which adds the ability to draw graphs (or charts if
you perfer) in PDF documents.

Because Prawn::Graph only uses the native PDF drawing functions exposed by Prawn, it removes the need to 
depend on projects like Gruff to generate heavy PNG / JPG images of such graphs and charts and then include
those large blobs in your documents. The results may not be as pretty (yet), but the file-size differences 
are dramatic.

By default, graphs are drawn in monochrome, as that's likely how they will be printed. 

## Acknowledgements

With thanks to [株式会社アルム][3] ([Allm Inc][4]) for allowing Ryan Stenhouse the time to rebuild this version of
prawn-graph. This updated version of prawn-graph was inspired and guided by [prawn-svg][1] by [Roger Nesbitt][6]. 
It also uses some of [prawn-svg][1]'s document size calculation code.

## Supported graph / chart types

This version of Prawn::Graph supports the following graph / chart types:

  *  Bar Charts 
  *  Line Charts

Is your favourite chart type not supported yet? [Please request it][2], or if you are feeling particularly
adventurous - please add it!

## Using prawn-graph

```ruby
  require 'prawn-graph'

  data = [ ['A', 10], ['B', 11], ['C' 12] ]

  Prawn::Document.generate('test.pdf') do
    text 'Graph Example'
    bar_graph data
  end
```

When called with just a set of data, prawn-graph will do its best to make the graph fit in the 
available space. For a little more control over how the graphs are rendered in the document
you can pass the following options:

Option      | Data type | Description
----------- | --------- | -----------
:at         | [integer, integer] | Specify the location on the page you want the graph to appear.
:width      | integer   | Desired width of the graph.  Defaults to horizontal space available.
:height     | integer   | Desired height of the graph.  Defaults to vertical space available.

### Example

```ruby
  require 'prawn-graph'

  data = [ ['A', 10], ['B', 11], ['C' 12] ]

  Prawn::Document.generate('test.pdf') do
    text 'Graph Example'
    bar_graph data, at: [10,20], width: 200
  end
```


## Compatibility

The gem is  only tested against Ruby version 2.0 and greater. Older Ruby versions may work but are not 
officially supported. We aim for compatibilty with 1.x and 2.x series of prawn. Any incomaptibilities
should be treated as bugs and added to the [issue tracker][2]. 

Unlike previous version of prawn-graph, this version does not at this time include a theme api or the 
ability to change the colors used to render the graph. 

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can
also  run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the 
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, 
push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome [on GitHub][2]. This project is intended to be a 
safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) 
code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


[1]: https://github.com/mogest/prawn-svg/
[2]: https://github.com/hhry/prawn-graph/issues/
[3]: http://www.allm.net/
[4]: http://www.allm.net/en/
[5]: http://github.com/prawnpdf/prawn/
[6]: https://github.com/mogest/