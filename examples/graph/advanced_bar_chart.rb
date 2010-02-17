
require "#{File.dirname(__FILE__)}/../example_helper.rb"

options = {
            :title => 'Average litter size per kind of animal',
            :label_x => 'Kind of animal',
            :label_y => 'Average litter size',
            :at => [10,10],
          }

data =    [
            ['Raccoons', 4],
            ['Mice', 11],
            ['Dogs', 6],
            ['Panda', 1],
            ['Gorilla', 1],
            ['Cats', 4]
          ]

Prawn::Document.generate('advanced_bar_chart.pdf') do
  bar_chart data, options
end
