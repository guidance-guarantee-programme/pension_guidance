RSpec.describe Category, type: :model do
  let(:category) { described_class.new(id, title: title) }

  let(:id) { 'the_test_category' }
  let(:title) { 'Testing' }

  %i( id title ).each do |attr|
    describe "##{attr}" do
      it "returns the initialised #{attr}" do
        expect(category.public_send(attr)).to eq(public_send(attr))
      end
    end
  end

  describe '#==' do
    it 'considers two categories with the same ID as equal' do
      expect(described_class.new('foo')).to eq(described_class.new('foo'))
    end
  end
end
