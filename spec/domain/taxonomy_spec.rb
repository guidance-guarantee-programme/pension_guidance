RSpec.describe Taxonomy do
  describe('#instance') do
    subject(:instance) { described_class.instance }

    it { is_expected.to respond_to(:tree) }

    describe '#tree' do
      subject(:tree) { instance.tree }

      it { is_expected.to be_a(Tree::TreeNode) }

      it 'contains categories and guides' do
        expect(tree.root.name).to eq('home')
        expect(tree.root.first_child.content).to be_a(Category)
        expect(tree.root.first_child.first_child.content).to be_a(Guide)
      end
    end
  end
end
