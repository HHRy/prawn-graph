module Prawn
  module Graph
    module Extension

      # @deprecated bar_graph and bar_chart are deprecated and will be removed in a future version. Use the new graph / chart methods instead.
      # Draws a bar graph into the PDF using the legacy graph stuff. Please avoid.
      #
      # Example:
      #
      #  bar_graph [ ["A", 1], ["B", 2], ["C", 3] ], at: [10,10]
      #
      def bar_graph(data, options = {}, &block)
        deprecate :bar_graph
        draw_graph(Prawn::Graph::Charts::Bar, data, options, &block)
      end
      alias bar_chart bar_graph

      # @deprecated line_graph and line_chart are deprecated and will be removed in a future version. Use the new graph / chart methods instead.
      # Draws a line graph into the PDF using the legacy graph stuff. Please avoid.
      #
      # Example:
      #
      #  line_graph [ ["A", 1], ["B", 2], ["C", 3] ], at: [10,10]
      #
      def line_graph(data, options = {}, &block)
        deprecate :line_graph
        draw_graph(Prawn::Graph::Charts::Line, data, options, &block)
      end
      alias line_chart line_graph

      
      # Plots one or more Prawn::Graph::Series on a chart. Expects an array-like object of
      # Prawn::Graph::Series objects and some options for positioning the sizing the
      # rendered graph
      #
      # @param series [Array] of Prawn::Graph::Series objects
      # @param options [Hash] of options, which can be: `:width`, `:height` , `:at` , or `:title`
      #
      def graph(series, options = {}, &block)
        canvas = Prawn::Graph::ChartComponents::Canvas.new(series, self, options, &block)
        canvas.draw
        {warnings: [], width: self.bounds.width, height: self.bounds.height}
      end
      alias chart graph

      private

      def draw_graph(klass, data, options, &block)
        graph = klass.new(data, self, options, &block)
        graph.draw
        {warnings: [], width: self.bounds.width, height: self.bounds.height}
      end
      
      def deprecate(method)
        warn "[DEPRECATION] #{method} is deprecated and will be removed in future versions of prawn-graph. Use chart or graph instead."
      end
    end
  end
end