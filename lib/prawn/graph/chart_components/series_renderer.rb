module Prawn
  module Graph
    module ChartComponents

      # The Prawn::Graph::ChartComponents::SeriesRenderer is used to plot indivdual Prawn::Graph::Series on
      # a Prawn::Graph::ChartComponents::Canvas and its associated Prawn::Document.
      #
      module SeriesRenderer
        class << self 
          # @param series [Prawn::Graph::Series]
          # @param canvas [Prawn::Graph::ChartComponents::Canvas]
          #
          def render(series, canvas)
            raise ArgumentError.new("series must be a Prawn::Graph::Series") unless series.is_a?(Prawn::Graph::Series)
            raise ArgumentError.new("canvas must be a Prawn::Graph::ChartComponents::Canvas") unless canvas.is_a?(Prawn::Graph::ChartComponents::Canvas)

            @series = series
            @canvas = canvas
          end

          private

          # Calculates the relative height of a given point based on the maximum value present in
          # the series.
          #
          def point_height_percentage(value)
            ((BigDecimal(value, 10)/BigDecimal(@series.max, 10)) * BigDecimal(100)).round(2)
          end
        end
      end
    end
  end
end