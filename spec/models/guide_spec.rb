RSpec.describe Guide, type: :model do
  let(:id) { 'the_test_guide' }
  let(:content_type) { :govspeak }
  let(:content) { '/examples/test.md' }
  let(:description) { 'A test description' }
  let(:guide) { Guide.new(id, content: content, content_type: content_type, description: description) }

  describe '#id' do
    it 'returns the initialised id' do
      expect(guide.id).to eq(id)
    end
  end

  describe '#content' do
    it 'returns the initialised content' do
      expect(guide.content).to eq(content)
    end
  end

  describe '#content_type' do
    it 'returns the initialised content_type' do
      expect(guide.content_type).to eq(content_type)
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
