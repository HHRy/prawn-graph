# encoding: utf-8
#
require "#{File.dirname(__FILE__)}/../example_helper.rb"

# Simplest line chart example
# 

data =  [
          ['January',20],
          ['February',36],
          ['March',45],
          ['April', 5]
        ]

Prawn::Document.generate('line_chart.pdf') do
  line_chart data, :at => [10, 10]
end

