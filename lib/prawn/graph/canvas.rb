module Prawn
  module Graph

    # A Prawn::Graph::Canvas represents the area on which a graph will be drawn. Think of it
    # as the container in which your chart / graph will be sized to fit within. 
    #
    class Canvas
      attr_reader :sizing, :series

      # @param series [Array[Prawn::Graph::Series]]
      # @param prawn [Prawn::Document]
      # @param options [Hash]
      # @return [Prawn::Graph::Canvas] a canvas ready to be drawn on the provided +prawn+ document.
      #
      def initialize(series, prawn, options = {}, &block)
        @series   = series

        verify_series_are_ok!

        @prawn    = prawn
        @sizing   = Prawn::Graph::Calculations::DocumentSizing.new([prawn.bounds.width, prawn.bounds.height], options).calculate

        yield self if block_given?
      end

      # Fires off the actual drawing of the chart on the provided canvas.
      # @return [nil]
      #
      def draw
      end

      private

      # Verifies that we provide an array-like object of Prawn::Graph::Series instances to
      # the Canvas, for later rendering.
      #
      def verify_series_are_ok!
        if @series.respond_to?(:each) && @series.respond_to?(:collect)
          classes = @series.collect{ |c| c.is_a?(Prawn::Graph::Series) }.uniq
          if classes.size > 1 || classes[0] != true
            raise RuntimeError.new("All of the items provided must be instances of Prawn::Graph::Series")
          end
        else
          raise RuntimeError.new("Series provided must be an Array (or Array-like) object.")
        end
      end
       
    end
  end
end