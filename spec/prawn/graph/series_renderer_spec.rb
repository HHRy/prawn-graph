require 'spec_helper'

describe Prawn::Graph::ChartComponents::SeriesRenderer do
  let(:bounds) { double(width: 800, height: 600) }
  let(:prawn)  { instance_double(Prawn::Document, bounds: bounds, cursor: 600) }


  describe "when creating a new instance" do
    describe "detecting invalid arguments" do
      it "raises an error if a Prawn::Graph::Series is not provided in an array" do
        series = [Object.new]
        canvas = Prawn::Graph::ChartComponents::Canvas.new([Prawn::Graph::Series.new], prawn)

        expect {
          Prawn::Graph::ChartComponents::SeriesRenderer.new(series, canvas)
        }.to raise_error(ArgumentError, "series must be a Prawn::Graph::Series")
      end

      it "raises an error if a Prawn::Graph::Series is not provided on its own" do
        series = Object.new
        canvas = Prawn::Graph::ChartComponents::Canvas.new([Prawn::Graph::Series.new], prawn)

        expect {
          Prawn::Graph::ChartComponents::SeriesRenderer.new(series, canvas)
        }.to raise_error(ArgumentError, "series must be a Prawn::Graph::Series")
      end

      it "raises an error if a Prawn::Graph::ChartComponents::Canvas is not provided" do
        series = Prawn::Graph::Series.new
        canvas = Object.new

        expect {
          Prawn::Graph::ChartComponents::SeriesRenderer.new(series, canvas)
        }.to raise_error(ArgumentError, "canvas must be a Prawn::Graph::ChartComponents::Canvas")
      end
    end

    it "assigns the initial variable correctly" do
      series = [Prawn::Graph::Series.new]
      canvas = Prawn::Graph::ChartComponents::Canvas.new(series, prawn)
      subject = Prawn::Graph::ChartComponents::SeriesRenderer.new(series, canvas)

      expect(subject.instance_variable_get('@series')).to eq(series)
      expect(subject.instance_variable_get('@canvas')).to eq(canvas)
      expect(subject.instance_variable_get('@color')).to eq("000000")
      expect(subject.instance_variable_get('@prawn')).to eq(canvas.prawn)
    end

    it "raises an exception when render is called" do
      series = [Prawn::Graph::Series.new]
      canvas = Prawn::Graph::ChartComponents::Canvas.new(series, prawn)
      subject = Prawn::Graph::ChartComponents::SeriesRenderer.new(series, canvas)

      expect { subject.render }.to raise_error(RuntimeError, "Subclass Me")
    end

  end

end