module Prawn
  module Graph
    module ChartComponents
      # A Prawn::Graph::Canvas represents the area on which a graph will be drawn. Think of it
      # as the container in which your chart / graph will be sized to fit within. 
      #
      class Canvas
        attr_reader :sizing, :series, :prawn

        # @param series [Array[Prawn::Graph::Series]]
        # @param prawn [Prawn::Document]
        # @param options [Hash]
        # @return [Prawn::Graph::Canvas] a canvas ready to be drawn on the provided +prawn+ document.
        #
        def initialize(series, prawn, options = {}, &block)
          @series   = series
          verify_series_are_ok!

          @options  = options
          @prawn    = prawn
          @sizing   = Prawn::Graph::Calculations::DocumentSizing.new([prawn.bounds.width, prawn.bounds.height], options).calculate

          yield self if block_given?
        end

        # Fires off the actual drawing of the chart on the provided canvas.
        # @return [nil]
        #
        def draw
          prawn.bounding_box(position, :width => @sizing.output_width, :height => @sizing.output_height) do
            prawn.save_graphics_state do
              clip_rectangle 0, 0, @sizing.output_width, @sizing.output_height
              prawn.text "Graph goes here!"
            end
          end
        end

        # The coordinates which the canvas will be drawn at
        # @return [Array] [X-Coord, Y-Coord]
        #
        def position
          @options[:at] || [0, 0]
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
        
        # From prawn-svg - creates a cipped retangle, which we will then use to draw the graphs
        # upon.
        #
        def clip_rectangle(x, y, width, height)
          prawn.move_to x, y
          prawn.line_to x + width, y
          prawn.line_to x + width, y + height
          prawn.line_to x, y + height
          prawn.close_path
          prawn.add_content "W n"
        end
      end
    end
  end
end