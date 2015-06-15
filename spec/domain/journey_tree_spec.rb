RSpec.describe JourneyTree do
  describe('#instance') do
    subject(:instance) { described_class.instance }

    it { is_expected.to respond_to(:tree) }

    describe '#tree' do
      subject { instance.tree }

      it { is_expected.to be_a(Tree::TreeNode) }

      it 'contains guides' do
        expect(instance.tree.root.content).to be_a(Guide)
      end
    end
  end
end
