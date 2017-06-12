require "oystercard"

describe OysterCard do

  it "expects to initialize with a balance of 0" do
    expect(subject.balance).to eq(0)
  end

  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it "tops up the balance" do
      subject.top_up(50)
      expect(subject.balance).to eq 50
    end
  end

end
