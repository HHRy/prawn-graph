require 'ostruct'

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
        stroke_grid_markers:  true,
      })
    end
  end
end