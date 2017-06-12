require 'oystercard'
describe OysterCard do
  it 'expects to initialize with a balance of 0' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'tops up the balance' do
      subject.top_up(50)
      expect(subject.balance).to eq 50
    end

    it 'won\'t top up beyond maximum limit' do
      subject.top_up(1)
      expect { subject.top_up(OysterCard::MAXIMUM_BALANCE) }.to raise_error("Can't top up beyond 90 pounds")
    end
  end
  # describe "#above_limit?" do
  #   it { is_expected.to respond_to(:above_limit?)}
  #
  #   it "returns false if the card is below the limit" do
  #     expect(subject).to_not be_above_limit
  #   end
  #
  #   it "returns true if the card is above the limit" do
  #     card = OysterCard.new(100)
  #     expect(card).to be_above_limit
  #   end
  # end
end
