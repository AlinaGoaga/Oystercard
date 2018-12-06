require 'journey'
require 'station'

RSpec.describe Journey do
  let(:entry_station) { double :station, name: 'Aldgate East', zone: 1 }
  let(:exit_station) { double :station, name: 'Liverpool Street', zone: 1 }

  context 'given an entry station' do
    it 'returns a penalty fare if no exit station given' do
      subject.start(entry_station)
      subject.finish
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    it 'completes a journey if exit with no station given' do
      subject.finish
      expect(subject).to be_complete
    end
  end

  context 'given an exit station' do
    it 'returns a penalty fare if no entry station given' do
      subject.finish(exit_station)
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end

  it 'knows if a journey is not complete' do
    expect(subject).not_to be_complete
  end

  it 'returns itself when exiting a journey' do
    expect(subject.finish(exit_station)).to eq(subject)
  end

  it 'has a penalty fare by default' do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end
end
