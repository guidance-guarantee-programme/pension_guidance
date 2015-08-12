RSpec.describe Search::GoogleCustomSearchEngine::ResponseItemMapper do
  describe '#mapped_item_response' do
    let(:id) { 'appointments' }
    let(:title) { 'Book a free appointment' }
    let(:link) { 'https://www.pensionwise.gov.uk/appointments' }
    let(:snippet) { 'You’ll get personal guidance on what you can do with your pension pot.' }
    let(:item) do
      {
        'link' => link,
        'htmlTitle' => title,
        'htmlSnippet' => snippet
      }
    end

    subject { described_class.new(item).mapped_item_response }

    it 'maps the id correctly' do
      expect(subject[:id]).to eq(id)
    end

    it 'maps the title correctly' do
      expect(subject[:title]).to eq(title)
    end

    it 'maps the link correctly' do
      expect(subject[:link]).to eq(link)
    end

    it 'maps the snippet correctly' do
      expect(subject[:snippet]).to eq(snippet)
    end
  end
end
