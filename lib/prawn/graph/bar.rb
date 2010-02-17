module Prawn
  module Chart
    class Bar
      
      attr_accessor :grid, :headings, :values, :highest_value, :document, :colour

      def initialize(data, document, options = {})
        if options[:at].nil? || options[:at].empty?
          raise Prawn::Errors::NoGraphStartSet,
            "you must specify options[:at] as the coordinates wher you" +
            " wish this graph to be drawn from."
        end
        opts = { :width => 500, :height => 200, :spacing => 20 }.merge(options)
        (@headings, @values, @highest_value) = process_the data
        (grid_x_start, grid_y_start, grid_width, grid_height) = parse_sizing_from opts 
        @colour = (!opts[:use_color].nil? || !opts[:use_colour].nil?)
        @document = document
        @grid = Prawn::Chart::Grid.new(grid_x_start, grid_y_start, grid_width, grid_height, opts[:spacing], document)
      end
  
      def draw
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

      def reset
        @document.line_width 1
        @document.stroke_color '000000'
        @document.fill_color '000000'
        @document.move_to @grid.point
      end

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
          if @colour
            @document.stroke_color [rand(255), rand(255), rand(255), 0]
          else
            @document.stroke_color 'AAAAAA'
          end
          @document.stroke_line_to [base_x + last_position, base_y + bar_height]
          last_position += point_spacing
        end
      end

      def label_axes
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
      end

      def draw_x_axis_label
        x_coord = calculate_x_axis_center_point(@x_label, 8)
        y_coord = @grid.start_y - 30
        @document.draw_text @x_label, :at => [x_coord, y_coord] ,:size => 8
      end

      def draw_y_axis_label
        y_coord = calculate_y_axis_center_point(@y_label, 8)
        x_coord = @grid.start_x - 30
        @document.draw_text @y_label, :at => [x_coord, y_coord] ,:size => 8, :rotate => 90
      end

      def draw_title
        x_coord = calculate_x_axis_center_point(@title, 10)
        y_coord = @grid.start_y + @grid.height + 10
        @document.draw_text @title, :at => [x_coord, y_coord] ,:size => 10
      end

      def parse_sizing_from(o)
        x_offset = 15
        y_offset = 0
        move_y_up = 0
        grid_width = o[:width]
        grid_height = o[:height]

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
        [ (o[:at][0] + x_offset), (o[:at][1] + move_y_up), (grid_width - x_offset), (grid_height - y_offset) ]
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
        (@grid.width / @values.nitems)
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
