module Prawn
  module Graph
    module ChartComponents

      # The Prawn::Graph::ChartComponents::SeriesRenderer is used to plot indivdual Prawn::Graph::Series on
      # a Prawn::Graph::ChartComponents::Canvas and its associated Prawn::Document.
      #
      class SeriesRenderer
        # @param series [Prawn::Graph::Series]
        # @param canvas [Prawn::Graph::ChartComponents::Canvas]
        #
        def initialize(series, canvas, color = '000000')
          if series.is_a?(Array)
            raise ArgumentError.new("series must be a Prawn::Graph::Series") unless series.first.is_a?(Prawn::Graph::Series)
          else
            raise ArgumentError.new("series must be a Prawn::Graph::Series") unless series.is_a?(Prawn::Graph::Series)
          end
          raise ArgumentError.new("canvas must be a Prawn::Graph::ChartComponents::Canvas") unless canvas.is_a?(Prawn::Graph::ChartComponents::Canvas)

          @series = series
          @canvas = canvas
          @prawn = canvas.prawn
          @color = color

          @graph_area = @canvas.layout.graph_area

          @plot_area_width  = @graph_area.width - 25
          @plot_area_height = @graph_area.height - 20
        end

        def render
          render_chart
        end

        private

        def render_chart
          raise "Subclass Me"
        end

        def render_axes
          prawn.stroke_color  = @canvas.theme.axes
          prawn.fill_color  = @canvas.theme.axes

          if BigDecimal(min, 2) < BigDecimal(0)
            bot_y = calculate_y_coord(min)
          else
            bot_y = 0
          end

          old = prawn.line_width 
          prawn.line_width = 1

          prawn.stroke_horizontal_line(0, @plot_area_width, at: 0) 
          prawn.stroke_vertical_line(bot_y, @plot_area_height, at: 0) 
          prawn.fill_and_stroke_ellipse [ 0,0], 1

          add_y_axis_label(max)
          add_y_axis_label(min)
          add_y_axis_label(avg)
          add_y_axis_label(mid)

          add_x_axis_labels

          prawn.line_width = old
        end

        def add_x_axis_labels 
          return if @canvas.options[:xaxis_labels].size.zero?
          width_of_each_label = (@plot_area_width / @canvas.options[:xaxis_labels].size) - 1
          @canvas.options[:xaxis_labels].each_with_index do |label, i|
            offset    = i + 1
            position  = ((offset * width_of_each_label) - width_of_each_label) + 1
            
            prawn.text_box  label, at: [ position, -2 ], width: width_of_each_label, height: 6, valign: :center, align: :center,
                            overflow: :shrink_to_fit
          end
        end

        def calculate_y_coord(value)
          return 0 if value.zero?
          (point_height_percentage(value) * @plot_area_height)
        end

        def add_y_axis_label(value)
          unless value.zero?
            y = (point_height_percentage(value) * @plot_area_height)
            prawn.text_box "#{value}", at: [-14, y], height: 5, overflow: :shrink_to_fit, width: 12, valign: :bottom, align: :right 
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

        def max 
          @series.max || 0
        end

        def min
          @series.min || 0
        end

        def avg
          @series.avg || 0
        end

        def mid
          (min + max) / 2 rescue 0
        end

        def draw_marker_point(color, x_position, y_position)
          prawn.save_graphics_state do
            prawn.fill_color = color
            prawn.stroke_color = color
            prawn.line_width = 1

            prawn.dash(2)
            prawn.stroke_line([x_position, 0], [x_position, y_position])
            prawn.undash

            prawn.fill_ellipse([x_position, y_position ], 2)
            return true
          end
        end

      end
    end
  end
end
