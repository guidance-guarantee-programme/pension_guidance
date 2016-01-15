RSpec.describe CategoryRepository do
  subject(:repository) do
    described_class.new(File.expand_path('../../fixtures', __FILE__))
  end

  describe '#find' do
    subject(:find) { repository.find(id) }

    context 'non-existent category' do
      let(:id) { 'does_not_exist' }

      specify { expect { find }.to raise_error(described_class::CategoryNotFound) }
    end

    context 'existing category' do
      let(:id) { 'the_test_category' }
      let(:expected_title) { 'The test category' }
      let(:expected_description) { 'Lots of testing stuff to be found here.' }

      specify 'with the correct id' do
        expect(find.id).to eq(id)
      end

      specify 'with the correct title' do
        expect(find.title).to eq(expected_title)
      end

      specify 'with the correct description' do
        expect(find.description).to eq(expected_description)
      end
    end
  end
end
