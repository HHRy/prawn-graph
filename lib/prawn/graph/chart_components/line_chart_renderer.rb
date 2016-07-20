module Prawn
  module Graph
    module ChartComponents

      # The Prawn::Graph::ChartComponents::SeriesRenderer is used to plot indivdual Prawn::Graph::Series on
      # a Prawn::Graph::ChartComponents::Canvas and its associated Prawn::Document.
      #
      class LineChartRenderer < SeriesRenderer

        def render
          render_line_chart
        end

        private

        def mark_previous_as_minimum(min_marked, previous_value, previous_x_offset, previous_y)
          if @series.mark_minimum? && min_marked == false && previous_value != 0 && previous_value == @series.min 
            draw_marker_point(@canvas.theme.min, previous_x_offset, previous_y)
            min_marked = true
          end
          min_marked
        end

        def mark_current_as_minimum(min_marked, this_value, this_x_offset, this_y)
          if @series.mark_minimum? && min_marked == false && this_value != 0 && this_value == @series.min 
            draw_marker_point(@canvas.theme.min, this_x_offset, this_y)
            min_marked = true
          end
          min_marked
        end

        def mark_previous_as_maximum(max_marked, previous_value, previous_x_offset, previous_y)
          if @series.mark_maximum? && max_marked == false && previous_value != 0 && previous_value == @series.max
            draw_marker_point(@canvas.theme.max, previous_x_offset, previous_y)
            max_marked = true
          end
          max_marked
        end

        def mark_current_as_maximum(max_marked, this_value, this_x_offset, this_y)
          if @series.mark_maximum? && max_marked == false && this_value != 0 && this_value == @series.max
            draw_marker_point(@canvas.theme.max, this_x_offset, this_y)
            max_marked = true
          end
          max_marked
        end

        def mark_average_line
          if @series.mark_average?
            average_y_coordinate = (point_height_percentage(@series.avg) * @plot_area_height) - 5
            prawn.line_width = 1
            prawn.stroke_color = @color
            prawn.dash(2)
            prawn.stroke_line([0, average_y_coordinate], [ @plot_area_width, average_y_coordinate ])
            prawn.undash
          end
        end

        def render_line_chart
          prawn.bounding_box [@graph_area.point[0] + 5, @graph_area.point[1] - 20], width: @plot_area_width, height: @plot_area_height do
            j = 2
            prawn.save_graphics_state do  
              max_marked = false
              min_marked = false

              @series.values.each_with_index do |v, i|
                next if i == 0

                width_per_point = (@plot_area_width / @series.size).round(2).to_f
                spacing = width_per_point

                prawn.line_width = 2
                prawn.fill_color    = @color
                prawn.stroke_color  = @color

                previous_value = @series.values[i - 1]
                this_value = v

                previous_y  = (point_height_percentage(previous_value) * @plot_area_height) - 5
                this_y      = (point_height_percentage(this_value) * @plot_area_height) - 5

                previous_x_offset = ((spacing * (j - 1)) - spacing) + (spacing / 2.0)
                this_x_offset    = ((spacing * j) - spacing) + (spacing / 2.0)


                prawn.stroke_line([previous_x_offset, previous_y], [ this_x_offset, this_y ]) unless previous_value.zero? || this_value.zero?
                
                prawn.fill_color = @canvas.theme.markers
                prawn.fill_ellipse([ ( previous_x_offset), previous_y ], 1)  unless previous_value.zero? || this_value.zero?
                prawn.fill_ellipse([ ( this_x_offset), this_y ], 1)  unless previous_value.zero? || this_value.zero?

                min_marked = mark_previous_as_minimum(min_marked, previous_value, previous_x_offset, previous_y)
                min_marked = mark_current_as_minimum(min_marked, this_value, this_x_offset, this_y)
                max_marked = mark_previous_as_maximum(max_marked, previous_value, previous_x_offset, previous_y)
                max_marked = mark_current_as_maximum(max_marked, this_value, this_x_offset, this_y)

                j += 1
              end
              
              mark_average_line
            end
            render_axes
          end
        end
      end
    end
  end
end
