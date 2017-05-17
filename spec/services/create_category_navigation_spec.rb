RSpec.describe CreateCategoryNavigation do
  let(:locale) { :en }
  subject(:service) { described_class.new(category_id, category_tree, locale) }

  let(:foo_category) { instance_double(Category, id: double, title: 'Foo category') }
  let(:bar_category) { instance_double(Category, id: double, title: 'Bar category') }

  let(:foo_guide) { instance_double(Guide, content_type: :govspeak, id: 'foo', slug: 'foo') }
  let(:bar_guide) { instance_double(Guide, content_type: :govspeak, id: 'bar', slug: 'bar') }
  let(:baz_guide) { instance_double(Guide, content_type: :govspeak, id: 'baz', slug: 'baz') }
  let(:qux_guide) { instance_double(Guide, content_type: :govspeak, id: 'qux', slug: 'qux') }
  let(:norf_guide) { instance_double(Guide, content_type: :govspeak, id: 'norf', slug: 'norf') }

  let(:category_id) { 'foo' }

  let(:category_tree) do
    Tree::TreeNode.new('home').tap do |root|
      root << Tree::TreeNode.new('foo', foo_category).tap do |category|
        category << Tree::TreeNode.new('foo', foo_guide)
      end

      root << Tree::TreeNode.new('bar', bar_category).tap do |category|
        category << Tree::TreeNode.new('bar', bar_guide).tap do |guide|
          guide << Tree::TreeNode.new('baz', baz_guide)
        end

        category << Tree::TreeNode.new('qux', qux_guide)
      end

      root << Tree::TreeNode.new('norf', norf_guide)
    end
  end

  before do
    allow_any_instance_of(CategoryRepository).to receive(:find).with(category_id) { foo_category }
  end

  describe '#call' do
    subject(:call) { service.call }

    it 'returns a category navigation object' do
      is_expected.to be_a(CategoryNavigation)
    end

    it 'finds the category in the tree' do
      expect(call.category).to eq(foo_category)
    end

    it 'finds the guides for that category in the tree' do
      expect(call.guides).to contain_exactly(foo_guide)
    end

    context 'when the category contains nested guides' do
      let(:category_id) { 'bar' }

      it 'returns a collection of guides' do
        expect(call.guides).to contain_exactly([bar_guide, baz_guide], qux_guide)
      end
    end

    context 'the more category' do
      let(:category_id) { 'more' }

      it 'returns orphaned guides' do
        expect(call.guides).to contain_exactly(norf_guide)
      end
    end
  end
end
