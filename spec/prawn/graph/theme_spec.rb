require 'spec_helper'

describe Prawn::Graph::Theme do

  context "when being initialized without parameters" do
    let(:subject){ Prawn::Graph::Theme.new }

    it "defaults to the standard array of series values" do
      expect(subject.series).to eq(Prawn::Graph::Theme::DEFAULT_SERIES_COLORS)
    end

    it "defaults to the standard max color" do
      expect(subject.max).to eq(Prawn::Graph::Theme::DEFAULT_MAX_COLOR)
    end

    it "defaults to the standard min color" do
      expect(subject.min).to eq(Prawn::Graph::Theme::DEFAULT_MIN_COLOR)
    end

    it "defaults to the standard title color" do
      expect(subject.title).to eq(Prawn::Graph::Theme::DEFAULT_TITLE_COLOR)
    end

    it "defaults to the standard text color" do
      expect(subject.text).to eq(Prawn::Graph::Theme::DEFAULT_TEXT_COLOR)
    end

    it "defaults to the standard background color" do
      expect(subject.background).to eq(Prawn::Graph::Theme::DEFAULT_BACKGROUND_COLOR)
    end

    it "defaults to the standard grid color" do
      expect(subject.grid).to eq(Prawn::Graph::Theme::DEFAULT_GRID_COLOR)
    end

    it "defaults to the standard axes color" do
      expect(subject.axes).to eq(Prawn::Graph::Theme::DEFAULT_AXES_COLOR)
    end

    it "defaults to the standard maker stroke color" do
      expect(subject.markers).to eq(Prawn::Graph::Theme::DEFAULT_MARKERS_STROKE_COLOR)
    end

    it "default to the standard value for stroke_grid_lines" do
      expect(subject.stroke_grid_lines).to eq(Prawn::Graph::Theme::DEFAULT_STROKE_GRID_LINES)
      expect(subject.stroke_grid_lines?).to eq(Prawn::Graph::Theme::DEFAULT_STROKE_GRID_LINES)
    end

    it "has the default font sizes" do
      expect(subject.font_sizes.default).to eq(8)
      expect(subject.font_sizes.main_title).to eq(10)
      expect(subject.font_sizes.axis_labels).to eq(5)
      expect(subject.font_sizes.series_key).to eq(8)
    end
  end

  context "when stroking the average of a series" do
    it "uses the same colour as the selected color for the series" do
      t = Prawn::Graph::Theme.new
      c = t.next_series_color

      expect(t.average).to eq(c)
    end
  end

  context "when going through series colors" do
    it 'exposes a method to get the next series color' do
      expect(Prawn::Graph::Theme.new.respond_to?(:next_series_color)).to eq(true)  
    end

    it 'it returns the expected colors in order' do
      t = Prawn::Graph::Theme.new
      series = t.series

      series.each do |s|
        expect(t.next_series_color).to eq(s)
      end

    end

    it 'loops back from the start when we go back to the start' do
      t = Prawn::Graph::Theme.new

      # Loop the expected number of times to get to the last color
      #
      t.series.size.times { t.next_series_color }

      # Get the first color
      #
      expect(t.next_series_color).to eq(t.series[0])
      expect(t.next_series_color).to eq(t.series[1])
    end
  end

end