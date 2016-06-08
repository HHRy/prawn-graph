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

      # @return [Integer] The smallest value stored in the +values+ of this Series.
      #
      def min
        @values.min || 0
      end

      # @return [Integer] The largest value stored in the +values+ of this Series.
      #
      def max
        @values.max || 0
      end

      # @return [Integer] The size of the +values+ stored in this Series.
      #
      def size
        @values.size
      end

      # @deprecated Provided to allow for tempory backwards compatibilty with legacy graph drawing. Do not use.
      # @return [Array] Series represented as an array in the format [ title, val1, val2... ]
      #
      def to_a
        warn "[DEPRECATION] Series#to_a is deprecated and will be removed in a future version of prawn-graph."
        [title, @values].compact.flatten
      end
    end
  end
end