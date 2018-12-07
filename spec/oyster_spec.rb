require 'oyster'
# require 'journey'

RSpec.describe Oystercard do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { double :journey }
  subject(:card) { Oystercard.new(journey) }

  it 'should return a balance of 0 when initialized' do
    expect(card.balance).to eq 0
  end

  it 'has an empty list of journeys by default' do
    expect(card.journeys).to be_empty
  end

  describe '#top_up' do
    it 'should top up the card by the amount given' do
      expect(card.top_up(5)).to eq 5
    end

    it 'should raise an error if user tries to top up beyond maximum limit' do
      expect { card.top_up(::MAX_BALANCE + 1) }.to raise_error { 'Maximum balance exceeded' }
    end
  end

  describe '#touch_in' do
    it 'should not let user touch in without sufficient balance' do
      expect { card.touch_in }.to raise_error 'Insufficient balance. GET RICH BRO!'
    end
  end

  describe '#touch_out' do
    it 'should return the completed journey' do
      allow(journey).to receive(:start).and_return(entry_station)
      allow(journey).to receive(:finish).and_return(journey)
      card.top_up(20)
      card.touch_in(entry_station)
      expect(card.touch_out(exit_station)).to eq journey
    end
  end

  it 'saves the journey in the list of journeys' do
    card.save_journey
    expect(card.journeys).to include(journey)
  end
end
