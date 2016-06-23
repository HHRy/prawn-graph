module Prawn
  module Graph

    # A Prawn::Graph::Theme
    #
    class Theme
      DEFAULT_SERIES_COLORS           = [
                                          'EBEDEF',
                                          'D6DBDF',
                                          '85929E',
                                          '34495E',
                                          '1B2631',
                                          'EBEDEF',
                                          'D6DBDF',
                                          '85929E',
                                          '34495E',
                                          '1B2631',
                                          'EBEDEF',
                                          'D6DBDF',
                                          '85929E',
                                          '34495E',
                                          '1B2631',
                                        ]
      DEFAULT_TITLE_COLOR             = '17202A'
      DEFAULT_BACKGROUND_COLOR        = 'FFFFFF'
      DEFAULT_GRID_COLOR              = 'F2F4F4'
      DEFAULT_AXES_COLOR              = '17202A'
      DEFAULT_MARKERS_STROKE_COLOR    = '34495E'
      DEFAULT_STROKE_GRID_LINES       = true
      DEFAULT_TEXT_COLOR              = '333333'
      DEFAULT_MAX_COLOR               = '17202A'
      DEFAULT_MIN_COLOR               = '17202A'

      Default = Prawn::Graph::Theme.new

      attr_accessor :series, :min, :max, :title, :text, :background, :grid,
                    :axes, :markers, :stroke_grid_lines

      def initialize(theme = {})
        @series             = theme[:series]              || Prawn::Graph::Theme::DEFAULT_SERIES_COLORS
        @max                = theme[:max]                 || Prawn::Graph::Theme::DEFAULT_MAX_COLOR
        @min                = theme[:min]                 || Prawn::Graph::Theme::DEFAULT_MIN_COLOR
        @title              = theme[:title]               || Prawn::Graph::Theme::DEFAULT_TITLE_COLOR
        @text               = theme[:text]                || Prawn::Graph::Theme::DEFAULT_TEXT_COLOR
        @background         = theme[:background]          || Prawn::Graph::Theme::DEFAULT_BACKGROUND_COLOR
        @grid               = theme[:grid]                || Prawn::Graph::Theme::DEFAULT_GRID_COLOR
        @axes               = theme[:axes]                || Prawn::Graph::Theme::DEFAULT_AXES_COLOR
        @markers            = theme[:markers]             || Prawn::Graph::Theme::DEFAULT_MARKERS_STROKE_COLOR
        @stroke_grid_lines  = theme[:stroke_grid_lines]   || Prawn::Graph::Theme::DEFAULT_STROKE_GRID_LINES

        @series_counter     = 0
      end

      def next_series_color
        @series_counter = @series_counter > (@series.size - 1) ? 0 : @series_counter
        s = series[@series_counter]
        @series_counter += 1
        s
      end

      def average
        series[@series_counter - 1]
      end

      def default
        Prawn::Graph::Theme::DEFAULT_TEXT_COLOR
      end

      def stroke_grid_lines?
        !!stroke_grid_lines
      end

      def font_sizes          
        OpenStruct.new({
          default:      8,
          main_title:   10,
          axis_labels:  5,
          series_key:   8,
        })
      end

    end
  end
end