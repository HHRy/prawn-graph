module Prawn
  module Chart
    
    # Prawn::Chart::Bar plots its values as a Bar graph, relatively
    # sized to fit within the space defined by the Prawn::Chart::Grid
    # associated with it.
    #
    # Call to new will return a new instance of Prawn::Chart::Bar ready to
    # be rendered.
    #
    # Takes an Array of +data+, which should contain complete rows of data for
    # values to be plotted; a reference to a +document+ which should be an 
    # instance of Prawn::Document and an +options+ with at least a value for :at
    # specified.
    #
    # Options are:
    #
    #  :at , which should be an Array representing the point at which the graph
    #  should be drawn.
    #
    #  :title, the title for this graph, wil be rendered centered to the top of 
    #  the Grid.
    #
    #  :label_x, a label to be shown along the X axis of he graph, rendered centered
    #  on the grid.
    #
    #  :label_y, a label to be shown along the Y axis of he graph, rendered centered
    #  on the grid and rotated to be perpendicular to the axis.
    #
    # Data should be formatted like:
    #
    #    [
    #      [ 'Column Heading', SomeValue ],
    #      [ 'Column Heading', SomeValue ],
    #      [ 'Column Heading', SomeValue ],
    #      [ 'Column Heading', SomeValue ],
    #      [ 'Column Heading', SomeValue ],
    #      [ 'Column Heading', SomeValue ]
    #    ]
    #
    class Bar < Base

  
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
          if @colour
            @document.stroke_color [rand(255), rand(255), rand(255), 0]
          else
            @document.stroke_color 'AAAAAA'
          end
          @document.stroke_line_to [base_x + last_position, base_y + bar_height]
          last_position += point_spacing
        end
      end

    end
  end
end
