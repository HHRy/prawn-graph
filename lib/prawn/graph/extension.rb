module Prawn
  module Graph
    module Extension
      
      # Plots one or more Prawn::Graph::Series on a chart. Expects an array-like object of
      # Prawn::Graph::Series objects and some options for positioning the sizing the
      # rendered graph
      #
      # @param series [Array] of Prawn::Graph::Series objects
      # @param options [Hash] of options, which can be:
      #    `:width`       - The overall width of the graph to be drawn. `<Integer>`
      #    `:height`      - The overall height of the graph to be drawn. `<Integer>`
      #    `:at`          - The point from where the graph will be drawn. `[<Integer>x, <Integer>y]`
      #    `:title`       - The title for this chart. Must be a string. `<String>`
      #    `:series_key`  - Should we render the key to series in this chart? `<Boolean>`
      #    `:theme`       - The theme to be used, will default to our grey theme? `<Prawn::Graph::Theme>`
      #
      def graph(series, options = {}, &block)
        canvas = Prawn::Graph::ChartComponents::Canvas.new(series, self, options, &block)
        canvas.draw
        {warnings: [], width: self.bounds.width, height: self.bounds.height}
      end
      alias chart graph

    end
  end
end