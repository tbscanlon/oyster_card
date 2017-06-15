require 'oystercard'

describe Oystercard do
  let(:card)          { described_class.new(min_fare) }
  let(:max_limit)     { described_class::MAX_LIMIT }
  let(:min_fare)      { described_class::MIN_FARE }

  let(:aldgate) do
    aldgate = double("Aldgate")
    allow(aldgate).to receive(:name) { "Aldgate" }
    allow(aldgate).to receive(:zone) { 1 }
    aldgate
  end

  let(:waterloo) do
    waterloo = double("Waterloo")
    allow(waterloo).to receive(:name) { "Waterloo" }
    allow(waterloo).to receive(:zone) { 2 }
    waterloo
  end

  let(:journey) do
    journey = double("journey")
    allow(journey).to receive(:aldgate) {  }
  end

  describe 'oystercard creation' do
    it 'isn\'t in use when initialized' do
      expect(card.journey).to eq nil
    end

    describe '#journey_history' do
      it 'is an array' do
        expect(card.journey_history).to be_a Array
      end

      it 'starts off empty' do
        expect(card.journey_history).to be_empty
      end
    end
  end

  describe '#top_up' do
    context 'Adding money to the card' do
      it 'adds money to the oystercard balance' do
        expect { card.top_up 10 }.to change { card.balance }.by 10
      end

      it 'doesn\'t allow to top up beyond the limit' do
        expect { card.top_up(max_limit) }.to raise_error("Exceeded #{max_limit} limit")
      end
    end
  end

  describe '#touch_in' do
    context "Touching in at a station" do
      let(:empty_card) { described_class.new }

      it 'raises an error if the balance is less than £1' do
        expect { empty_card.touch_in(aldgate) }.to raise_error("Please top up at least £#{min_fare}")
      end

      it 'records the start of the journey' do
        card.touch_in(aldgate)
        expect(card.journey.entry_station).to eq aldgate.name
      end
    end
  end

  describe '#touch_out' do
    context "When touching out" do
      before do
        card.touch_in(aldgate)
        card.touch_out(waterloo)
      end

      it 'records the exit station' do
        expect(card.journey.exit_station).to eq waterloo.name
      end

      it 'deducts correct amount when journey\'s complete' do
        expect(card.balance).to eq 0
      end
    end
  end

  describe '#previous_journeys' do
    context 'After a complete journey' do
      before do
        card.touch_in(aldgate)
        card.touch_out(waterloo)
      end

      it 'shows journey history' do
        expect { card.previous_journeys }.to output("Start: #{aldgate.name}\n Destination: #{waterloo.name}\n").to_stdout
      end
    end
  end
end
