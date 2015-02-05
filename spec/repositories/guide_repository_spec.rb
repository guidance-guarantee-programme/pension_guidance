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

    shared_examples 'existing guide' do |expected_source_type, expected_filename|
      specify 'with the correct id' do
        expect(find.id).to eq id
      end

      specify 'with the correct source pathname' do
        expect(find.source).to eq(Rails.root.join("spec/fixtures/#{expected_filename}").to_s)
      end

      specify "with expected_source_type #{expected_source_type}" do
        expect(find.source_type).to eq(expected_source_type)
      end
    end

    context 'a govspeak guide' do
      let(:id) { 'the_test_govspeak_guide' }

      include_examples 'existing guide', :govspeak, 'the_test_govspeak_guide.md'
    end

    context 'an html guide' do
      let(:id) { 'the_test_html_guide' }

      include_examples 'existing guide', :html, 'the_test_html_guide.html'
    end
  end

  describe '#all' do
    it 'returns an array of guides' do
      expect(guide_repository.all.map(&:id)).to contain_exactly('the_test_html_guide', 'the_test_govspeak_guide')
    end
  end
end
