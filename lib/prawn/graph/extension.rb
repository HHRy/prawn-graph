module Prawn
  module Graph
    module Extension

      # Draws a bar graph into the PDF
      #
      # Example:
      #
      #  bar_graph [ ["A", 1], ["B", 2], ["C", 3] ], at: [10,10]
      #
      def bar_graph(data, options = {}, &block)
        graph = Prawn::Graph::Charts::Bar.new(data, self, options, block)
        graph.draw
        {warnings: graph.document.warnings, width: graph.document.sizing.output_width, height: graph.document.sizing.output_height}
      end
      alias bar_chart bar_graph

      # Draws a line graph into the PDF
      #
      # Example:
      #
      #  line_graph [ ["A", 1], ["B", 2], ["C", 3] ], at: [10,10]
      #
      def line_graph(data, options = {}, &block)
        graph = Prawn::Graph::Charts::Line.new(data, self, options, block)
        graph.draw
        {warnings: graph.document.warnings, width: graph.document.sizing.output_width, height: graph.document.sizing.output_height}
      end
      alias line_chart line_graph

    end
  end
end