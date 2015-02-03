RSpec.describe Guide, type: :model do
  let(:id) { 'the_test_guide' }
  let(:source) { '# This is a test guide' }
  let(:description) { 'A guide used for testing' }

  subject(:guide) { Guide.new(id, source, description) }

  describe '#id' do
    it 'returns the initialised id' do
      expect(guide.id).to eq(id)
    end
  end

  describe '#source' do
    it 'returns the initialised source' do
      expect(guide.source).to eq(source)
    end
  end

  describe '#description' do
    it 'returns the initialised description' do
      expect(guide.description).to eq(description)
    end
  end

  describe '#slug' do
    it 'returns a slug based on the id' do
      expect(guide.slug).to eq('the-test-guide')
    end
  end

  describe '#==' do
    it 'considers two guides with the same ID as equal' do
      expect(described_class.new('foo')).to eq(described_class.new('foo'))
    end
  end
end
