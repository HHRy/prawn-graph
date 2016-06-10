module Prawn
  module Graph
    module ChartComponents
      # A Prawn::Graph::Canvas represents the area on which a graph will be drawn. Think of it
      # as the container in which your chart / graph will be sized to fit within. 
      #
      class Canvas
        attr_reader :layout, :series, :prawn

        # @param series [Array[Prawn::Graph::Series]]
        # @param prawn [Prawn::Document]
        # @param options [Hash]
        # @return [Prawn::Graph::Canvas] a canvas ready to be drawn on the provided +prawn+ document.
        #
        def initialize(series, prawn, options = {}, &block)
          @series   = series
          verify_series_are_ok!
          @options  = options.merge({ series_count: series.size })
          @prawn    = prawn
          @theme    = Prawn::Graph::Theme::Default
          @layout   = Prawn::Graph::Calculations::LayoutCalculator.new([prawn.bounds.width, prawn.bounds.height], @options, @theme).calculate

          yield self if block_given?
        end

        # Fires off the actual drawing of the chart on the provided canvas.
        # @return [nil]
        #
        def draw
          prawn.bounding_box(position, :width => layout.canvas_width, :height => layout.canvas_height, padding: 0) do
            prawn.save_graphics_state do         
              apply_theme! 

              if layout.graph_area.renderable?
                prawn.bounding_box layout.graph_area.point, width: layout.graph_area.width, height: layout.graph_area.height do
                  prawn.stroke_bounds
                  prawn.text "The Graph gets rendered here. This will be fun."
                end
              end

              render_title_area!

              if layout.series_key_area.renderable?
                prawn.bounding_box layout.series_key_area.point, width: layout.series_key_area.width, height: layout.series_key_area.height do
                  prawn.stroke_bounds
                  prawn.text "Series keys go here"
                end
              end

            end
          end
        end

        # The coordinates which the canvas will be drawn at
        # @return [Array] [X-Coord, Y-Coord]
        #
        def position
          @options[:at] || [0,0]
        end

        private

        def apply_theme!
          prawn.fill_color    @theme.default
          prawn.stroke_color  @theme.default
          prawn.font_size     @theme.font_sizes.default
        end

        def render_title_area!
          if layout.title_area.renderable?
            prawn.text_box "<color rgb=\"#{@theme.title}\">#{@options[:title]}</color>", at: layout.title_area.point, inline_format: true, 
            valign: :center, align: :center, size: @theme.font_sizes.main_title, width: layout.title_area.width, height: layout.title_area.height
          end
        end

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
        def clip_graph_to_bounds(x, y, width, height)
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