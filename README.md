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


### Legacy support and deprecation notices.

To provide backwards-compatibility (of sorts), `prawn-graph` provides `bar_graph` (aliased as `bar_chart`)
and `line_graph` (aliased as `line_chart`) methods as part of its interface which function the same as their
equivalents in version `0.0.4`. These methods are, however, deprecated and **will** be removed when version
`1.0.0` is released. Using these methods will result in a `warn` level message from Ruby.

These legacy methods will still be buggy as they are using the same rendering methods as before. Where possible
you should use the new `graph` (aliased as `chart`) interface. Unless serious problems are uncovered, bugs
reported with legacy rendering **will not be considered**.

Unlike previous versions of `prawn-graph`, this version does not at this time include a theme api or the 
ability to change the colors used to render the graph. 

## Installation

To use prawn-graph, you can add the following to your `Gemfile`:

```Gemfile
 gem 'prawn-graph', '0.9.0'
```

Alternatively, you can use Rubygems directly: `gem install prawn-graph`.
 
## Acknowledgements

With thanks to [株式会社アルム][3] ([Allm Inc][4]) for allowing Ryan Stenhouse the time to rebuild this version of
prawn-graph. This updated version of prawn-graph was inspired and guided by [prawn-svg][1] by [Roger Nesbitt][6]. 
It also uses some of [prawn-svg][1]'s document size calculation code.

Prawn Graph was originally sponsored by and built for use at [Purchasing Card Consultancy Ltd][7] while
Ryan Stenhouse was employed there.

## Supported graph / chart types

This version of Prawn::Graph supports the following graph / chart types:

  *  Bar Charts 
  *  Line Charts

Is your favourite chart type not supported yet? [Please request it][2], or if you are feeling particularly
adventurous - please add it!

## Using prawn-graph

```ruby
  require 'prawn-graph'

  series = []
  series << Prawn::Graph::Series.new([1,2,3,4,5], title: "Some numbers", type: :bar)

  Prawn::Document.generate('test.pdf') do
    graph series
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

### Advanced example

```ruby
  require 'prawn-graph'

  series = []
  series << Prawn::Graph::Series.new([1,2,3,4,5], title: "Some numbers", type: :line)
  series << Prawn::Graph::Series.new([5,4,3,2,1], title: "Some more numbers", type: :bar)

  Prawn::Document.generate('test.pdf') do
    graph series, at: [11, 11], height: 200
  end
```

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
