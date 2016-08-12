RSpec.describe Category, type: :model do
  let(:category) { described_class.new(id, title: title, description: description) }

  let(:id) { 'the_test_category' }
  let(:title) { 'Testing' }
  let(:description) { 'A test category.' }

  %i(id title description).each do |attr|
    describe "##{attr}" do
      it "returns the initialised #{attr}" do
        expect(category.public_send(attr)).to eq(public_send(attr))
      end
    end
  end

  describe '#slug' do
    it 'returns a slug based on the id' do
      expect(category.slug).to eq('the-test-category')
    end
  end

  describe '#==' do
    it 'considers two categories with the same ID as equal' do
      expect(described_class.new('foo')).to eq(described_class.new('foo'))
    end
  end
end
