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
        draw_graph(Prawn::Graph::Charts::Bar, data, options, &block)
      end
      alias bar_chart bar_graph

      # Draws a line graph into the PDF
      #
      # Example:
      #
      #  line_graph [ ["A", 1], ["B", 2], ["C", 3] ], at: [10,10]
      #
      def line_graph(data, options = {}, &block)
        draw_graph(Prawn::Graph::Charts::Line, data, options, &block)
      end
      alias line_chart line_graph

      private

      def draw_graph(klass, data, options, &block)
        graph = klass.new(data, self, options, &block)
        graph.draw
        {warnings: [], width: self.bounds.width, height: self.bounds.height}
      end
      
    end
  end
end