RSpec.describe Entity, type: :model do
  subject { described_class.new(double, attributes) }

  let(:attributes) { Hash.new }

  it { is_expected.to have_read_only_attributes(:id) }

  it 'validates presence of id' do
    subject = described_class.new(nil, attributes)
    subject.validate
    expect(subject.errors[:id]).to_not be_empty
  end

  context 'when passed unexpected data' do
    let(:attributes) { { foo: :bar } }

    it 'should not raise an exception' do
      expect { subject }.not_to raise_exception
    end
  end

  describe '#==' do
    let(:entity) { described_class.new('foo') }
    subject { entity == other_entity }

    context 'when the other entity is another class' do
      let(:other_entity) { OpenStruct.new(id: 'foo') }

      it { is_expected.to be_falsey }
    end

    context 'when the other entity is the same class' do
      context 'when the other entity has the same id' do
        let(:other_entity) { Entity.new('foo') }

        it { is_expected.to be_truthy }
      end

      context 'when the other entity has a different id' do
        let(:other_entity) { Entity.new('bar') }

        it { is_expected.to be_falsey }
      end
    end
  end
end
