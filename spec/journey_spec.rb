require 'journey'

describe Journey do
  let(:journey) { described_class.new }

  let(:aldgate) do
    aldgate = double("Aldgate")
    allow(aldgate).to receive(:name) { "Aldgate" }
    allow(aldgate).to receive(:zone) { 1 }
    aldgate
  end

  let(:waterloo) do
    waterloo = double("Waterloo")
    allow(waterloo).to receive(:name) { "Waterloo" }
    allow(waterloo).to receive(:zone) { 1 }
    waterloo
  end

  describe 'Initialization' do
    it 'doesn\'t have an end when initialized' do
      expect(journey.exit_station).to be_nil
    end
  end

  describe '#record_start' do
    it "records where the journey starts" do
      journey.record_start(aldgate)
      expect(journey.entry_station).to eq aldgate.name
    end
  end

  describe '#record_end' do
    it "records where the journey finishes" do
      journey.record_end(waterloo)
      expect(journey.exit_station).to eq waterloo.name
    end
  end

  describe '#travelling?' do
  it 'returns true when customer is travelling' do
    journey.record_start(aldgate)
    expect(journey.travelling?).to be true
  end

  it 'returns false when the customer isn\'t travelling' do
    journey.record_end(waterloo)
    expect(journey.travelling?).to be false
  end
end

  describe '#view_journey' do
    it "returns the details of the journey" do
      journey.record_start(aldgate)
      journey.record_end(waterloo)
      expect(journey.view_journey).to eq "Start: #{aldgate.name}\n Destination: #{waterloo.name}"
    end
  end
end
