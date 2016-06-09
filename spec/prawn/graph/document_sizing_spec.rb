require 'spec_helper'

describe Prawn::Graph::Calculations::DocumentSizing do
  let(:attributes) do
    {"width" => "150", "height" => "200", "viewBox" => "0 -30 300 800", "preserveAspectRatio" => "xMaxYMid meet"}
  end

  let(:bounds) { [1200, 800] }

  let(:sizing) { Prawn::Graph::Calculations::DocumentSizing.new(bounds, attributes) }


  describe "calculuting the sizes of various graph components" do

    describe "width a fixed width and height and a single series and no title" do
      let(:attributes){ { width: 600, height: 200, series_count: 1 } }
      let(:sizing) { Prawn::Graph::Calculations::DocumentSizing.new(bounds, attributes).calculate }

      it "sets the canvas width and height to the values provided" do
        expect(sizing.canvas_width).to  eq(600)
        expect(sizing.canvas_height).to eq(200)
      end 

      it "does not calculate space for the graph key" do
        expect(sizing.series_key_area).to_not be_renderable
      end

      it "does not calculate space for the graph title" do
        expect(sizing.title_area).to_not be_renderable
      end

      it "calculates the size of the graph area within the canvas" do
        expect(sizing.graph_area).to_not be_nil

        expect(sizing.graph_area[:width]).to eq(540)
        expect(sizing.graph_area[:height]).to eq(190)
        expect(sizing.graph_area[:x]).to eq(30)
        expect(sizing.graph_area[:y]).to eq(10)

      end
    end

    describe "width a fixed width and height and 2 series and no title" do
      let(:attributes){ { width: 600, height: 200, series_count: 2 } }
      let(:sizing) { Prawn::Graph::Calculations::DocumentSizing.new(bounds, attributes).calculate }

      it "sets the canvas width and height to the values provided" do
        expect(sizing.canvas_width).to  eq(600)
        expect(sizing.canvas_height).to eq(200)
      end 

      it "calculates space for the graph key" do
        expect(sizing.series_key_area).to be_renderable

        expect(sizing.series_key_area[:width]).to eq(120)
        expect(sizing.series_key_area[:height]).to eq(190)
        expect(sizing.series_key_area[:x]).to eq(450)
        expect(sizing.series_key_area[:y]).to eq(10)
      end

      it "does not calculate space for the graph title" do
        expect(sizing.title_area).to_not be_renderable
      end

      it "calculates the size of the graph area within the canvas" do
        expect(sizing.graph_area).to_not be_nil

        expect(sizing.graph_area[:width]).to eq(420)
        expect(sizing.graph_area[:height]).to eq(190)
        expect(sizing.graph_area[:x]).to eq(30)
        expect(sizing.graph_area[:y]).to eq(10)

      end
    end

    describe "width a fixed width and height and a single series and a title" do
      let(:attributes){ { width: 600, height: 200, series_count: 1, title: "Bob" } }
      let(:sizing) { Prawn::Graph::Calculations::DocumentSizing.new(bounds, attributes).calculate }

      it "sets the canvas width and height to the values provided" do
        expect(sizing.canvas_width).to  eq(600)
        expect(sizing.canvas_height).to eq(200)
      end 

      it "does not calculate space for the graph key" do
        expect(sizing.series_key_area).to_not be_renderable
      end

      it "calculates space for the graph title" do
        expect(sizing.title_area).to be_renderable

        expect(sizing.title_area[:width]).to eq(540)
        expect(sizing.title_area[:height]).to eq(25)
        expect(sizing.title_area[:x]).to eq(30)
        expect(sizing.title_area[:y]).to eq(10)
      end

      it "calculates the size of the graph area within the canvas" do
        expect(sizing.graph_area).to_not be_nil

        expect(sizing.graph_area[:width]).to eq(540)
        expect(sizing.graph_area[:height]).to eq(165)
        expect(sizing.graph_area[:x]).to eq(30)
        expect(sizing.graph_area[:y]).to eq(35)

      end
    end

    describe "width a fixed width and height and 2 series and a title" do
      let(:attributes){ { width: 600, height: 200, series_count: 2, title: "Bob" } }
      let(:sizing) { Prawn::Graph::Calculations::DocumentSizing.new(bounds, attributes).calculate }

      it "sets the canvas width and height to the values provided" do
        expect(sizing.canvas_width).to  eq(600)
        expect(sizing.canvas_height).to eq(200)
      end 

      it "calculates space for the graph key" do
        expect(sizing.series_key_area).to be_renderable

        expect(sizing.series_key_area[:width]).to eq(120)
        expect(sizing.series_key_area[:height]).to eq(190)
        expect(sizing.series_key_area[:x]).to eq(450)
        expect(sizing.series_key_area[:y]).to eq(10)
      end

      it "calculates space for the graph title" do
        expect(sizing.title_area).to be_renderable

        expect(sizing.title_area[:width]).to eq(420)
        expect(sizing.title_area[:height]).to eq(25)
        expect(sizing.title_area[:x]).to eq(30)
        expect(sizing.title_area[:y]).to eq(10)
      end

      it "calculates the size of the graph area within the canvas" do
        expect(sizing.graph_area).to_not be_nil

        expect(sizing.graph_area[:width]).to eq(420)
        expect(sizing.graph_area[:height]).to eq(165)
        expect(sizing.graph_area[:x]).to eq(30)
        expect(sizing.graph_area[:y]).to eq(35)

      end
    end

  end

  describe "#initialize" do
    it "takes bounds and a set of attributes and calls set_from_attributes" do
      expect(sizing.instance_variable_get :@bounds).to eq bounds
      expect(sizing.instance_variable_get :@document_width).to eq "150"
    end
  end
