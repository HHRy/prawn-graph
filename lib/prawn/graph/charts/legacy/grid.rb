module Prawn
  module Graph
    module Charts
      module Legacy

        class Grid

          attr_accessor :width, :height, :point, :spacing, :document

          def initialize(grid_x_start, grid_y_start, grid_width, grid_height, spacing, document, theme)
            @point = [grid_x_start, grid_y_start]
            @width = grid_width
            @height = grid_height
            @spacing = spacing
            @document = document
            @theme = theme
          end

          def start_x; @point.first; end
          def start_y; @point.last; end

          # Draws the Grid on the specified Prawn::Document
          #
          def draw
            @document.stroke_color @theme.marker_colour
            if @theme.stroke_grid_markers?
              (@height / @spacing).times do |x|
                offset = @spacing * (x + 1)
                @document.move_to [@point.first, (@point.last + offset)]
                @document.line_width(0.5)
                @document.stroke_line_to([(@point.first + @width), (@point.last + offset)])
              end
            end
            @document.move_to @point
            @document.line_width(2)
            @document.stroke_line_to([@point.first, @point.last + @height])
            @document.move_to @point
            @document.line_width(2)
            @document.stroke_line_to([(@point.first + @width), @point.last])
            @document.move_to @point.first, (@point.last + height)
            @document.stroke_color '000000'
            @document.line_width(1)
            @document.move_to @point
          end

        end

      end
    end
  end
end