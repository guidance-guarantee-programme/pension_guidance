RSpec.describe Journey, type: :model do
  it { is_expected.to respond_to(:steps) }
  it { is_expected.to_not respond_to(:steps=) }

  describe '#each' do
    let(:step_one) { double }
    let(:step_two) { double }

    it 'yields each step of the journey' do
      expect { |b| Journey.new(step_one, step_two).each(&b) }.to yield_successive_args(step_one, step_two)
    end
  end
end