=begin
  describe "#set_from_attributes" do
    let(:sizing) { Prawn::Graph::Calculations::DocumentSizing.new(bounds) }

    it "sets ivars from the passed-in attributes hash" do
      sizing.set_from_attributes(attributes)
      expect(sizing.instance_variable_get :@document_width).to eq "150"
      expect(sizing.instance_variable_get :@document_height).to eq "200"
      expect(sizing.instance_variable_get :@view_box).to eq "0 -30 300 800"
      expect(sizing.instance_variable_get :@preserve_aspect_ratio).to eq "xMaxYMid meet"
    end
  end

  describe "#calculate" do
    it "calculates the document sizing measurements for a given set of inputs" do
      sizing.calculate
      expect(sizing.x_offset).to eq -75 / 0.25
      expect(sizing.y_offset).to eq -30
      expect(sizing.x_scale).to eq 0.25
      expect(sizing.y_scale).to eq 0.25
      expect(sizing.viewport_width).to eq 300
      expect(sizing.viewport_height).to eq 800
      expect(sizing.output_width).to eq 150
      expect(sizing.output_height).to eq 200
    end

    it "scales again based on requested width" do
      sizing.requested_width = 75
      sizing.calculate
      expect(sizing.x_scale).to eq 0.125
      expect(sizing.y_scale).to eq 0.125
      expect(sizing.viewport_width).to eq 300
      expect(sizing.viewport_height).to eq 800
      expect(sizing.output_width).to eq 75
      expect(sizing.output_height).to eq 100
    end

    it "scales again based on requested height" do
      sizing.requested_height = 100
      sizing.calculate
      expect(sizing.x_scale).to eq 0.125
      expect(sizing.y_scale).to eq 0.125
      expect(sizing.viewport_width).to eq 300
      expect(sizing.viewport_height).to eq 800
      expect(sizing.output_width).to eq 75
      expect(sizing.output_height).to eq 100
    end

    it "correctly handles % values being passed in" do
      sizing.document_width = sizing.document_height = "50%"
      sizing.calculate
      expect(sizing.output_width).to eq 600
      expect(sizing.output_height).to eq 400
    end

    context "when SVG does not specify width and height" do
      context "when a viewBox is specified" do
        let(:attributes) { {"viewBox" => "0 0 100 200"} }

        it "defaults to 100% width and the width times aspect ratio in height" do
          sizing.calculate
          expect(sizing.viewport_width).to eq 100
          expect(sizing.viewport_height).to eq 200
          expect(sizing.output_width).to eq 1200
          expect(sizing.output_height).to eq 2400
        end
      end

      context "when a requested width and height are supplied" do
        let(:attributes) { {} }

        it "uses the requested width and height" do
          sizing.requested_width = 550
          sizing.requested_height = 400
          sizing.calculate

          expect(sizing.viewport_width).to eq 550
          expect(sizing.viewport_height).to eq 400
          expect(sizing.output_width).to eq 550
          expect(sizing.output_height).to eq 400
        end
      end

      context "when a viewBox and a requested width/height are supplied" do
        let(:attributes) { {"viewBox" => "0 0 100 200"} }

        it "uses the requested width and height" do
          sizing.requested_width = 550
          sizing.requested_height = 400
          sizing.calculate

          expect(sizing.viewport_width).to eq 100
          expect(sizing.viewport_height).to eq 200
          expect(sizing.output_width).to eq 550
          expect(sizing.output_height).to eq 400
        end
      end

      context "when neither viewBox nor requested width/height specified" do
        let(:attributes) { {} }

        it "defaults to 300x150, because that's what HTML does" do
          sizing.calculate

          expect(sizing.output_width).to eq 300
          expect(sizing.output_height).to eq 150
        end
      end
    end
  end
=end
end
