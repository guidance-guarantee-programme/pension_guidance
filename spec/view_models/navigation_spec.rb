RSpec.describe Navigation do
  let(:locale) { :en }
  subject(:navigation) { Navigation.new(taxonomy, locale) }

  let(:foo_category) { instance_double(Category, id: double, slug: double, title: 'Foo category') }
  let(:bar_category) { instance_double(Category, id: double, slug: double, title: 'Bar category') }

  let(:foo_guide) { guide_for('foo', locale) }
  let(:bar_guide) { guide_for('bar', locale) }
  let(:baz_guide) { guide_for('baz', locale) }
  let(:qux_guide) { guide_for('qux', locale) }
  let(:norf_guide) { guide_for('norf', locale) }

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
      expect(items.first.label).to eq(foo_guide.metadata.label)
    end

    it 'groups guides within a topic' do
      topic = topics.second
      items = topic.items

      expect(items[0][0].id).to eq(bar_guide.id)
      expect(items[0][0].label).to eq(bar_guide.metadata.label)

      expect(items[0][1].id).to eq(baz_guide.id)
      expect(items[0][1].label).to eq(baz_guide.metadata.label)

      expect(items[1][0].id).to eq(qux_guide.id)
      expect(items[1][0].label).to eq(qux_guide.metadata.label)
    end

    it 'groups orphaned guides into a more topic' do
      topic = topics.last
      guides = topic.items.flatten

      expect(topic.id).to eq('more')
      expect(topic.label).to eq('Further guidance…')

      expect(guides.first.id).to eq(norf_guide.id)
      expect(guides.first.label).to eq(norf_guide.metadata.label)
    end
  end

  def guide_for(name, locale)
    metadata = { label: name.titlecase }
    GuideDecorator.new(Guide.new(name, locale, content_type: :govspeak, content: '', metadata: metadata))
  end
end
