module Prawn
  module Graph
    module Charts
      module Legacy
        class Bar < Prawn::Graph::Charts::Legacy::Base

          private

          def plot_values
            base_x = @grid.start_x + 1
            base_y = @grid.start_y + 1
            bar_width = calculate_bar_width
            @document.line_width bar_width
            last_position = base_x 
            point_spacing = calculate_plot_spacing
            @values.each do |value|
              @document.move_to [base_x + last_position, base_y]
              bar_height = calculate_point_height_from value
              @document.stroke_color @theme.series.sample
              @document.stroke_line_to [base_x + last_position, base_y + bar_height]
              last_position += point_spacing
            end
          end
        end
      end
    end
  end
end