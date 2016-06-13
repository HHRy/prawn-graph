module Prawn
  module Graph
    module ChartComponents

      # The Prawn::Graph::ChartComponents::SeriesRenderer is used to plot indivdual Prawn::Graph::Series on
      # a Prawn::Graph::ChartComponents::Canvas and its associated Prawn::Document.
      #
      module SeriesRenderer
        class << self 
          # @param series [Prawn::Graph::Series]
          # @param canvas [Prawn::Graph::ChartComponents::Canvas]
          #
          def render(series, canvas, color = '000000')
            raise ArgumentError.new("series must be a Prawn::Graph::Series") unless series.is_a?(Prawn::Graph::Series)
            raise ArgumentError.new("canvas must be a Prawn::Graph::ChartComponents::Canvas") unless canvas.is_a?(Prawn::Graph::ChartComponents::Canvas)

            @series = series
            @canvas = canvas
            @prawn = canvas.prawn
            @color = color

            @graph_area = @canvas.layout.graph_area

            @plot_area_width  = @graph_area.width - 25
            @plot_area_height = @graph_area.height - 20

            render_line_chart
          end

          private

          def render_line_chart
            prawn.bounding_box [@graph_area.point[0] + 5, @graph_area.point[1] - 20], width: @plot_area_width, height: @plot_area_height do
              j = 2
              prawn.save_graphics_state do  
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


                  prawn.stroke_line([previous_x_offset, previous_y], [ this_x_offset, this_y ])
                  
                  prawn.fill_color = @canvas.theme.markers
                  prawn.fill_ellipse([ ( previous_x_offset), previous_y ], 1)
                  prawn.fill_ellipse([ ( this_x_offset), this_y ], 1)
                  j += 1
                end
                
              end
              render_axes
            end
          end

          def render_axes
            prawn.stroke_color  = @canvas.theme.axes
            prawn.fill_color  = @canvas.theme.axes
            prawn.stroke_horizontal_line(0, @plot_area_width, at: 0) 
            prawn.stroke_vertical_line(0, @plot_area_height, at: 0) 
            prawn.fill_and_stroke_ellipse [ 0,0], 1
          end

          # Calculates the relative height of a given point based on the maximum value present in
          # the series.
          #
          def point_height_percentage(value)
            ((BigDecimal(value, 10)/BigDecimal(@series.max, 10)) * BigDecimal(1)).round(2)
          end

          def prawn
            @prawn
          end
        end
      end



      # The Prawn::Graph::ChartComponents::BarChartRenderer is used to plot one or more bar charts 
      # in a sensible way on a a Prawn::Graph::ChartComponents::Canvas and its associated 
      # Prawn::Document.
      #
      module BarChartRenderer
        class << self 
          # @param series [Prawn::Graph::Series]
          # @param canvas [Prawn::Graph::ChartComponents::Canvas]
          #
          def render(series, canvas, colors)
            @series = series
            @canvas = canvas
            @prawn = canvas.prawn
            @colors = colors


            @graph_area = @canvas.layout.graph_area

            @plot_area_width  = @graph_area.width - 25
            @plot_area_height = @graph_area.height - 20

            render_bar_charts
          end

          private

          def render_bar_charts
            prawn.bounding_box [@graph_area.point[0] + 5, @graph_area.point[1] - 20], width: @plot_area_width, height: @plot_area_height do
           
              prawn.save_graphics_state do  
                num_points        = @series[0].size
                width_per_point   = (@plot_area_width / num_points).round(2).to_f
                width             = ((width_per_point * BigDecimal('0.9')) / @series.size).round(2).to_f
                spacing           = (width_per_point - (width * @series.size).to_f / 2.0)

                num_points.times do |point|

                  @series.size.times do |series_index|
                    series_offset = series_index + 1
                    prawn.fill_color    = @colors[series_index]
                    prawn.stroke_color  = @colors[series_index]
                    prawn.line_width  = width

                    starting = (prawn.bounds.left + (point * width_per_point))

                    x_position = ( (starting + (series_offset * width) ).to_f - (width / 2.0))
                    y_position = ((point_height_percentage(@series[series_index].values[point]) * @plot_area_height) - 5).to_f

                    prawn.fill_and_stroke_line([ x_position ,0], [x_position ,y_position])
                  end

                end

              end
              render_axes
            end
          end

          def render_axes
            prawn.stroke_color  = @canvas.theme.axes
            prawn.fill_color  = @canvas.theme.axes
            prawn.stroke_horizontal_line(0, @plot_area_width, at: 0) 
            prawn.stroke_vertical_line(0, @plot_area_height, at: 0) 
            prawn.fill_and_stroke_ellipse [ 0,0], 1
          end

          # Calculates the relative height of a given point based on the maximum value present in
          # the series.
          #
          def point_height_percentage(value)
            ((BigDecimal(value, 10)/BigDecimal(@series[0].max, 10)) * BigDecimal(1)).round(2)
          end

          def prawn
            @prawn
          end
        end
      end
    end
  end
end