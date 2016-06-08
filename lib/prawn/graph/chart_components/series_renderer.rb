module Prawn
  module Graph
    module ChartComponents

      # The Prawn::Graph::ChartComponents::SeriesRenderer is used to plot indivdual Prawn::Graph::Series on
      # a Prawn::Graph::ChartComponents::Canvas and its associated Prawn::Document.
      #
      class SeriesRenderer

        # @param series [Prawn::Graph::Series]
        # @param canvas [Prawn::Graph::ChartComponents::Canvas]
        #
        def initialize(series, canvas)
          raise ArgumentError.new("series must be a Prawn::Graph::Series") unless series.is_a?(Prawn::Graph::Series)
          raise ArgumentError.new("canvas must be a Prawn::Graph::ChartComponents::Canvas") unless canvas.is_a?(Prawn::Graph::ChartComponents::Canvas)

          @series = series
          @canvas = canvas
        end

        # Draws the series on the provided canvas.
        #
        def draw
        end

        private

      end
    end
  end
end