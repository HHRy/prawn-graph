require 'spec_helper'

describe Prawn::Graph::Calculations::LayoutCalculator do
  let(:bounds) { [1200, 800] }
  let(:attributes){ { series_count: 1, title: 'Bob' } }
  let(:sizing) { Prawn::Graph::Calculations::LayoutCalculator.new(bounds, attributes) }

  describe "instances of a Dimensions class" do
    it "has a point method with represents the x and y coords calculated" do
      expect(sizing.graph_area.point).to eq([sizing.graph_area.x, sizing.graph_area.y])
    end
  end

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

          expect(sizing.graph_area[:width]).to eq(1152)
          expect(sizing.graph_area[:height]).to eq(784)
          expect(sizing.graph_area[:x]).to eq(24)
          expect(sizing.graph_area[:y]).to eq(816)
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

          expect(sizing.title_area[:width]).to eq(1152)
          expect(sizing.title_area[:height]).to eq(26)
          expect(sizing.title_area[:x]).to eq(24)
          expect(sizing.title_area[:y]).to eq(816)
        end

        it "calculates the size of the graph area within the canvas" do
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(1152)
          expect(sizing.graph_area[:height]).to eq(758)
          expect(sizing.graph_area[:x]).to eq(24)
          expect(sizing.graph_area[:y]).to eq(790)
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

          expect(sizing.series_key_area[:width]).to eq(300)
          expect(sizing.series_key_area[:height]).to eq(784)
          expect(sizing.series_key_area[:x]).to eq(876)
          expect(sizing.series_key_area[:y]).to eq(816)
        end

        it "does not calculate space for the graph title" do
          expect(sizing.title_area).to_not be_renderable
        end

        it "calculates the size of the graph area within the canvas" do
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(852)
          expect(sizing.graph_area[:height]).to eq(784)
          expect(sizing.graph_area[:x]).to eq(24)
          expect(sizing.graph_area[:y]).to eq(816)
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

          expect(sizing.series_key_area[:width]).to eq(300)
          expect(sizing.series_key_area[:height]).to eq(784)
          expect(sizing.series_key_area[:x]).to eq(876)
          expect(sizing.series_key_area[:y]).to eq(816)
        end

        it "calculates space for the graph title" do
          expect(sizing.title_area).to be_renderable

          expect(sizing.title_area[:width]).to eq(852)
          expect(sizing.title_area[:height]).to eq(26)
          expect(sizing.title_area[:x]).to eq(24)
          expect(sizing.title_area[:y]).to eq(816)
        end

        it "calculates the size of the graph area within the canvas" do
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(852)
          expect(sizing.graph_area[:height]).to eq(758)
          expect(sizing.graph_area[:x]).to eq(24)
          expect(sizing.graph_area[:y]).to eq(790)
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

          expect(sizing.graph_area[:width]).to eq(576)
          expect(sizing.graph_area[:height]).to eq(196)
          expect(sizing.graph_area[:x]).to eq(12)
          expect(sizing.graph_area[:y]).to eq(204)

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

          expect(sizing.series_key_area[:width]).to eq(150)
          expect(sizing.series_key_area[:height]).to eq(196)
          expect(sizing.series_key_area[:x]).to eq(438)
          expect(sizing.series_key_area[:y]).to eq(204)
        end

        it "does not calculate space for the graph title" do
          expect(sizing.title_area).to_not be_renderable
        end

        it "calculates the size of the graph area within the canvas" do
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(426)
          expect(sizing.graph_area[:height]).to eq(196)
          expect(sizing.graph_area[:x]).to eq(12)
          expect(sizing.graph_area[:y]).to eq(204)
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

          expect(sizing.title_area[:width]).to eq(576)
          expect(sizing.title_area[:height]).to eq(14)
          expect(sizing.title_area[:x]).to eq(12)
          expect(sizing.title_area[:y]).to eq(204)
        end

        it "calculates the size of the graph area within the canvas" do
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(576)
          expect(sizing.graph_area[:height]).to eq(182)
          expect(sizing.graph_area[:x]).to eq(12)
          expect(sizing.graph_area[:y]).to eq(190)

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

          expect(sizing.series_key_area[:width]).to eq(150)
          expect(sizing.series_key_area[:height]).to eq(196)
          expect(sizing.series_key_area[:x]).to eq(438)
          expect(sizing.series_key_area[:y]).to eq(204)
        end

        it "calculates space for the graph title" do
          expect(sizing.title_area).to be_renderable

          expect(sizing.title_area[:width]).to eq(426)
          expect(sizing.title_area[:height]).to eq(14)
          expect(sizing.title_area[:x]).to eq(12)
          expect(sizing.title_area[:y]).to eq(204)
        end

        it "calculates the size of the graph area within the canvas" do
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(426)
          expect(sizing.graph_area[:height]).to eq(182)
          expect(sizing.graph_area[:x]).to eq(12)
          expect(sizing.graph_area[:y]).to eq(190)

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

          expect(sizing.graph_area[:width]).to eq(672)
          expect(sizing.graph_area[:height]).to eq(458)
          expect(sizing.graph_area[:x]).to eq(14)
          expect(sizing.graph_area[:y]).to eq(476)
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

          expect(sizing.title_area[:width]).to eq(672)
          expect(sizing.title_area[:height]).to eq(19)
          expect(sizing.title_area[:x]).to eq(14)
          expect(sizing.title_area[:y]).to eq(476)
        end

        it "calculates the size of the graph area within the canvas" do
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(672)
          expect(sizing.graph_area[:height]).to eq(439)
          expect(sizing.graph_area[:x]).to eq(14)
          expect(sizing.graph_area[:y]).to eq(457)
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

          expect(sizing.series_key_area[:width]).to eq(175)
          expect(sizing.series_key_area[:height]).to eq(458)
          expect(sizing.series_key_area[:x]).to eq(511)
          expect(sizing.series_key_area[:y]).to eq(476)
        end

        it "does not calculate space for the graph title" do
          expect(sizing.title_area).to_not be_renderable
        end

        it "calculates the size of the graph area within the canvas" do
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(497)
          expect(sizing.graph_area[:height]).to eq(458)
          expect(sizing.graph_area[:x]).to eq(14)
          expect(sizing.graph_area[:y]).to eq(476)
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

          expect(sizing.series_key_area[:width]).to eq(175)
          expect(sizing.series_key_area[:height]).to eq(458)
          expect(sizing.series_key_area[:x]).to eq(511)
          expect(sizing.series_key_area[:y]).to eq(476)
        end

        it "calculates space for the graph title" do
          expect(sizing.title_area).to be_renderable

          expect(sizing.title_area[:width]).to eq(497)
          expect(sizing.title_area[:height]).to eq(19)
          expect(sizing.title_area[:x]).to eq(14)
          expect(sizing.title_area[:y]).to eq(476)
        end

        it "calculates the size of the graph area within the canvas" do
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(497)
          expect(sizing.graph_area[:height]).to eq(439)
          expect(sizing.graph_area[:x]).to eq(14)
          expect(sizing.graph_area[:y]).to eq(457)
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

          expect(sizing.graph_area[:width]).to eq(791)
          expect(sizing.graph_area[:height]).to eq(539)
          expect(sizing.graph_area[:x]).to eq(17)
          expect(sizing.graph_area[:y]).to eq(561)
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

          expect(sizing.title_area[:width]).to eq(791)
          expect(sizing.title_area[:height]).to eq(21)
          expect(sizing.title_area[:x]).to eq(17)
          expect(sizing.title_area[:y]).to eq(561)
        end

        it "calculates the size of the graph area within the canvas" do
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(791)
          expect(sizing.graph_area[:height]).to eq(518)
          expect(sizing.graph_area[:x]).to eq(17)
          expect(sizing.graph_area[:y]).to eq(540)
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

          expect(sizing.series_key_area[:width]).to eq(200)
          expect(sizing.series_key_area[:height]).to eq(539)
          expect(sizing.series_key_area[:x]).to eq(608)
          expect(sizing.series_key_area[:y]).to eq(561)
        end

        it "does not calculate space for the graph title" do
          expect(sizing.title_area).to_not be_renderable
        end

        it "calculates the size of the graph area within the canvas" do
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(591)
          expect(sizing.graph_area[:height]).to eq(539)
          expect(sizing.graph_area[:x]).to eq(17)
          expect(sizing.graph_area[:y]).to eq(561)
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

          expect(sizing.series_key_area[:width]).to eq(200)
          expect(sizing.series_key_area[:height]).to eq(539)
          expect(sizing.series_key_area[:x]).to eq(608)
          expect(sizing.series_key_area[:y]).to eq(561)
        end

        it "calculates space for the graph title" do
          expect(sizing.title_area).to be_renderable

          expect(sizing.title_area[:width]).to eq(591)
          expect(sizing.title_area[:height]).to eq(21)
          expect(sizing.title_area[:x]).to eq(17)
          expect(sizing.title_area[:y]).to eq(561)
        end

        it "calculates the size of the graph area within the canvas" do
          expect(sizing.graph_area).to be_renderable

          expect(sizing.graph_area[:width]).to eq(591)
          expect(sizing.graph_area[:height]).to eq(518)
          expect(sizing.graph_area[:x]).to eq(17)
          expect(sizing.graph_area[:y]).to eq(540)
        end
      end
    end
  end

end
