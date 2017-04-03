RSpec.describe CategoryDecorator, type: :decorator do
  let(:locale) { 'en' }
  subject(:decorator) { described_class.new(category, locale) }

  let(:category) do
    instance_double(Category,
                    id: category_id,
                    slug: category_slug,
                    title: category_title,
                    description: category_description)
  end

  let(:category_id) { double }
  let(:category_slug) { 'slug' }
  let(:category_title) { double }
  let(:category_description) { double }

  describe '#id' do
    subject { decorator.id }

    it 'delegates to the object' do
      is_expected.to eq(category_id)
    end
  end

  describe '#label' do
    subject { decorator.label }

    it 'delegates to the object title' do
      is_expected.to eq(category_title)
    end
  end

  describe '#title' do
    subject { decorator.title }

    it 'delegates to the object' do
      is_expected.to eq(category_title)
    end
  end

  describe '#description' do
    subject { decorator.description }

    it 'delegates to the object' do
      is_expected.to eq(category_description)
    end
  end

  describe '#url' do
    subject { decorator.url }

    it 'constructs a browse path using the object slug' do
      is_expected.to eq("/#{locale}/browse/#{category_slug}")
    end
  end
end
