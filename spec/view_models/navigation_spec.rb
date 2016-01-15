RSpec.describe Navigation do
  subject(:navigation) { Navigation.new(taxonomy) }

  let(:foo_category) { instance_double(Category, id: double, title: 'Foo category') }
  let(:bar_category) { instance_double(Category, id: double, title: 'Bar category') }

  let(:foo_guide) { instance_double(Guide, content_type: :govspeak, id: 'foo', slug: 'foo', label: 'Foo') }
  let(:bar_guide) { instance_double(Guide, content_type: :govspeak, id: 'bar', slug: 'bar', label: 'Bar') }
  let(:baz_guide) { instance_double(Guide, content_type: :govspeak, id: 'baz', slug: 'baz', label: 'Baz') }
  let(:qux_guide) { instance_double(Guide, content_type: :govspeak, id: 'qux', slug: 'qux', label: 'Qux') }
  let(:norf_guide) { instance_double(Guide, content_type: :govspeak, id: 'norf', slug: 'norf', label: 'Norf') }

  let(:taxonomy) do
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

  describe '#topics' do
    subject(:topics) { navigation.topics }

    it 'maps categories from the taxonomy as navigation topics' do
      topic = topics.first

      expect(topic).to be_a(Navigation::Topic)
      expect(topic.id).to eq(foo_category.id)
      expect(topic.label).to eq(foo_category.title)
    end

    it 'maps guides from the taxonomy as navigation items' do
      topic = topics.first
      items = topic.items.flatten

      expect(items.first).to be_a(Navigation::Item)
      expect(items.first.id).to eq(foo_guide.id)
      expect(items.first.label).to eq(foo_guide.label)
    end

    it 'groups guides within a topic' do
      topic = topics.second
      items = topic.items

      expect(items[0][0].id).to eq(baz_guide.id)
      expect(items[0][0].label).to eq(baz_guide.label)

      expect(items[1][0].id).to eq(qux_guide.id)
      expect(items[1][0].label).to eq(qux_guide.label)
    end

    it 'groups orphaned guides into a more topic' do
      topic = topics.last
      guides = topic.items.flatten

      expect(topic.id).to eq('more')
      expect(topic.label).to eq('More…')

      expect(guides.first.id).to eq(norf_guide.id)
      expect(guides.first.label).to eq(norf_guide.label)
    end
  end
end
