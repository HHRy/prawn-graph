require "bigdecimal"

module Prawn
  module Graph
    module ChartComponents
      # The Prawn::Graph::ChartComponents::PieChartRenderer is used to plot a pie chart
      # in a sensible way on a a Prawn::Graph::ChartComponents::Canvas and its associated 
      # Prawn::Document.
      #
      class PieChartRenderer < SeriesRenderer
        def render
          render_the_chart
        end

        private

        def render_the_chart
          prawn.bounding_box [@graph_area.point[0] + 5, @graph_area.point[1] - 20], width: @plot_area_width, height: @plot_area_height do
            total = @series.values.inject(:+)
            start_angle = BigDecimal(0)
            anc = prawn.bounds.bottom_left
            x = (anc[0] + (@plot_area_width / 2)).to_f
            y = (anc[1] + (@plot_area_height / 2)).to_f
            r = (@plot_area_height / 2.2)
   
            @series.values.each_with_index do |v, i|
              prawn.save_graphics_state do
                pc                  = percentage_of(v, total)
                size_of_pie_angles  = pc * 3.6
                end_angle = (start_angle + size_of_pie_angles)
                prawn.fill_color    = @color[i] rescue '000000'
                prawn.fill_pie_slice([x, y], radius: r, start_angle: start_angle.to_f, end_angle: end_angle.to_f)
                start_angle = end_angle
              end              
            end 
            
            prawn.stroke_arc_around([x,y], radius: r, start_angle: 0, end_angle: 360)
          end
        end

        def percentage_of(value, of_total)
          (BigDecimal(value, 10) / BigDecimal(of_total, 10)) * 100
        end

      end
    end
  end
end