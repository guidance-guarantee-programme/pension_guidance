RSpec.describe GuideRepository do
  subject(:guide_repository) do
    GuideRepository.new(File.expand_path('../../fixtures', __FILE__))
  end

  describe '#find' do
    subject(:find) { guide_repository.find(id) }

    context 'non-existent guide' do
      let(:id) { 'does_not_exist' }

      specify { expect { find }.to raise_error(GuideRepository::GuideNotFound) }
    end

    context 'existing guide' do
      let(:id) { 'the_test_guide' }

      describe 'returns the guide' do
        specify 'with the correct id' do
          expect(find.id).to eq id
        end

        specify 'with the correct source pathname' do
          expect(find.source).to eq(Rails.root.join('spec/fixtures/the_test_guide.md').to_s)
        end
      end
    end
  end

  describe '#all' do
    it 'returns an array of guides' do
      expect(guide_repository.all.first.id).to eq('the_test_guide')
    end
  end
end
