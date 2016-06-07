module Prawn
  module Graph
    module Charts

      class Base
        VALID_OPTIONS = [:at, :width, :height]
        attr_reader :data, :prawn, :document, :options, :headings, :values, :lowest_value, :highest_value

        def initialize(data, prawn, options = {}, &block)
          Prawn.verify_options VALID_OPTIONS, options
          @data = data
          @prawn = prawn
          @options = options
          (@headings, @values, @lowest_value, @highest_value) = process_the data
        end

        def position
        end

        def draw
        end

        private

        def process_the(data_array)
          col = []
          val = []
          data_array.each { |i| val << i[1]; col << i[0] }
          [ col, val, val.min, val.max ]
        end

      end
    end
  end
end