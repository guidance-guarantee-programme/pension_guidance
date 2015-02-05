RSpec.describe Guide, type: :model do
  let(:id) { 'the_test_guide' }
  let(:source_type) { :govspeak }
  let(:source) { '/examples/test.md' }
  let(:guide) { Guide.new(id, source, source_type) }

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

  describe '#source_type' do
    it 'returns the initialised source_type' do
      expect(guide.source_type).to eq(source_type)
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
