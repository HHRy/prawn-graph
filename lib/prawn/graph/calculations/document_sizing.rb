module Prawn
  module Graph
    module Calculations

      # This DocumentSizing class (and most of the other calculations stuff) has been taken from the prawn-svg
      # project (https://github.com/mogest/prawn-svg) which is by Roger Nesbitt and made available under the
      # MIT Licence. 
      #
      class DocumentSizing
        DEFAULT_ASPECT_RATIO = "xMidYMid meet"

        attr_writer :document_width, :document_height
        attr_writer :view_box, :preserve_aspect_ratio

        attr_reader :bounds
        attr_reader :x_offset, :y_offset, :x_scale, :y_scale
        attr_reader :viewport_width, :viewport_height, :viewport_diagonal, :canvas_width, :canvas_height 
        attr_reader :series_key_area, :title_area, :graph_area

        class Dimensions < OpenStruct
          def renderable?
            width > 0 && height > 0
          end
        end


        def initialize(bounds, attributes = nil, theme = Prawn::Graph::Theme::Default)
          @bounds = bounds
          set_from_attributes(attributes) if attributes

          @graph_area       = Dimensions.new({ width: 0, height: 0, x: 0, y: 0 })
          @title_area       = Dimensions.new({ width: 0, height: 0, x: 0, y: 0 })
          @series_key_area  = Dimensions.new({ width: 0, height: 0, x: 0, y: 0 })
          @theme            = theme
        end

        def set_from_attributes(attributes)

          @canvas_width = BigDecimal(attributes[:width], 10) rescue 0
          @canvas_height = BigDecimal(attributes[:height], 10) rescue 0
          @num_series = attributes[:series_count] || 1
          @title = attributes[:title]

          @document_width = attributes['width']
          @document_height = attributes['height']
          @view_box = attributes['viewBox']
          @preserve_aspect_ratio = attributes['preserveAspectRatio'] || DEFAULT_ASPECT_RATIO
        end

        def output_width
          canvas_width
        end

        def output_height
          canvas_height
        end

        def calculate
          calculate_width_and_height_of_canvas
          calculate_key_area
          calculate_title_area
          calculate_graph_area

          old_calculate

          self
        end

        def calculate_width_and_height_of_canvas
          if @canvas_width.zero? && @canvas_height.zero?
            @canvas_width   = BigDecimal(bounds[0]) 
            @canvas_height  = BigDecimal(bounds[1]) 
          end
        end

        def calculate_title_area
          unless @title.nil?
            @title_area[:width] = (canvas_width - @series_key_area[:width] - (2*hpadding))
            @title_area[:x] = hpadding
            @title_area[:y] = vpadding
            @title_area[:height] = vpadding + @theme.font_sizes.main_title
          end
        end

        def calculate_key_area
          if @num_series > 1
            @series_key_area[:width] = ( (canvas_width / 100) * 20 ).round
            @series_key_area[:x] = (canvas_width - @series_key_area[:width] - hpadding)
            @series_key_area[:y] = vpadding
            @series_key_area[:height] = (canvas_height - vpadding)
          end 
        end

        def calculate_graph_area
          @graph_area[:width] = (canvas_width - @series_key_area[:width] - (2*hpadding))
          @graph_area[:x] = hpadding

          if !@title_area.renderable?
            @graph_area[:y] = vpadding
            @graph_area[:height] = (canvas_height - vpadding)
          else
            @graph_area[:y] = @title_area[:y] + @title_area[:height]
            @graph_area[:height] = (canvas_height - vpadding - @title_area[:height])
          end
        end


        def hpadding
          (BigDecimal(canvas_width) / 100) * 5
        end

        def vpadding
          (BigDecimal(canvas_height) / 100) * 5
        end

        def old_calculate
          @x_offset = @y_offset = 0
          @x_scale = @y_scale = 1

          container_width = @requested_width || @bounds[0]
          container_height = @requested_height || @bounds[1]

          #@canvas_width = Pixels::Measurement.to_pixels(@document_width || @requested_width, container_width)
         # @canvas_height = Pixels::Measurement.to_pixels(@document_height || @requested_height, container_height)

          if @view_box
            values = @view_box.strip.split(" ")
            @x_offset, @y_offset, @viewport_width, @viewport_height = values.map {|value| value.to_f}

            if @viewport_width > 0 && @viewport_height > 0
              @canvas_width ||= container_width
              @canvas_height ||= @canvas_width * @viewport_height / @viewport_width

              aspect = AspectRatio.new(@preserve_aspect_ratio, [@canvas_width, @canvas_height], [@viewport_width, @viewport_height])
              @x_scale = aspect.width / @viewport_width
              @y_scale = aspect.height / @viewport_height
              @x_offset -= aspect.x / @x_scale
              @y_offset -= aspect.y / @y_scale
            end
          else
            @canvas_width ||= Pixels::Measurement.to_pixels(300, container_width)
            @canvas_height ||= Pixels::Measurement.to_pixels(150, container_height)

            @viewport_width = @canvas_width
            @viewport_height = @canvas_height
          end

          return if invalid?

          # SVG 1.1 section 7.10
          @viewport_diagonal = Math.sqrt(@viewport_width**2 + @viewport_height**2) / Math.sqrt(2)

          if @requested_width
            scale = @requested_width / @canvas_width
            @canvas_width = @requested_width
            @canvas_height *= scale
            @x_scale *= scale
            @y_scale *= scale

          elsif @requested_height
            scale = @requested_height / @canvas_height
            @canvas_height = @requested_height
            @canvas_width *= scale
            @x_scale *= scale
            @y_scale *= scale
          end

          self
        end

        def invalid?
          @viewport_width <= 0 ||
            @viewport_height <= 0 ||
            @canvas_width <= 0 ||
            @canvas_height <= 0 ||
            (@requested_width && @requested_width <= 0) ||
            (@requested_height && @requested_height <= 0)
        end

        def requested_width=(value)
          @requested_width = (value.to_f if value)
        end

        def requested_height=(value)
          @requested_height = (value.to_f if value)
        end
      end

      module Pixels
        class Measurement
          extend Prawn::Measurements

          def self.to_pixels(value, axis_length = nil)
            if value.is_a?(String)
              if match = value.match(/\d(cm|dm|ft|in|m|mm|yd)$/)
                send("#{match[1]}2pt", value.to_f)
              elsif match = value.match(/\dpc$/)
                value.to_f * 15 # according to http://www.w3.org/TR/SVG11/coords.html
              elsif value[-1..-1] == "%"
                value.to_f * axis_length / 100.0
              else
                value.to_f
              end
            elsif value
              value.to_f
            end
          end
        end

        protected

        def x(value)
          x_pixels(value)
        end

        def y(value)
          # This uses document.sizing, not state.viewport_sizing, because we always
          # want to subtract from the total height of the document.
          document.sizing.canvas_height - y_pixels(value)
        end

        def pixels(value)
          value && Measurement.to_pixels(value, state.viewport_sizing.viewport_diagonal)
        end

        def x_pixels(value)
          value && Measurement.to_pixels(value, state.viewport_sizing.viewport_width)
        end

        def y_pixels(value)
          value && Measurement.to_pixels(value, state.viewport_sizing.viewport_height)
        end
      end

    end
  end
end