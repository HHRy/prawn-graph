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
        title:                '000000',
        background:           'FFFFFF',
        grid:                 'F2F4F4',
        axes:                 '17202A',
        markers:              '17202A',
        stroke_grid_lines:    true,
        default:              '000000',
        average:              '34495E',
        max:                  '17202A',
        min:                  '17202A',
        font_sizes:           OpenStruct.new({
          default:      10,
          main_title:   15,
          axis_labels:  6,
          series_key:   10,
        }),
      })
    end
  end
end