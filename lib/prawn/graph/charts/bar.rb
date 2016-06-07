module Prawn
  module Graph
    module Charts
      class Bar < Base

        private

        def chart_object
          Prawn::Graph::Charts::Legacy::Bar.new(@series.collect(&:to_a), @prawn, @options)
        end

        def series_type
          :bar
        end
      end
    end
  end
end