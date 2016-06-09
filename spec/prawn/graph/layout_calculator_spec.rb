require 'spec_helper'

describe Prawn::Graph::Calculations::LayoutCalculator do
  let(:bounds) { [1200, 800] }
  let(:sizing) { Prawn::Graph::Calculations::LayoutCalculator.new(bounds, attributes) }

  describe "calculating the sizes of various graph components" do
    describe "when no width and no height is specified for the canvas" do
      describe "with one series and no title" do
        let(:attributes){ { series_count: 1 } }
        let(:sizing) { Prawn::Graph::Calculations::LayoutCalculator.new(bounds, attributes).calculate }

        it "sizes the canvas to fill the document bounds" do
          expect(sizing.canvas_width).to  eq(1200)
          expect(sizing.canvas_height).to eq(800)
        end

        it "does not calculate space for the graph key" do
          expect(sizing.series_key_area).to_not be_renderable
        end

        it "does not calculate space for the graph title" do
          expect(sizing.title_area).to_not be_renderable
        end

        it "calculates the size of the graph area within the canvas" do
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(1080)
          expect(sizing.graph_area[:height]).to eq(760)
          expect(sizing.graph_area[:x]).to eq(60)
          expect(sizing.graph_area[:y]).to eq(40)
        end
      end

      describe "with one series and a title" do
        let(:attributes){ { series_count: 1, title: 'Bob' } }
        let(:sizing) { Prawn::Graph::Calculations::LayoutCalculator.new(bounds, attributes).calculate }

        it "sizes the canvas to fill the document bounds" do
          expect(sizing.canvas_width).to  eq(1200)
          expect(sizing.canvas_height).to eq(800)
        end

        it "does not calculate space for the graph key" do
          expect(sizing.series_key_area).to_not be_renderable
        end

        it "calculates space for the graph title" do
          expect(sizing.title_area).to be_renderable

          expect(sizing.title_area[:width]).to eq(1080)
          expect(sizing.title_area[:height]).to eq(55)
          expect(sizing.title_area[:x]).to eq(60)
          expect(sizing.title_area[:y]).to eq(40)
        end

        it "calculates the size of the graph area within the canvas" do
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(1080)
          expect(sizing.graph_area[:height]).to eq(705)
          expect(sizing.graph_area[:x]).to eq(60)
          expect(sizing.graph_area[:y]).to eq(-15)
        end
      end

      describe "with many series and no title" do
        let(:attributes){ { series_count: 3 } }
        let(:sizing) { Prawn::Graph::Calculations::LayoutCalculator.new(bounds, attributes).calculate }

        it "sizes the canvas to fill the document bounds" do
          expect(sizing.canvas_width).to  eq(1200)
          expect(sizing.canvas_height).to eq(800)
        end

        it "calculates space for the graph key" do
          expect(sizing.series_key_area).to be_renderable

          expect(sizing.series_key_area[:width]).to eq(240)
          expect(sizing.series_key_area[:height]).to eq(760)
          expect(sizing.series_key_area[:x]).to eq(900)
          expect(sizing.series_key_area[:y]).to eq(40)
        end

        it "does not calculate space for the graph title" do
          expect(sizing.title_area).to_not be_renderable
        end

        it "calculates the size of the graph area within the canvas" do
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(840)
          expect(sizing.graph_area[:height]).to eq(760)
          expect(sizing.graph_area[:x]).to eq(60)
          expect(sizing.graph_area[:y]).to eq(40)
        end
      end

      describe "with many series and a title" do
        let(:attributes){ { series_count: 3, title: 'Bob' } }
        let(:sizing) { Prawn::Graph::Calculations::LayoutCalculator.new(bounds, attributes).calculate }

        it "sizes the canvas to fill the document bounds" do
          expect(sizing.canvas_width).to  eq(1200)
          expect(sizing.canvas_height).to eq(800)
        end

        it "calculates space for the graph key" do
          expect(sizing.series_key_area).to be_renderable

          expect(sizing.series_key_area[:width]).to eq(240)
          expect(sizing.series_key_area[:height]).to eq(760)
          expect(sizing.series_key_area[:x]).to eq(900)
          expect(sizing.series_key_area[:y]).to eq(40)
        end

        it "calculates space for the graph title" do
          expect(sizing.title_area).to be_renderable

          expect(sizing.title_area[:width]).to eq(840)
          expect(sizing.title_area[:height]).to eq(55)
          expect(sizing.title_area[:x]).to eq(60)
          expect(sizing.title_area[:y]).to eq(40)
        end

        it "calculates the size of the graph area within the canvas" do
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(840)
          expect(sizing.graph_area[:height]).to eq(705)
          expect(sizing.graph_area[:x]).to eq(60)
          expect(sizing.graph_area[:y]).to eq(-15)
        end
      end
    end

    describe "when a width and a height is specified for the canvas" do
      describe "with a single series and no title" do
        let(:attributes){ { width: 600, height: 200, series_count: 1 } }
        let(:sizing) { Prawn::Graph::Calculations::LayoutCalculator.new(bounds, attributes).calculate }

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
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(540)
          expect(sizing.graph_area[:height]).to eq(190)
          expect(sizing.graph_area[:x]).to eq(30)
          expect(sizing.graph_area[:y]).to eq(10)

        end
      end

      describe "with 2 series and no title" do
        let(:attributes){ { width: 600, height: 200, series_count: 2 } }
        let(:sizing) { Prawn::Graph::Calculations::LayoutCalculator.new(bounds, attributes).calculate }

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
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(420)
          expect(sizing.graph_area[:height]).to eq(190)
          expect(sizing.graph_area[:x]).to eq(30)
          expect(sizing.graph_area[:y]).to eq(10)
        end
      end

      describe "with a single series and a title" do
        let(:attributes){ { width: 600, height: 200, series_count: 1, title: "Bob" } }
        let(:sizing) { Prawn::Graph::Calculations::LayoutCalculator.new(bounds, attributes).calculate }

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
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(540)
          expect(sizing.graph_area[:height]).to eq(165)
          expect(sizing.graph_area[:x]).to eq(30)
          expect(sizing.graph_area[:y]).to eq(-15 )

        end
      end

      describe "with 2 series and a title" do
        let(:attributes){ { width: 600, height: 200, series_count: 2, title: "Bob" } }
        let(:sizing) { Prawn::Graph::Calculations::LayoutCalculator.new(bounds, attributes).calculate }

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
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(420)
          expect(sizing.graph_area[:height]).to eq(165)
          expect(sizing.graph_area[:x]).to eq(30)
          expect(sizing.graph_area[:y]).to eq(-15)

        end
      end
    end

    describe "when no height is specified for the canvas, but a width is" do
      describe "with one series and no title" do
        let(:attributes){ { series_count: 1, width: 700 } }
        let(:sizing) { Prawn::Graph::Calculations::LayoutCalculator.new(bounds, attributes).calculate }

        it "sizes the canvas to reflect the aspect ratio of the bounding box provided" do
          expect(sizing.canvas_width).to  eq(700)
          expect(sizing.canvas_height).to eq(467)
        end

        it "does not calculate space for the graph key" do
          expect(sizing.series_key_area).to_not be_renderable
        end

        it "does not calculate space for the graph title" do
          expect(sizing.title_area).to_not be_renderable
        end

        it "calculates the size of the graph area within the canvas" do
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(630)
          expect(sizing.graph_area[:height]).to eq(444)
          expect(sizing.graph_area[:x]).to eq(35)
          expect(sizing.graph_area[:y]).to eq(23)
        end
      end

      describe "with one series and a title" do
        let(:attributes){ { series_count: 1, title: 'Bob', width: 700 } }
        let(:sizing) { Prawn::Graph::Calculations::LayoutCalculator.new(bounds, attributes).calculate }

        it "sizes the canvas to reflect the aspect ratio of the bounding box provided" do
          expect(sizing.canvas_width).to  eq(700)
          expect(sizing.canvas_height).to eq(467)
        end

        it "does not calculate space for the graph key" do
          expect(sizing.series_key_area).to_not be_renderable
        end

        it "calculates space for the graph title" do
          expect(sizing.title_area).to be_renderable

          expect(sizing.title_area[:width]).to eq(630)
          expect(sizing.title_area[:height]).to eq(38)
          expect(sizing.title_area[:x]).to eq(35)
          expect(sizing.title_area[:y]).to eq(23)
        end

        it "calculates the size of the graph area within the canvas" do
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(630)
          expect(sizing.graph_area[:height]).to eq(406)
          expect(sizing.graph_area[:x]).to eq(35)
          expect(sizing.graph_area[:y]).to eq(-15)
        end
      end

      describe "with many series and no title" do
        let(:attributes){ { series_count: 3, width: 700 } }
        let(:sizing) { Prawn::Graph::Calculations::LayoutCalculator.new(bounds, attributes).calculate }

        it "sizes the canvas to reflect the aspect ratio of the bounding box provided" do
          expect(sizing.canvas_width).to  eq(700)
          expect(sizing.canvas_height).to eq(467)
        end

        it "calculates space for the graph key" do
          expect(sizing.series_key_area).to be_renderable

          expect(sizing.series_key_area[:width]).to eq(140)
          expect(sizing.series_key_area[:height]).to eq(444)
          expect(sizing.series_key_area[:x]).to eq(525)
          expect(sizing.series_key_area[:y]).to eq(23)
        end

        it "does not calculate space for the graph title" do
          expect(sizing.title_area).to_not be_renderable
        end

        it "calculates the size of the graph area within the canvas" do
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(490)
          expect(sizing.graph_area[:height]).to eq(444)
          expect(sizing.graph_area[:x]).to eq(35)
          expect(sizing.graph_area[:y]).to eq(23)
        end
      end

      describe "with many series and a title" do
        let(:attributes){ { series_count: 3, title: 'Bob', width: 700 } }
        let(:sizing) { Prawn::Graph::Calculations::LayoutCalculator.new(bounds, attributes).calculate }

        it "sizes the canvas to reflect the aspect ratio of the bounding box provided" do
          expect(sizing.canvas_width).to  eq(700)
          expect(sizing.canvas_height).to eq(467)
        end

        it "calculates space for the graph key" do
          expect(sizing.series_key_area).to be_renderable

          expect(sizing.series_key_area[:width]).to eq(140)
          expect(sizing.series_key_area[:height]).to eq(444)
          expect(sizing.series_key_area[:x]).to eq(525)
          expect(sizing.series_key_area[:y]).to eq(23)
        end

        it "calculates space for the graph title" do
          expect(sizing.title_area).to be_renderable

          expect(sizing.title_area[:width]).to eq(490)
          expect(sizing.title_area[:height]).to eq(38)
          expect(sizing.title_area[:x]).to eq(35)
          expect(sizing.title_area[:y]).to eq(23)
        end

        it "calculates the size of the graph area within the canvas" do
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(490)
          expect(sizing.graph_area[:height]).to eq(406)
          expect(sizing.graph_area[:x]).to eq(35)
          expect(sizing.graph_area[:y]).to eq(-15)
        end
      end
    end

    describe "when no width is specified for the canvas, but a height is" do
      describe "with one series and no title" do
        let(:attributes){ { series_count: 1, height: 550 } }
        let(:sizing) { Prawn::Graph::Calculations::LayoutCalculator.new(bounds, attributes).calculate }

        it "sizes the canvas to reflect the aspect ratio of the bounding box provided" do
          expect(sizing.canvas_width).to  eq(825)
          expect(sizing.canvas_height).to eq(550)
        end

        it "does not calculate space for the graph key" do
          expect(sizing.series_key_area).to_not be_renderable
        end

        it "does not calculate space for the graph title" do
          expect(sizing.title_area).to_not be_renderable
        end

        it "calculates the size of the graph area within the canvas" do
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(743)
          expect(sizing.graph_area[:height]).to eq(522)
          expect(sizing.graph_area[:x]).to eq(41)
          expect(sizing.graph_area[:y]).to eq(28)
        end
      end

      describe "with one series and a title" do
        let(:attributes){ { series_count: 1, title: 'Bob', height: 550 } }
        let(:sizing) { Prawn::Graph::Calculations::LayoutCalculator.new(bounds, attributes).calculate }

        it "sizes the canvas to reflect the aspect ratio of the bounding box provided" do
          expect(sizing.canvas_width).to  eq(825)
          expect(sizing.canvas_height).to eq(550)
        end

        it "does not calculate space for the graph key" do
          expect(sizing.series_key_area).to_not be_renderable
        end

        it "calculates space for the graph title" do
          expect(sizing.title_area).to be_renderable

          expect(sizing.title_area[:width]).to eq(743)
          expect(sizing.title_area[:height]).to eq(43)
          expect(sizing.title_area[:x]).to eq(41)
          expect(sizing.title_area[:y]).to eq(28)
        end

        it "calculates the size of the graph area within the canvas" do
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(743)
          expect(sizing.graph_area[:height]).to eq(479)
          expect(sizing.graph_area[:x]).to eq(41)
          expect(sizing.graph_area[:y]).to eq(-15)
        end
      end

      describe "with many series and no title" do
        let(:attributes){ { series_count: 3, height: 550 } }
        let(:sizing) { Prawn::Graph::Calculations::LayoutCalculator.new(bounds, attributes).calculate }

        it "sizes the canvas to reflect the aspect ratio of the bounding box provided" do
          expect(sizing.canvas_width).to  eq(825)
          expect(sizing.canvas_height).to eq(550)
        end

        it "calculates space for the graph key" do
          expect(sizing.series_key_area).to be_renderable

          expect(sizing.series_key_area[:width]).to eq(160)
          expect(sizing.series_key_area[:height]).to eq(522)
          expect(sizing.series_key_area[:x]).to eq(624)
          expect(sizing.series_key_area[:y]).to eq(28)
        end

        it "does not calculate space for the graph title" do
          expect(sizing.title_area).to_not be_renderable
        end

        it "calculates the size of the graph area within the canvas" do
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(583)
          expect(sizing.graph_area[:height]).to eq(522)
          expect(sizing.graph_area[:x]).to eq(41)
          expect(sizing.graph_area[:y]).to eq(28)
        end
      end

      describe "with many series and a title" do
        let(:attributes){ { series_count: 3, title: 'Bob', height: 550 } }
        let(:sizing) { Prawn::Graph::Calculations::LayoutCalculator.new(bounds, attributes).calculate }

        it "sizes the canvas to reflect the aspect ratio of the bounding box provided" do
          expect(sizing.canvas_width).to  eq(825)
          expect(sizing.canvas_height).to eq(550)
        end

        it "calculates space for the graph key" do
          expect(sizing.series_key_area).to be_renderable

          expect(sizing.series_key_area[:width]).to eq(160)
          expect(sizing.series_key_area[:height]).to eq(522)
          expect(sizing.series_key_area[:x]).to eq(624)
          expect(sizing.series_key_area[:y]).to eq(28)
        end

        it "calculates space for the graph title" do
          expect(sizing.title_area).to be_renderable

          expect(sizing.title_area[:width]).to eq(583)
          expect(sizing.title_area[:height]).to eq(43)
          expect(sizing.title_area[:x]).to eq(41)
          expect(sizing.title_area[:y]).to eq(28)
        end

        it "calculates the size of the graph area within the canvas" do
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(583)
          expect(sizing.graph_area[:height]).to eq(479)
          expect(sizing.graph_area[:x]).to eq(41)
          expect(sizing.graph_area[:y]).to eq(-15)
        end
      end
    end
  end

end
