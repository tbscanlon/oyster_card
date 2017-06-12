require "oystercard"

describe OysterCard do

  it "expects to initialize with a balance of 0" do
    expect(subject.balance).to eq(0)
  end

end
