RSpec.describe CategoryNavigation do
  let(:locale) { :en }
  subject(:browser) { CategoryNavigation.new(category, guides, locale) }

  let(:category) do
    instance_double(Category, id: double, title: double, description: double)
  end

  let(:guides) do
    []
  end

  describe '#title' do
    subject { browser.title }

    it 'returns the title of the category' do
      is_expected.to eq(category.title)
    end
  end

  describe '#description' do
    subject { browser.description }

    it 'returns the description of the category' do
      is_expected.to eq(category.description)
    end
  end

  describe '#guides' do
    subject { browser.guides }

    specify { is_expected.to be_a(Array) }
  end
end
