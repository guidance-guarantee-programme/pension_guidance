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

    shared_examples 'existing guide' do
      specify 'with the correct id' do
        expect(find.id).to eq id
      end

      specify 'with the correct content' do
        expect(find.content).to eq(expected_content)
      end

      specify 'with the correct label' do
        expect(find.metadata.label).to eq(expected_label)
      end

      specify 'with the correct description' do
        expect(find.metadata.description).to eq(expected_description)
      end

      specify 'with the correct content type' do
        expect(find.content_type).to eq(expected_content_type)
      end
    end

    context 'a govspeak guide' do
      let(:id) { 'the_test_govspeak_guide' }

      include_examples 'existing guide' do
        let(:expected_content_type) { :govspeak }
        let(:expected_content) { "# This is the test guide\n" }
        let(:expected_label) { 'Tested' }
        let(:expected_description) { 'The guide used for testing' }
      end
    end

    context 'an HTML guide' do
      let(:id) { 'the_test_html_guide' }

      include_examples 'existing guide' do
        let(:expected_content_type) { :html }
        let(:expected_content) { "<h1>This is the test guide</h1>\n" }
        let(:expected_label) { 'Tested' }
        let(:expected_description) { 'The guide used for testing' }
      end
    end
  end

  describe '#all' do
    it 'returns an array of guides' do
      expect(guide_repository.all.map(&:id)).to include(
        'the_test_html_guide',
        'the_test_govspeak_guide',
        'nested/nested_guide'
      )
    end
  end
end
