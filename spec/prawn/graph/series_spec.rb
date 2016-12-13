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

    it "knows its average value" do
      expect(Prawn::Graph::Series.new([1,2,5,4,3]).avg).to eq(3)
    end

    it "defaults to a bar chart" do
      expect(Prawn::Graph::Series.new([1,2,5,4,3]).type).to eq(:bar)
    end

    it "defaults to false for mark_average?" do
      expect(Prawn::Graph::Series.new([1,2,5,4,3]).mark_average?).to eq(false)
    end
    
    it "defaults to false for mark_minimum?" do
      expect(Prawn::Graph::Series.new([1,2,5,4,3]).mark_minimum?).to eq(false)
    end
    
    it "defaults to false for mark_maximum?" do
      expect(Prawn::Graph::Series.new([1,2,5,4,3]).mark_maximum?).to eq(false)
    end

    it "has a uuid" do
      expect(Prawn::Graph::Series.new([1,2,5,4,3]).uuid).to_not be_nil
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

    it "has an average of 0" do
      expect(Prawn::Graph::Series.new().avg).to eq(0)
    end

    it "defaults to a bar chart" do
      expect(Prawn::Graph::Series.new().type).to eq(:bar)
    end

    it "defaults to false for mark_average?" do
      expect(Prawn::Graph::Series.new().mark_average?).to eq(false)
    end
    
    it "defaults to false for mark_minimum?" do
      expect(Prawn::Graph::Series.new().mark_minimum?).to eq(false)
    end
    
    it "defaults to false for mark_maximum?" do
      expect(Prawn::Graph::Series.new().mark_maximum?).to eq(false)
    end
  end

  describe "when setting the options for rendering averages, maximum points and minimum points" do
    it "defaults to false for mark_average?" do
      expect(Prawn::Graph::Series.new().mark_average?).to eq(false)
    end
    
    it "defaults to false for mark_minimum?" do
      expect(Prawn::Graph::Series.new().mark_minimum?).to eq(false)
    end
    
    it "defaults to false for mark_maximum?" do
      expect(Prawn::Graph::Series.new().mark_maximum?).to eq(false)
    end

    it "sets the value as true for mark_average? when you specifiy the option" do
      expect(Prawn::Graph::Series.new([],{mark_average: true}).mark_average?).to eq(true)
    end
    
    it "sets the value as true for mark_minimum? when you specifiy the option" do
      expect(Prawn::Graph::Series.new([],{mark_minimum: true}).mark_minimum?).to eq(true)
    end
    
    it "sets the value as true for mark_maximum? when you specifiy the option" do
      expect(Prawn::Graph::Series.new([],{mark_maximum: true}).mark_maximum?).to eq(true)
    end
  end

end