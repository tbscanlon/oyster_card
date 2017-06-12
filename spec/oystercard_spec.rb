require 'oystercard'
describe OysterCard do

  describe '#initialize' do
    it 'expects to initialize with a balance of 0' do
      expect(subject.balance).to eq(0)
    end

    it 'expects to initialize with a status of not_in_use' do
      expect(subject.status).to eq(:not_in_use)
    end
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'increases the balance' do
      subject.top_up(50)
      expect(subject.balance).to eq 50
    end

    it 'won\'t top up beyond maximum limit' do
      subject.top_up(1)
      expect { subject.top_up(OysterCard::MAXIMUM_BALANCE) }.to raise_error("Can't top up beyond 90 pounds")
    end
  end

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    context "When the card has enough money on it" do
      let(:card) { described_class.new(50) }

      it 'decreases the balance' do
        expect(card.deduct(10)).to eq 40
      end
    end
  end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?) }

    it "returns false when the card is not in use" do
      expect(subject).to_not be_in_journey
    end
  end

  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in) }

    it "changes the status to :in_use" do
      subject.touch_in
      expect(subject.status).to eq :in_use
    end
  end

  describe '#touch_out' do
    let(:card) { described_class.new(10, :in_use) }
    it { is_expected.to respond_to(:touch_out) }

    it "changes the status to :not_in_use" do
      card.touch_out
      expect(card.status).to eq :not_in_use 
    end
  end
end
