require 'spec_helper'

describe Prawn::Graph::ChartComponents::SeriesRenderer do
  let(:bounds) { double(width: 800, height: 600) }
  let(:prawn)  { instance_double(Prawn::Document, bounds: bounds, cursor: 600) }


  describe "when creating a new instance" do
    describe "detecting invalid arguments" do
      it "raises an error if a Prawn::Graph::Series is not provided" do
        series = Object.new
        canvas = Prawn::Graph::ChartComponents::Canvas.new([Prawn::Graph::Series.new], prawn)

        expect {
          Prawn::Graph::ChartComponents::SeriesRenderer.new(series, prawn)
        }.to raise_error(ArgumentError, "series must be a Prawn::Graph::Series")
      end

      it "raises an error if a Prawn::Graph::ChartComponents::Canvas is not provided" do
        series = Prawn::Graph::Series.new
        canvas = Object.new

        expect {
          Prawn::Graph::ChartComponents::SeriesRenderer.new(series, prawn)
        }.to raise_error(ArgumentError, "canvas must be a Prawn::Graph::ChartComponents::Canvas")
      end
    end
  end

end