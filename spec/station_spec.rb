require 'station'

describe Station do
  let (:station_name) { "Aldgate" }
  let (:station_zone) { 1 }
  let (:station)      { described_class.new(name: station_name, zone: station_zone) }

  describe 'Initialization' do
    it 'is a Station' do
      expect(station).to be_a Station
    end
  end

  describe 'Attributes' do
    it 'has a name' do
      expect(station.name).to eq station_name
    end

    it 'has a zone' do
      expect(station.zone).to eq station_zone
    end
  end
end
