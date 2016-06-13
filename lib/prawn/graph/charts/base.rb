module Prawn
  module Graph
    module Charts

      class Base
        VALID_OPTIONS = [:at, :width, :height]
        attr_reader :series, :prawn, :options, :lowest_value, :highest_value

        def initialize(data, prawn, options = {}, &block)
          Prawn.verify_options VALID_OPTIONS, options

          if data.is_a?(Array) || (!data.is_a?(Array) && data.is_a?(Prawn::Graph::Series))
            data = [ data ] unless data.is_a?(Array) 
          else
            raise ArgumentError.new("data must be a multidimensional Array, array of Prawn::Graph::Series or a single Prawn::Graph::Series")
          end

          @series = []
          data.each do |s|
            if s.is_a?(Prawn::Graph::Series)
              @series << s
            else
              title = s.shift
              @series << Prawn::Graph::Series.new(s, title: title, type: series_type)
            end
          end
          
          @prawn = prawn
          @options = options
          calculate_extreme_values!
        end

        def titles
          @series.collect(&:title)
        end

        def position
        end

        def draw
          chart_object.draw
        end

        private

        def chart_object
          raise RuntimeError.new("I need to be subclassed.")
        end

        def series_type
          :bar
        end

        def calculate_extreme_values!
          @lowest_value = @series.collect(&:min).min
          @highest_value = @series.collect(&:max).max
        end

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