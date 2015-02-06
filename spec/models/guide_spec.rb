RSpec.describe Guide, type: :model do
  let(:id) { 'the_test_guide' }
  let(:content_type) { :govspeak }
  let(:content) { '/examples/test.md' }
  let(:label) { 'Tested' }
  let(:description) { 'A test description' }
  let(:guide) { Guide.new(id, content: content, content_type: content_type, label: label, description: description) }

  %i( id content content_type label description ).each do |attr|
    describe "##{attr}" do
      it "returns the initialised #{attr}" do
        expect(guide.public_send(attr)).to eq(public_send(attr))
      end
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
