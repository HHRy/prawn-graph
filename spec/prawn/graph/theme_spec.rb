require 'spec_helper'

describe Prawn::Graph::Theme do
  describe "the default theme" do
    it "has only ever one instance created" do
      expect(Prawn::Graph::Theme.default).to eq(Prawn::Graph::Theme.default)
    end

    it "is a Prawn::Graph::Theme insance, as expected" do
      expect(Prawn::Graph::Theme.default.is_a?(Prawn::Graph::Theme)).to eq(true)
    end

    it "has the default series colors" do 
      expect(Prawn::Graph::Theme.default.series).to eq(Prawn::Graph::Theme::Default[:series])
    end

    it "has the default series colors" do
      expect(Prawn::Graph::Theme.default.series).to eq(Prawn::Graph::Theme::Default[:series])
    end

    it "has the default title colors" do
      expect(Prawn::Graph::Theme.default.title).to eq(Prawn::Graph::Theme::Default[:title])
    end

    it "has the default background colors" do
      expect(Prawn::Graph::Theme.default.background).to eq(Prawn::Graph::Theme::Default[:background])
    end

    it "has the default axes colors" do
      expect(Prawn::Graph::Theme.default.axes).to eq(Prawn::Graph::Theme::Default[:axes])
    end

    it "has the default markers colors" do
      expect(Prawn::Graph::Theme.default.markers).to eq(Prawn::Graph::Theme::Default[:markers])
    end

    it "has the default default colors" do
      expect(Prawn::Graph::Theme.default.default).to eq(Prawn::Graph::Theme::Default[:default])
    end

    it "has the default average colors" do
      expect(Prawn::Graph::Theme.default.average).to eq(Prawn::Graph::Theme::Default[:average])
    end

    it "has the default max colors" do
      expect(Prawn::Graph::Theme.default.max).to eq(Prawn::Graph::Theme::Default[:max])
    end

    it "has the default min colors" do
      expect(Prawn::Graph::Theme.default.min).to eq(Prawn::Graph::Theme::Default[:min])
    end
  end

  describe "an instance of a theme" do
    let(:subject){ Prawn::Graph::Theme.default }

    it "should know how many series colors it has" do
      expect(subject.number_of_colors).to eq(subject.series.size)
    end

    it "has a method to pick a color for a series" do
      expect(subject.respond_to?(:color_for)).to eq(true)
    end

    it "cycles through available colors correctly when too few are defined" do
      series = []
      (subject.number_of_colors + 1).times { series << Prawn::Graph::Series.new }

      series.each_with_index do |series, i|
        if i < subject.number_of_colors
          expect(subject.color_for(series)).to eq(subject.series[i])
        else
          expect(subject.color_for(series)).to eq(subject.series[i - subject.number_of_colors])
        end
      end
    end
  end
end