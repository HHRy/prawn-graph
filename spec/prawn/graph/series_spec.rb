require 'spec_helper'

describe Prawn::Graph::Series do

  describe "when initialized by an array" do
    it "knows the maximum value" do
      expect(Prawn::Graph::Series.new([1,2,5,4,3]).max).to eq(5)
    end

    it "knows the minimum value" do
      expect(Prawn::Graph::Series.new([1,2,5,4,3]).min).to eq(1)
    end

    it "knows its size" do
      expect(Prawn::Graph::Series.new([1,2,5,4,3]).size).to eq(5)
    end

    it "defaults to a bar chart" do
      expect(Prawn::Graph::Series.new([1,2,5,4,3]).type).to eq(:bar)
    end
  end

  describe "when left to its default values" do
    it "has a maximum of 0" do
      expect(Prawn::Graph::Series.new().max).to eq(0)
    end

    it "has a minimum of 0" do
      expect(Prawn::Graph::Series.new().min).to eq(0)
    end

    it "has a size of 0" do
      expect(Prawn::Graph::Series.new().size).to eq(0)
    end

    it "defaults to a bar chart" do
      expect(Prawn::Graph::Series.new().type).to eq(:bar)
    end
  end

  describe "When it is turning itself into an array" do
    it "correctly marshalls titles and values when both are set" do
      series = Prawn::Graph::Series.new([1,2], 'A')
      expect(series.to_a).to eql(["A", 1, 2])
    end

    it "returns an empty array with the default values" do
      series = Prawn::Graph::Series.new()
      expect(series.to_a).to eql([])
    end

    it "returns just the values when no title is set" do
      series = Prawn::Graph::Series.new([1,2,3])
      expect(series.to_a).to eql([1,2,3])
    end
  end

end