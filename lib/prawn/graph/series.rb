module Prawn
  module Graph
    
    # A Prawn::Graph::Series represents a series of data which are to be plotted
    # on a chart.
    #
    class Series
      attr_accessor :values, :title, :type
      VALID_TYPES = [ :bar, :line ]

      def initialize(values = [], title = nil, type = :bar)
        @values   = values
        @title    = title
        @type     = type
      end

      def <<(value)
        @values << value
      end

      def min
        @values.min || 0
      end

      def max
        @values.max || 0
      end

      def size
        @values.size
      end

      def to_a
        [title, @values].compact.flatten
      end
    end
  end
end