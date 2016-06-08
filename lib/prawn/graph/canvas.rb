module Prawn
  module Graph

    # A Prawn::Graph::Canvas represents the area on which a graph will be drawn. Think of it
    # as the container in which your chart / graph will be sized to fit within. 
    #
    class Canvas

      # @param series [Array[Prawn::Graph::Series]]
      # @param prawn [Prawn::Document]
      # @param options [Hash]
      # @return [Prawn::Graph::Canvas] a canvas ready to be drawn on the provided +prawn+ document.
      #
      def initialize(series, prawn, options = {}, &block)
      end

      # Fires off the actual drawing of the chart on the provided canvas.
      # @return [nil]
      #
      def draw
      end

      private
       
    end
  end
end