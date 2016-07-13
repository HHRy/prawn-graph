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

                  if @series.mark_minimum? && min_marked == false && previous_value != 0 && previous_value == @series.min 
                    prawn.save_graphics_state do
                      prawn.fill_color = @canvas.theme.min
                      prawn.stroke_color = @canvas.theme.min
                      prawn.line_width = 1

                      prawn.dash(2)
                      prawn.stroke_line([previous_x_offset, 0], [previous_x_offset, previous_y])
                      prawn.undash

                      prawn.fill_ellipse([ ( previous_x_offset), previous_y ], 2)
                      min_marked = true
                    end
                  end

                  if @series.mark_maximum? && max_marked == false && previous_value != 0 && previous_value == @series.max
                    prawn.save_graphics_state do
                      prawn.fill_color = @canvas.theme.max
                      prawn.stroke_color = @canvas.theme.max
                      prawn.line_width = 1

                      prawn.dash(2)
                      prawn.stroke_line([previous_x_offset, 0], [previous_x_offset, previous_y])
                      prawn.undash

                      prawn.fill_ellipse([ ( previous_x_offset), previous_y ], 2)
                      max_marked = true
                    end
                  end
             

                if @series.mark_minimum? && min_marked == false && this_value != 0 && this_value == @series.min 
                    prawn.save_graphics_state do
                      prawn.fill_color = @canvas.theme.min
                      prawn.stroke_color = @canvas.theme.min
                      prawn.line_width = 1

                      prawn.dash(2)
                      prawn.stroke_line([this_x_offset, 0], [this_x_offset, this_y])
                      prawn.undash

                      prawn.fill_ellipse([ ( this_x_offset), this_y ], 2)
                      min_marked = true
                    end
                  end

                  if @series.mark_maximum? && max_marked == false && this_value != 0 && this_value == @series.max
                    prawn.save_graphics_state do
                      prawn.fill_color = @canvas.theme.max
                      prawn.stroke_color = @canvas.theme.max
                      prawn.line_width = 1

                      prawn.dash(2)
                      prawn.stroke_line([this_x_offset, 0], [this_x_offset, this_y])
                      prawn.undash

                      prawn.fill_ellipse([ ( this_x_offset), this_y ], 2)
                      max_marked = true
                    end
                  end
                  j += 1
                end
                
                if @series.mark_average?
                  average_y_coordinate = (point_height_percentage(@series.avg) * @plot_area_height) - 5
                  prawn.line_width = 1
                  prawn.stroke_color = @color
                  prawn.dash(2)
                  prawn.stroke_line([0, average_y_coordinate], [ @plot_area_width, average_y_coordinate ])
                  prawn.undash
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

            max = @series.max || 0
            min = @series.min || 0
            avg = @series.avg || 0
            mid = (min + max) / 2 rescue 0

            max_y = (point_height_percentage(max) * @plot_area_height)
            min_y = (point_height_percentage(min) * @plot_area_height)
            mid_y = (point_height_percentage(mid) * @plot_area_height)
            avg_y = (point_height_percentage(avg) * @plot_area_height)

            prawn.text_box "#{max}", at: [-14, max_y], height: 5, overflow: :shrink_to_fit, width: 12, valign: :bottom, align: :right unless max.zero?
            prawn.text_box "#{mid}", at: [-14, mid_y], height: 5, overflow: :shrink_to_fit, width: 12, valign: :bottom, align: :right unless mid.zero?
            prawn.text_box "#{avg}", at: [-14, avg_y], height: 5, overflow: :shrink_to_fit, width: 12, valign: :bottom, align: :right unless avg.zero?
            prawn.text_box "#{min}", at: [-14, min_y], height: 5, overflow: :shrink_to_fit, width: 12, valign: :bottom, align: :right unless min.zero?

            return if @canvas.options[:xaxis_labels].size.zero?

            width_of_each_label = (@plot_area_width / @canvas.options[:xaxis_labels].size) - 1
            @canvas.options[:xaxis_labels].each_with_index do |label, i|
              offset    = i + 1
              position  = ((offset * width_of_each_label) - width_of_each_label) + 1
              
              prawn.text_box  label, at: [ position, -2 ], width: width_of_each_label, height: 6, valign: :center, align: :right,
                              overflow: :shrink_to_fit
            end
          end

          # Calculates the relative height of a given point based on the maximum value present in
          # the series.
          #
          def point_height_percentage(value)
            ((BigDecimal(value, 10)/BigDecimal(@canvas.series.collect(&:max).max, 10)) * BigDecimal(1)).round(2) rescue 0
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
                width_per_point   = (@plot_area_width / num_points)
                width             = (((width_per_point * 0.9) / @series.size).round(2)).to_f
                min_marked        = false
                max_marked        = false

                num_points.times do |point|

                  @series.size.times do |series_index|
                    series_offset = series_index + 1
                    prawn.fill_color    = @colors[series_index]
                    prawn.stroke_color  = @colors[series_index]
                    prawn.line_width  = width

                    starting = (prawn.bounds.left + (point * width_per_point))

                    x_position = ( (starting + (series_offset * width) ).to_f - (width / 2.0))
                    y_position = ((point_height_percentage(@series[series_index].values[point]) * @plot_area_height) - 5).to_f

                    prawn.fill_and_stroke_line([ x_position ,0], [x_position ,y_position]) unless @series[series_index].values[point].zero?

                    if @series[series_index].mark_average?
                      average_y_coordinate = (point_height_percentage(@series[series_index].avg) * @plot_area_height) - 5
                      prawn.line_width = 1
                      prawn.stroke_color = @colors[series_index]
                      prawn.dash(2)
                      prawn.stroke_line([0, average_y_coordinate], [ @plot_area_width, average_y_coordinate ])
                      prawn.undash
                    end

                    if @series[series_index].mark_minimum? && min_marked == false && !@series[series_index].values[point].zero? && @series[series_index].values[point] == @series[series_index].min
                      prawn.save_graphics_state do
                        prawn.fill_color = @canvas.theme.min
                        prawn.stroke_color = @canvas.theme.min
                        prawn.line_width = 1

                        prawn.dash(2)
                        prawn.stroke_line([x_position, 0], [x_position, y_position])
                        prawn.undash

                        prawn.fill_ellipse([x_position, y_position ], 2)
                        min_marked = true
                      end
                    end

                    if @series[series_index].mark_maximum? && max_marked == false && @series[series_index].values[point] == @series[series_index].max
                      prawn.save_graphics_state do
                        prawn.fill_color = @canvas.theme.max
                        prawn.stroke_color = @canvas.theme.max
                        prawn.line_width = 1

                        prawn.dash(2)
                        prawn.stroke_line([x_position, 0], [x_position, y_position])
                        prawn.undash

                        prawn.fill_ellipse([x_position, y_position ], 2)
                        max_marked = true
                      end
                    end
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

            max = @series.collect(&:max).max || 0
            min = @series.collect(&:min).min  || 0
            avg = ((BigDecimal(@series.collect(&:avg).inject(:+), 10) / @series.collect(&:avg).size).round(2)).to_f || 0
            mid = (min + max) / 2 || 0

            max_y = (point_height_percentage(max) * @plot_area_height)
            min_y = (point_height_percentage(min) * @plot_area_height)
            mid_y = (point_height_percentage(mid) * @plot_area_height)
            avg_y = (point_height_percentage(avg) * @plot_area_height)

            prawn.text_box "#{max}", at: [-14, max_y], height: 5, overflow: :shrink_to_fit, width: 12, valign: :bottom, align: :right unless max.zero?
            prawn.text_box "#{mid}", at: [-14, mid_y], height: 5, overflow: :shrink_to_fit, width: 12, valign: :bottom, align: :right unless mid.zero?
            prawn.text_box "#{avg}", at: [-14, avg_y], height: 5, overflow: :shrink_to_fit, width: 12, valign: :bottom, align: :right unless avg.zero?
            prawn.text_box "#{min}", at: [-14, min_y], height: 5, overflow: :shrink_to_fit, width: 12, valign: :bottom, align: :right unless min.zero?

            return if @canvas.options[:xaxis_labels].size.zero?

            width_of_each_label = (@plot_area_width / @canvas.options[:xaxis_labels].size) - 1
            @canvas.options[:xaxis_labels].each_with_index do |label, i|
              offset    = i + 1
              position  = ((offset * width_of_each_label) - width_of_each_label) + 1
              
              prawn.text_box  label, at: [ position, -2 ], width: width_of_each_label, height: 6, valign: :center, align: :right,
                              overflow: :shrink_to_fit
            end
          end

          # Calculates the relative height of a given point based on the maximum value present in
          # the series.
          #
          def point_height_percentage(value)
            pc = ((BigDecimal(value, 10)/BigDecimal(@series.collect(&:max).max, 10)) * BigDecimal(1)).round(2)
            pc = 0 if pc.nan?
            pc
          end

          def prawn
            @prawn
          end
        end
      end
    end
  end
end
