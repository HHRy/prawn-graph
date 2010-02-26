# encoding: utf-8
#
require "#{File.dirname(__FILE__)}/../example_helper.rb"

# Simplest bar chart example
# 

data =  [
          ['Cats',20],
          ['Dogs',36],
          ['Hamsters',45],
          ['Goldfish', 5]
        ]

Prawn::Document.generate('bar_chart.pdf') do
  bar_chart data, :at => [10, 10], :theme => Prawn::Chart::Themes.keynote
end

