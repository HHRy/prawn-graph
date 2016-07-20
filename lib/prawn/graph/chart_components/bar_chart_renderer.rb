module Prawn
  module Graph
    module ChartComponents
      # The Prawn::Graph::ChartComponents::BarChartRenderer is used to plot one or more bar charts 
      # in a sensible way on a a Prawn::Graph::ChartComponents::Canvas and its associated 
      # Prawn::Document.
      #
      class BarChartRenderer < SeriesRenderer
        def render
          render_the_chart
        end

        private

        def mark_average_line(series_index)
          if @series[series_index].mark_average?
            average_y_coordinate = (point_height_percentage(@series[series_index].avg) * @plot_area_height) - 5
            prawn.line_width = 1
            prawn.stroke_color = @color[series_index]
            prawn.dash(2)
            prawn.stroke_line([0, average_y_coordinate], [ @plot_area_width, average_y_coordinate ])
            prawn.undash
          end
        end

        def mark_maximum_point(series_index, point, max_marked)
          mm = max_marked.dup

          if @series[series_index].mark_maximum? && max_marked == false && @series[series_index].values[point] == @series[series_index].max
            prawn.save_graphics_state do
              prawn.fill_color = @canvas.theme.max
              prawn.stroke_color = @canvas.theme.max
              prawn.line_width = 1

              prawn.dash(2)
              prawn.stroke_line([x_position, 0], [x_position, y_position])
              prawn.undash

              prawn.fill_ellipse([x_position, y_position ], 2)
              mm = true
            end
          end

          mm
        end

        def mark_minimum_point(series_index, point, min_marked)
          mm = min_marked.dup

          if @series[series_index].mark_minimum? && min_marked == false && !@series[series_index].values[point].zero? && @series[series_index].values[point] == @series[series_index].min
            prawn.save_graphics_state do
              prawn.fill_color = @canvas.theme.min
              prawn.stroke_color = @canvas.theme.min
              prawn.line_width = 1

              prawn.dash(2)
              prawn.stroke_line([x_position, 0], [x_position, y_position])
              prawn.undash

              prawn.fill_ellipse([x_position, y_position ], 2)
              mm = true
            end
          end

          mm
        end

        def render_the_chart
          prawn.bounding_box [@graph_area.point[0] + 5, @graph_area.point[1] - 20], width: @plot_area_width, height: @plot_area_height do
         
            prawn.save_graphics_state do  
              num_points        = @series[0].size
              width_per_point   = (@plot_area_width / num_points)
              width             = (((width_per_point * 0.9) / @series.size).round(2)).to_f
              min_marked        = false
              max_marked        = false

              num_points.times do |point|

                @series.size.times do |series_index|
                  series_offset = series_index + 1
                  prawn.fill_color    = @color[series_index]
                  prawn.stroke_color  = @color[series_index]
                  prawn.line_width  = width

                  starting = (prawn.bounds.left + (point * width_per_point))

                  x_position = ( (starting + (series_offset * width) ).to_f - (width / 2.0))
                  y_position = ((point_height_percentage(@series[series_index].values[point]) * @plot_area_height) - 5).to_f

                  prawn.fill_and_stroke_line([ x_position ,0], [x_position ,y_position]) unless @series[series_index].values[point].zero?

                  mark_average_line(series_index)
                  max_marked = mark_maximum_point(series_index, point, max_marked)
                  min_marked = mark_minimum_point(series_index, point, min_marked)
                end

              end

            end
            render_axes
          end
        end

        def max 
          @series.collect(&:max).max || 0
        end

        def min
          @series.collect(&:min).min || 0
        end

        def avg
          @series.collect(&:avg).inject(:+) / @series.size rescue 0
        end

      end
    end
  end
end