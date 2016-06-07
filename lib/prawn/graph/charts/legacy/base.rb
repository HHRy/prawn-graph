require "bigdecimal" 

module Prawn
  module Graph
    module Charts
      module Legacy

        class Base
              
          attr_accessor :grid, :headings, :values, :highest_value, :document, :colour
          
          def initialize(data, document, options = {})
            opts = { :theme => Prawn::Graph::Theme::Default, :width => 500, :height => 200, :spacing => 20, :at => [0,0] }.merge(options)
            (@headings, @values, @highest_value) = process_the data
            (grid_x_start, grid_y_start, grid_width, grid_height) = parse_sizing_from opts 
            @colour = false
            @document = document
            @theme = Prawn::Graph::Theme::Default
            @grid = Prawn::Graph::Charts::Legacy::Grid.new(grid_x_start, grid_y_start, grid_width, grid_height, opts[:spacing], document, Prawn::Graph::Theme::Default)
          end

          # Draws the graph on the document which we have a reference to.
          #
          def draw
            draw_bounding_box
            @grid.draw
            label_axes
            if @title
              draw_title
            end
            plot_values
            if @x_label
              draw_x_axis_label
            end 
            if @y_label
              draw_y_axis_label
            end 
           reset
          end

          private

          def draw_bounding_box
            @document.fill_color @theme.background
            @document.fill_and_stroke_rectangle [(@point.first - 10), (@point.last + ( @total_height + 40 ))], @document.bounds.width, (@total_height + 40)
            @document.fill_color '000000'
          end   

          def label_axes
            @document.fill_color @theme.title
            base_x = @grid.start_x + 1
            base_y = @grid.start_y + 1

            # Put the values up the Y Axis
            #
            @document.draw_text @highest_value, :at => [base_x - 15, base_y + @grid.height], :size => 5
            @document.draw_text '0', :at => [base_x - 15, base_y ], :size => 5

            # Put the column headings along the X Axis
            #
            point_spacing = calculate_plot_spacing 
            last_position = base_x + (point_spacing / 2)
            @headings.each do |heading|
              @document.draw_text heading, :at => [last_position, base_y - 15 ], :size => 5
              last_position += point_spacing
            end
            @document.fill_color @theme.background
          end

          def draw_title
            @document.fill_color @theme.title
            x_coord = calculate_x_axis_center_point(@title, 10)
            y_coord = @grid.start_y + @grid.height + 10
            @document.draw_text @title, :at => [x_coord, y_coord] ,:size => 10
            @document.fill_color @theme.background
          end

          def draw_x_axis_label
            @document.fill_color @theme.axes
            x_coord = calculate_x_axis_center_point(@x_label, 8)
            y_coord = @grid.start_y - 30
            @document.draw_text @x_label, :at => [x_coord, y_coord] ,:size => 8
            @document.fill_color @theme.background
          end

          def draw_y_axis_label
            @document.fill_color @theme.axes
            y_coord = calculate_y_axis_center_point(@y_label, 8)
            x_coord = @grid.start_x - 30
            @document.draw_text @y_label, :at => [x_coord, y_coord] ,:size => 8, :rotate => 90
            @document.fill_color @theme.background
          end
          
          # All subclasses of Prawn::Chart::Base must implement thier own plot_values
          # method, which does the actual real heavy lifting of drawing the graph.
          #
          def plot_values
            raise RuntimeError.new('subclasses of Prawn::Chart::Base must implement their own plot_values method')
          end

          def reset
            @document.line_width 1
            @document.stroke_color '000000'
            @document.fill_color '000000'
            @document.move_to @grid.point
          end


          # Utility methods for dealing with working out where things should be
          # the calculations and such done here are all very rough, but are
          # sufficient for now to plot just what we need.
          #
          
          
          def parse_sizing_from(o)
            x_offset = 15
            y_offset = 0
            move_y_up = 0
            grid_width = o[:width]
            grid_height = o[:height]
          
            @total_width = o[:width]
            @total_height = o[:height]
            @point = o[:at].dup 

            # Make room for the title if we're choosing to Render it.
            #
            if o[:title]
              @title = o[:title]
              y_offset += 10 
            end

            # Make room for X Axis labels if we're using them.
            #
            if o[:label_x]
              y_offset += 30
              move_y_up += 30
              @x_label = o[:label_x]
            end

            # Make room for Y Axis labels if we're using them.
            #
            if o[:label_y]
              @y_label = o[:label_y]
              x_offset += 15
            end


            # Return the values calculated here.
            #
            [ (o[:at][0] + x_offset), (o[:at][1] + move_y_up + 20), (grid_width - (x_offset - 20)), (grid_height - y_offset) ]
          end

          def process_the(data_array)
            col = []
            val = []
            data_array.each { |i| val << i[1]; col << i[0] }
            [ col, val ,val.sort.last ]
          end

          def calculate_x_axis_center_point(text, text_size, graph_start_x = @grid.start_x, graph_width = @grid.width)
            ((graph_start_x + (graph_width / 2)) - ((text.length * text_size) / 4))
          end
          alias calculate_x_axis_centre_point calculate_x_axis_center_point

          def calculate_y_axis_center_point(text, text_size, graph_start_y = @grid.start_y, graph_height = @grid.height)
            ((graph_start_y + (graph_height / 2)) - ((text.length * text_size) / 4))
          end
          alias calculate_y_axis_centre_point calculate_y_axis_center_point

          def calculate_plot_spacing
            (@grid.width / @values.count)
          end

          def calculate_bar_width
            calculate_plot_spacing / 2
          end

          def calculate_point_height_from(column_value)
            cv = BigDecimal("#{column_value}")
            hv = BigDecimal("#{@highest_value}")
            gh = BigDecimal("#{@grid.height}")
            percentage = (cv / (hv / 100))
            ((gh / 100) * percentage).to_i
          end


        end

      end
    end
  end
end