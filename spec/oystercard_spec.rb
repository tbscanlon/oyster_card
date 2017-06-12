require 'oystercard'
describe OysterCard do
  it 'expects to initialize with a balance of 0' do
    expect(subject.balance).to eq(0)
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
end
