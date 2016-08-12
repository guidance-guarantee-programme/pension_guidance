RSpec.describe Guide, type: :model do
  let(:id) { 'the_test_guide' }
  let(:content_type) { :govspeak }
  let(:content) { '/examples/test.md' }
  let(:label) { 'Tested' }
  let(:concise_label) { 'Test' }
  let(:description) { 'A test description' }
  let(:tags) { [] }

  let(:metadata) do
    Guide::Metadata.new(label: label,
                        concise_label: concise_label,
                        description: description,
                        tags: tags)
  end

  subject(:guide) do
    described_class.new(id, content: content, content_type: content_type, metadata: metadata)
  end

  %i(id content content_type label concise_label description tags).each do |attr|
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

  describe '#related_to_appointments?' do
    context 'when tagged with "appointments"' do
      let(:tags) { %w(appointments) }

      it { is_expected.to be_related_to_appointments }
    end
  end

  describe '#related_to_booking?' do
    context 'when tagged with "booking"' do
      let(:tags) { %w(booking) }

      it { is_expected.to be_related_to_booking }
    end
  end

  describe '#option?' do
    context 'when tagged with "option"' do
      let(:tags) { %w(option) }

      it { is_expected.to be_option }
    end
  end
end
