RSpec.describe Journey, type: :model do
  let(:step_one) { double }
  let(:step_two) { double }

  subject(:journey) { Journey.new(step_one, step_two) }

  describe '#each' do
    it 'yields each step of the journey' do
      expect { |b| journey.each(&b) }.to yield_successive_args(step_one, step_two)
    end
  end

  describe '#count' do
    it 'has two steps' do
      expect(journey.count).to eq(2)
    end
  end
end
