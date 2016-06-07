module Prawn
  module Graph
    module Charts
      class Line < Base

      	private

        def chart_object
          Prawn::Graph::Charts::Legacy::Line.new(@series.collect(&:to_a), @prawn, @options)
        end

        def series_type
          :line
        end
      end
    end
  end
end