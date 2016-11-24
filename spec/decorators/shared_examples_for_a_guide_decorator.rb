RSpec.shared_examples 'a guide decorator' do
  describe 'delegates' do
    let(:id) { 'foo' }
    let(:slug) { '/foo' }
    let(:description) { 'The test description' }

    let(:metadata) { double(description: description) }
    let(:decorator) { described_class.new(instance_spy(Guide, id: id, slug: slug, metadata: metadata)) }

    describe '#id' do
      subject { decorator.id }

      it { is_expected.to eq(id) }
    end

    describe '#slug' do
      subject { decorator.slug }

      it { is_expected.to eq(slug) }
    end

    describe '#description' do
      subject { decorator.description }

      it { is_expected.to eq(description) }
    end
  end
end
