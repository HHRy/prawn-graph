module Prawn
  module Chart
    class Line < Bar

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
          if @colour
            @document.fill_color '00DD00'
          else
            @document.fill_color 'AAAAAA'
          end
          @document.fill_circle_at point, :radius => 1
          last_position += point_spacing
        end
        @document.line_width 2
        if @colour
          @document.stroke_color '00DD00'
        else
          @document.stroke_color 'AAAAAA'
        end
        p.each_with_index do |point,i|
          next if point == p.last
          @document.move_to point
          @document.stroke_line_to p[i+1]
        end
      end

    end
  end
end
