require 'spec_helper'

describe Prawn::Graph::ChartComponents::Canvas do
  let(:bounds) { double(width: 800, height: 600) }
  let(:prawn)  { instance_double(Prawn::Document, bounds: bounds, cursor: 600) }

  describe "when creating a new instance" do

    describe "the invalid data object detection" do

      it "rejects a data object that isn't an array" do
        data = Object.new

        expect {
          Prawn::Graph::ChartComponents::Canvas.new(data, prawn)
        }.to raise_error(RuntimeError, "Series provided must be an Array (or Array-like) object.")
      end

      it "rejects a data object that isn't an array of the correct types" do
        data = [1,2,3]

        expect {
          Prawn::Graph::ChartComponents::Canvas.new(data, prawn)
        }.to raise_error(RuntimeError, "All of the items provided must be instances of Prawn::Graph::Series")
      end


      it "rejects a data object that is a mix of correct and incorrect types" do
        data = [1,Prawn::Graph::Series.new,3]

        expect {
          Prawn::Graph::ChartComponents::Canvas.new(data, prawn)
        }.to raise_error(RuntimeError, "All of the items provided must be instances of Prawn::Graph::Series")
      end
    end

    describe "the instaniated values" do
      it "sets the instance variables as expected" do
        subject = Prawn::Graph::ChartComponents::Canvas.new([Prawn::Graph::Series.new], prawn)

        expect(subject.instance_variable_get :@prawn).to eq(prawn)
        expect(subject.instance_variable_get :@sizing).to be_a(Prawn::Graph::Calculations::LayoutCalculator)
        expect(subject.instance_variable_get :@theme).to eq(Prawn::Graph::Theme::Default)
      end
    end
  end

  describe "A valid instance of a Prawn::Graph::ChartComponents::Canvas" do
    describe "#position" do
      it "defaults to [0,0] if no :at option is set" do
        subject = Prawn::Graph::ChartComponents::Canvas.new([Prawn::Graph::Series.new], prawn)
        expect(subject.position).to eq([0,0])
      end

      it "returns the value provided in options if it is provided" do
        subject = Prawn::Graph::ChartComponents::Canvas.new([Prawn::Graph::Series.new], prawn, at: [ 100, 200 ])
        expect(subject.position).to eq([100,200])
      end
    end
  end
end