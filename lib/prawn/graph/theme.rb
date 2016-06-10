module Prawn
  module Graph
    module Theme
      Default = OpenStruct.new({
        series:               [
                                'EBEDEF',
                                'D6DBDF',
                                '85929E',
                                '34495E',
                                '1B2631',
                              ],
        title:                '17202A',
        background:           'FFFFFF',
        grid:                 'F2F4F4',
        axes:                 '17202A',
        markers:              '17202A',
        stroke_grid_lines:    true,
        default:              '333333',
        average:              '34495E',
        max:                  '17202A',
        min:                  '17202A',
        font_sizes:           OpenStruct.new({
          default:      8,
          main_title:   10,
          axis_labels:  5,
          series_key:   8,
        }),
      })
    end
  end
end