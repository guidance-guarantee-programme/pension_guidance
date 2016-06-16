require 'spec_helper'

RSpec.describe BookingLocations::Location do
  let(:data) do
    {
      'uid' => '9d7c72fc-0c74-4418-8099-e1a4e704cb01',
      'name' => 'Somewhere CAB',
      'address' => '10 Some Place',
      'locations' => [
        {
          'uid' => '9d7c72fc-0c74-4418-8099-e1a4e704cb01',
          'name' => 'Child CAB',
          'address' => '10 Child Address'
        }
      ],
      'guiders' => [
        {
          'id' => 1,
          'name' => 'Rick Sanchez',
          'email' => 'rick@example.com'
        }
      ],
      'slots' => [
        {
          'date' => '2016-06-20',
          'start' => '0900',
          'end' => '1300'
        }
      ]
    }
  end

  subject { described_class.new(data) }

  it 'has an ID' do
    expect(subject.id).to eq('9d7c72fc-0c74-4418-8099-e1a4e704cb01')
  end

  it 'has a name' do
    expect(subject.name).to eq('Somewhere CAB')
  end

  it 'has an address' do
    expect(subject.address).to eq('10 Some Place')
  end

  it 'has nested locations' do
    expect(subject.locations.first.id).to eq('9d7c72fc-0c74-4418-8099-e1a4e704cb01')
    expect(subject.locations.first.name).to eq('Child CAB')
    expect(subject.locations.first.address).to eq('10 Child Address')
  end

  it 'has guiders' do
    expect(subject.guiders.first.id).to eq(1)
    expect(subject.guiders.first.name).to eq('Rick Sanchez')
    expect(subject.guiders.first.email).to eq('rick@example.com')
  end

  it 'has slots' do
    expect(subject.slots.first.date).to eq('2016-06-20')
    expect(subject.slots.first.start).to eq('0900')
    expect(subject.slots.first.end).to eq('1300')
  end
end
