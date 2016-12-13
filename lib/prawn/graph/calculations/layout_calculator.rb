module Prawn
  module Graph
    module Calculations

      class LayoutCalculator
        attr_reader :bounds
        attr_reader :series_key_area, :title_area, :graph_area, :canvas_width, :canvas_height

        class Dimensions < OpenStruct
          def renderable?
            width > 0 && height > 0
          end

          def point
            [x, y]
          end
        end

        def initialize(bounds, attributes = nil, theme = Prawn::Graph::Theme.default)
          @bounds = bounds
          @graph_area       = Dimensions.new({ width: 0, height: 0, x: 0, y: 0 })
          @title_area       = Dimensions.new({ width: 0, height: 0, x: 0, y: 0 })
          @series_key_area  = Dimensions.new({ width: 0, height: 0, x: 0, y: 0 })
          @theme            = theme
          set_from_attributes(attributes) if attributes
        end

        def calculate
          calculate_width_and_height_of_canvas
          calculate_key_area
          calculate_title_area
          calculate_graph_area
          
          self
        end

        def hpadding
          ((BigDecimal(canvas_width) / 100) * 2).round
        end

        def vpadding
          ((BigDecimal(canvas_height) / 100) * 2).round
        end

        def invalid?
          canvas_width > bounds[0] || canvas_height > bounds[1]
        end

        private

        def set_from_attributes(attributes)
          @canvas_width = BigDecimal(attributes[:width], 10) rescue 0
          @canvas_height = BigDecimal(attributes[:height], 10) rescue 0
          @num_series = attributes[:series_count] || 1
          @title = attributes[:title]
          @show_series_key = !attributes[:show_series_key].nil? ? attributes[:show_series_key]  : true
        end

        def calculate_width_and_height_of_canvas
          if @canvas_width.zero? && @canvas_height.zero?
            @canvas_width   = BigDecimal(bounds[0], 10) 
            @canvas_height  = BigDecimal(bounds[1], 10) 
          elsif !@canvas_width.zero? && @canvas_height.zero?
            @canvas_height  = (@canvas_width / bounds_aspect_ratio).round
          elsif !@canvas_height.zero? && @canvas_width.zero?
            @canvas_width  = (@canvas_height * bounds_aspect_ratio).round
          end
        end

        def bounds_aspect_ratio
          BigDecimal(bounds[0], 10) / BigDecimal(bounds[1], 10)
        end

        def calculate_title_area
          unless @title.nil?
            @title_area[:width] = (canvas_width - @series_key_area[:width] - (2*hpadding))
            @title_area[:x] = hpadding
            @title_area[:height] = @theme.font_sizes.main_title + vpadding
            @title_area[:y] = canvas_height + vpadding 
          end
        end

        def calculate_key_area
          if @num_series > 1 && @show_series_key
            @series_key_area[:width] = ( (canvas_width / 100) * 25 ).round
            @series_key_area[:x] = (canvas_width - @series_key_area[:width] - hpadding)
            @series_key_area[:y] = canvas_height + vpadding
            @series_key_area[:height] = (canvas_height - vpadding)
          end 
        end

        def calculate_graph_area
          @graph_area[:width] = (canvas_width - @series_key_area[:width] - (2*hpadding))
          @graph_area[:x] = hpadding

          if !@title_area.renderable?
            @graph_area[:y] = canvas_height + vpadding
            @graph_area[:height] = (canvas_height - vpadding)
          else
            @graph_area[:y] =  (@title_area[:y] - @title_area[:height])
            @graph_area[:height] = (canvas_height - vpadding - @title_area[:height])
          end
        end

      end

    end
  end
end