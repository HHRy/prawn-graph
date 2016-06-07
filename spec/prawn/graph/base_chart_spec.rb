require 'spec_helper'

describe Prawn::Graph::Charts::Base do
  let(:bounds) { double(width: 800, height: 600) }
  let(:prawn)  { instance_double(Prawn::Document, bounds: bounds, cursor: 600) }
  let(:data)   { [ ['A',2], ['B',8], ['C',23] ] }

  describe "when creating a new instance" do
    describe "the invalid option detection" do
      it "rejects invalid options when debug is on" do
        allow(Prawn).to receive(:debug).and_return(true)

        expect {
          Prawn::Graph::Charts::Base.new(data, prawn, :invalid => "option")
        }.to raise_error(Prawn::Errors::UnknownOption)
      end

      it "does nothing if an invalid option is given and debug is off" do
        Prawn::Graph::Charts::Base.new(data, prawn, :invalid => "option")
      end
    end

    describe "parsing the provided data" do
      it "correctly populates the titles" do
        subject = Prawn::Graph::Charts::Base.new(data, prawn)
        expect(subject.titles).to eq(['A','B','C'])
      end

      it "correctly populates the series" do
        subject = Prawn::Graph::Charts::Base.new(data, prawn)
        expect(subject.series.size).to eq(3)
      end

      it "correctly sets the minimum value" do
        subject = Prawn::Graph::Charts::Base.new(data, prawn)
        expect(subject.lowest_value).to eq(2)
      end

      it "correctly sets the maximum value" do
        subject = Prawn::Graph::Charts::Base.new(data, prawn)
        expect(subject.highest_value).to eq(23)
      end    
    end
  end

end