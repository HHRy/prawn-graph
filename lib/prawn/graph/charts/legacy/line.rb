module Prawn
  module Graph
    module Charts
      module Legacy
        class Line < Prawn::Graph::Charts::Legacy::Base

          private
          
          def plot_values
            base_x = @grid.start_x + 1
            base_y = @grid.start_y + 1
            p = [ [base_x, base_y] ]
            bar_width = calculate_bar_width
            @document.line_width bar_width
            last_position = base_x + bar_width
            point_spacing = calculate_plot_spacing
            @values.each do |value|
              @document.move_to [base_x + last_position, base_y]
              bar_height = calculate_point_height_from value
              point = [base_x + last_position, base_y + bar_height]
              p << point
              @document.fill_color @theme.series.last
              @document.fill_circle_at point, :radius => 1
              last_position += point_spacing
            end
            @document.line_width 2
            @document.stroke_color @theme.series.last
            p.each_with_index do |point,i|
              next if point == p.last
              @document.move_to point
              @document.stroke_line_to p[i+1]
            end
          end

        end
      end
    end
  end
end