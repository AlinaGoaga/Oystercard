require 'oyster'

RSpec.describe Oystercard do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { { entry_station: entry_station, exit_station: exit_station } }

  it 'should return a balance of 0 when initialized' do
    expect(subject.balance).to eq 0
  end

  it 'has an empty list of journeys by default' do
    expect(subject.journeys).to be_empty
  end

  describe '#top_up' do
    it 'should top up the card by the amount given' do
      expect(subject.top_up(5)).to eq 5
    end

    it 'should raise an error if user tries to top up beyond maximum limit' do
      expect { subject.top_up(::MAX_BALANCE + 1) }.to raise_error { 'Maximum balance exceeded' }
    end
  end

  describe '#touch_in' do
    it 'should add the entry station to the journey' do
      subject.top_up(20)
      subject.touch_in(entry_station)
      journeys = subject.journeys
      expect(journeys[:entry_station]).to eq(entry_station)
    end

    it 'should not let user touch in without sufficient balance' do
      expect { subject.touch_in }.to raise_error 'Insufficient balance. GET RICH BRO!'
    end

    it 'should raise error if user tries to touch in twice' do
      subject.top_up(20)
      subject.touch_in
      expect { subject.touch_in }.to raise_error 'User already in journey'
    end
  end

  describe '#touch_out' do
    it 'should add the exit station to the journey' do
      subject.top_up(20)
      subject.touch_in
      subject.touch_out(exit_station)
      journeys = subject.journeys
      expect(journeys[:exit_station]).to eq(exit_station)
    end

    it 'should reduce the balance by the minimum fare' do
      subject.top_up(20)
      subject.touch_in
      expect { subject.touch_out }.to change { subject.balance }.by(-Oystercard::MIN_FARE)
    end
  end

  it 'registers a completed journey' do
    subject.top_up(20)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journeys).to include(journey)
  end
end
