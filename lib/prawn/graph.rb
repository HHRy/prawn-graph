require 'bigdecimal'

require File.dirname(__FILE__) + '/graph/errors'
require File.dirname(__FILE__) + '/graph/chart'
require File.dirname(__FILE__) + '/graph/base'
require File.dirname(__FILE__) + '/graph/grid'
require File.dirname(__FILE__) + '/graph/bar'
require File.dirname(__FILE__) + '/graph/line'
require File.dirname(__FILE__) + '/graph/themes'

module Prawn

  class Document

    Prawn::Chart::Themes.initialize_themes

    # Draws a fairly simple bar chart. Data should be passed in as an array of
    # arrays, much like how Tables are dealt with:
    #
    #   [
    #     [ 'Field Title', 10 ],
    #     [ 'Another Title', 20]
    #   ]
    #
    #  options[:at] MUST be specified, as the coordinates where you want your
    #  bar chart to be drawn.
    #
    #  options[:width] Sets the width of the chart, defaults to 500
    #  options[:height] Sets the height of the chart, defaults to 200
    #  options[:spacing] Sets the spacing between the grid squares of the chart, defaults to 20
    #
    # It will do its best to try and size content to fit the available size; but at
    # the moment it's not too clever. If your graph looks squashed; make it bigger.
    #
    # Other available options are:
    #
    #  :label_x Which sets a label to be shown along the X Axis.
    #  :label_y Which sets a label to be shown along the Y Axis.
    #  :title Which sets a Title for the chart
    #
    # For now, these values DO NOT scale in size. X/Y labels are always 8 points and Titles
    # are always 10 points.
    #
    def bar_chart(data, options = {})
      if data.nil? || data.empty?
        raise Prawn::Errors::NoGraphData,
          "data must be a non-empty, non-nil, two dimensional array " +
          "in the form [ [ 'Title', SomeValue ]  ]"
      end
      Prawn::Chart::Bar.new(data, self, options).draw
    end
    alias :bar_graph :bar_chart

    # Draws a fairly simple line chart. Data should be passed in as an array of
    # arrays, much like how Tables are dealt with:
    #
    #   [
    #     [ 'Field Title', 10 ],
    #     [ 'Another Title', 20]
    #   ]
    #
    #  options[:at] MUST be specified, as the coordinates where you want your
    #  bar chart to be drawn.
    #
    #  options[:width] Sets the width of the chart, defaults to 500
    #  options[:height] Sets the height of the chart, defaults to 200
    #  options[:spacing] Sets the spacing between the grid squares of the chart, defaults to 20
    #
    # It will do its best to try and size content to fit the available size; but at
    # the moment it's not too clever. If your graph looks squashed; make it bigger.
    #
    # Other available options are:
    #
    #  :label_x Which sets a label to be shown along the X Axis.
    #  :label_y Which sets a label to be shown along the Y Axis.
    #  :title Which sets a Title for the chart
    #
    # For now, these values DO NOT scale in size. X/Y labels are always 8 points and Titles
    # are always 10 points.
    #
    def line_chart(data, options = {})
      if data.nil? || data.empty?
        raise Prawn::Errors::NoGraphData,
          "data must be a non-empty, non-nil, two dimensional array " +
          "in the form [ [ 'Title', SomeValue ]  ]"
      end
      Prawn::Chart::Line.new(data, self, options).draw
    end
    alias :line_graph :line_chart


  end

end
