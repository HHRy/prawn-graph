# Prawn::Graph - Easy Graphing for Prawn

[![Gem Version](https://badge.fury.io/rb/prawn-graph.svg)](https://badge.fury.io/rb/prawn-graph)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://sujrd.mit-license.org)
[![Code Climate](https://codeclimate.com/github/HHRy/prawn-graph/badges/gpa.svg)](https://codeclimate.com/github/HHRy/prawn-graph)
[![Test Coverage](https://codeclimate.com/github/HHRy/prawn-graph/badges/coverage.svg)](https://codeclimate.com/github/HHRy/prawn-graph/coverage)
[![Build Status](https://travis-ci.org/HHRy/prawn-graph.svg?branch=master)](https://travis-ci.org/HHRy/prawn-graph)
[![security](https://hakiri.io/github/HHRy/prawn-graph/master.svg)](https://hakiri.io/github/HHRy/prawn-graph/master)
![Maintained: yes](https://img.shields.io/badge/maintained-yes-brightgreen.png)


An extension for the [prawn pdf library][5] which adds the ability to draw graphs (or charts if
you perfer) in PDF documents.

Because Prawn::Graph only uses the native PDF drawing functions exposed by Prawn, it removes the need to 
depend on projects like Gruff to generate heavy PNG / JPG images of such graphs and charts and then include
those large blobs in your documents. The results may not be as pretty (yet), but the file-size differences 
are dramatic.

By default, graphs are drawn in monochrome, as that's likely how they will be printed. 

This is free and open source software released under ther terms of the [MIT Licence](http://opensource.org/licenses/MIT).

Its copyright is held by Ryan Stenhouse and the [other contributors][8] and it was first released in 
2010.

## Compatibility

This gem is built assuming a Ruby version of 2.0 or higher. Older Ruby versions may work but are not 
officially supported. We aim for compatibilty with 1.x and 2.x series of prawn. Any incomaptibilities
with prawn versions should be treated as bugs and added to the [issue tracker][2]. 

We build automatically using Travis CI. Our [.travis.yml][9] file targets the same Ruby versions as
[prawn itself][5] does.


### Removed features:

Unlike previous versions of `prawn-graph`, this version does not at this time include a theme api or the 
ability to change the colors used to render the graph. 

### Removed deprecated methods

The `bar_chart`, `line_chart`, `bar_graph`, and `line_graph` methods have been removed. This means that this
version of prawn-graph is no-longer backwards compatible. If you _must_ use those old methods, then please 
use version `0.9.10` and **upgrade your calls to prawn graph to use the new `graph` methods as soon as possible**.


## Installation

To use prawn-graph, you can add the following to your `Gemfile`:

```Gemfile
 gem 'prawn-graph', ' ~> 1.0'
```

Alternatively, you can use Rubygems directly: `gem install prawn-graph`.
 
## Acknowledgements

With thanks to [株式会社アルム][3] ([Allm Inc][4]) for allowing Ryan Stenhouse the time to rebuild this version of
prawn-graph. This updated version of prawn-graph was inspired and guided by [prawn-svg][1] by [Roger Nesbitt][6]. 

Prawn Graph was originally sponsored by and built for use at [Purchasing Card Consultancy Ltd][7] while
Ryan Stenhouse was employed there.

## Supported graph / chart types

This version of Prawn::Graph supports the following graph / chart types:

  *  Bar Charts 
  *  Line Charts

Is your favourite chart type not supported yet? [Please request it][2], or if you are feeling particularly
adventurous - please add it!

## Using prawn-graph

Graphs can be created by calling the `graph` or its alias, `chart` method with an array of
`Prawn::Graph::Series` objects representing the data you would like to plot and how it should
be displayed. It will also take a hash of options, and block which will have the graph yeilded
to it.

```ruby
  graph data, options = {}, &block.
```

When called with just a set of data, prawn-graph will do its best to make the graph fit in the 
available space. For a little more control over how the graphs are rendered in the document
you can pass the following options to `graph` or `chart`:

Option      | Data type | Description
----------- | --------- | -----------
:at         | [integer, integer] | Specify the location on the page you want the graph to appear.
:width      | integer   | Desired width of the graph.  Defaults to horizontal space available.
:height     | integer   | Desired height of the graph.  Defaults to vertical space available.
:title      | string    | The overall title for your chart
:series_key | boolean   | Should we render the series key for multi series graphs? Defaults to true.

The `data` passed to `graph` or `chart` should be an `Array` of `Prawn::Graph::Series` objects, which
themselves are made up of an array of data points to plot, and a series of options.

```ruby
  Prawn::Graph::Series.new [1,2,3,4], options = {}
```

Valid `options` are:

Option        | Data type | Description
------------- | --------- | -----------
:mark_average | boolean   | Should we mark a line showing the average value of the series? Defaults to false.
:mark_minimum | boolean   | Should we mark the minimum value of the series? Defaults to false.
:mark_maximum | boolean   | Should we mark the maximum value of the series? Defaults to false.
:title        | string    | The title of this series, which will be shown in the series key.
:type         | symbol    | How this series should be rendered. Defaults to `:bar`, valid options are `:bar`, `:line`.

### Show me some code!

```ruby
  require 'prawn-graph'

  series = []
  series << Prawn::Graph::Series.new([4,9,3,2,1,6,2,8,2,3,4,9,2],  title: "A label for a series", type: :bar)
  series << Prawn::Graph::Series.new([5,4,3,2,7,9,2,8,7,5,4,9,2],  title: "Another label", type: :line, mark_average: true, mark_minimum: true)
  series << Prawn::Graph::Series.new([1,2,3,4,5,9,6,4,5,6,3,2,11], title: "Yet another label", type: :bar)
  series << Prawn::Graph::Series.new([1,2,3,4,5,12,6,4,5,6,3,2,9].shuffle, title: "One final label", type: :line, mark_average: true, mark_maximum: true)

  xaxis_labels = ['0900', '1000', '1100', '1200', '1300', '1400', '1500', '1600', '1700', '1800', '1900', '2000', '2100']

  Prawn::Document.generate('test.pdf') do
    graph series, width: 500, height: 200, title: "A Title for the chart", at: [10,700], xaxis_labels: xaxis_labels
  end
``` 

### Output
<img src="http://prawn-graph.ryanstenhouse.jp/img/prawn-graph-output.png" alt="Prawn Graph Example Output" width="933" height="420">

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



[1]: https://github.com/mogest/prawn-svg/
[2]: https://github.com/hhry/prawn-graph/issues/
[3]: http://www.allm.net/
[4]: http://www.allm.net/en/
[5]: http://github.com/prawnpdf/prawn/
[6]: https://github.com/mogest/
[7]: http://www.pccl.co.uk/
[8]: https://github.com/HHRy/prawn-graph/blob/master/CONTRIBUTORS.md
[9]: https://github.com/HHRy/prawn-graph/blob/master/.travis.yml
