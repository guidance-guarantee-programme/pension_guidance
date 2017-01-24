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

      specify 'with the correct tags' do
        expect(find.metadata.tags).to eq(expect_tags)
      end
    end

    context 'a govspeak guide' do
      let(:id) { 'the_test_govspeak_guide' }

      it 'lists the available locales' do
        expect(find.available_locales).to match_array(%i(en without-overrides with-overrides))
      end

      include_examples 'existing guide' do
        let(:expected_content_type) { :govspeak }
        let(:expected_content) { "# This is the test guide\n" }
        let(:expected_label) { 'Tested' }
        let(:expected_description) { 'The guide used for testing' }
        let(:expect_tags) { %w(testing tags govspeak) }
      end

      context 'language file without metadata overrides' do
        before do
          allow(I18n).to receive(:locale).and_return(:'without-overrides')
        end

        include_examples 'existing guide' do
          let(:expected_content_type) { :govspeak }
          let(:expected_content) { "# This is the test guide without metadata overrides\n" }
          let(:expected_label) { 'Tested' }
          let(:expected_description) { 'The guide used for testing' }
          let(:expect_tags) { %w(testing tags govspeak) }
        end
      end

      context 'language file with metadata overrides' do
        before do
          allow(I18n).to receive(:locale).and_return(:'with-overrides')
        end

        include_examples 'existing guide' do
          let(:expected_content_type) { :govspeak }
          let(:expected_content) { "# This is the test guide with metadata overrides\n" }
          let(:expected_label) { 'Tested and overwritten' }
          let(:expected_description) { 'The guide used for override testing' }
          let(:expect_tags) { %w(override) }
        end
      end
    end

    context 'an HTML guide' do
      let(:id) { 'the_test_html_guide' }

      include_examples 'existing guide' do
        let(:expected_content_type) { :html }
        let(:expected_content) { "<h1>This is the test guide</h1>\n" }
        let(:expected_label) { 'Tested' }
        let(:expected_description) { 'The guide used for testing' }
        let(:expect_tags) { %w(testing tags html) }
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

  describe '#slugs' do
    it 'returns an array of slugs' do
      expect(guide_repository.slugs).to include(
        'the-test-html-guide',
        'the-test-govspeak-guide',
        'nested/nested-guide'
      )
    end
  end
end
