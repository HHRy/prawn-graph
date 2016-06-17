require 'spec_helper'

describe "Prawn graph when loaded and createing a new document, allows a Prawn::Document to" do

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

