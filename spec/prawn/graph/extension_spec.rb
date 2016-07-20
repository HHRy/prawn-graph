require 'spec_helper'

describe "Prawn graph when loaded and creating a new document, allows a Prawn::Document to" do

  let(:enabled_methods){ [:graph] }
  let(:enabled_aliases){ [:chart] }

  it "have the expected graph methods available to it" do
    enabled_methods.each do |method|
      expect(Prawn::Document.new.respond_to?(method)).to eq(true)
    end
  end

  it "have the expected aliases of the graph methods available to it." do
    enabled_aliases.each do |item|
      expect(Prawn::Document.new.respond_to?(item)).to eq(true)
    end
  end
end

describe "The extension itself" do
  let(:canvas) { double("canvas", draw: true) }

  it "builds a new canvas" do
    expect(Prawn::Graph::ChartComponents::Canvas).to receive(:new).and_return(canvas)

    g = Prawn::Document.new

    g.graph([Prawn::Graph::Series.new()])
  end
end