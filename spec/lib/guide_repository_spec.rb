RSpec.describe GuideRepository do
  subject(:guide_repository) { GuideRepository.new(source) }

  let(:source) { File.expand_path('../../fixtures', __FILE__) }

  describe '#find' do
    subject(:find) { guide_repository.find(id) }

    context 'non-existent guide' do
      let(:id) { 'does-not-exist' }

      specify { expect { find }.to raise_error(GuideRepository::GuideNotFound) }
    end

    context 'existing guide' do
      let(:id) { 'govspeak' }

      it 'returns the guide' do
        expect(find.id).to eq id
      end
    end
  end

  describe '#all' do
    it 'returns an array of guides' do
      expect(guide_repository.all.first.id).to eq('govspeak')
    end
  end
end
