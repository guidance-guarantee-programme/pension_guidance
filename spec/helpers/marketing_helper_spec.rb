RSpec.describe MarketingHelper, type: :helper do
  describe '#banner_image' do
    subject { helper.current_campaign(today) }

    shared_examples_for 'landing page aliases' do
      context 'when the action name is about' do
        before do
          controller.action_name = 'about'
        end

        it 'returns peppers' do
          expect(subject).to eq('peppers')
        end
      end

      context 'when the action name is facebook' do
        before do
          controller.action_name = 'facebook'
        end

        it 'returns dogs' do
          expect(subject).to eq('dogs')
        end
      end
    end

    context 'before the start date' do
      let(:today) { Date.civil(2019, 2, 16) }

      it 'returns dogs' do
        expect(subject).to eq('dogs')
      end

      include_examples 'landing page aliases'
    end

    context 'from the 17 February, 2019' do
      let(:today) { Date.civil(2019, 2, 17) }

      it 'returns apples' do
        expect(subject).to eq('apples')
      end

      include_examples 'landing page aliases'
    end

    context 'from the 2 March, 2019' do
      let(:today) { Date.civil(2019, 3, 2) }

      it 'returns paint' do
        expect(subject).to eq('paint')
      end

      include_examples 'landing page aliases'
    end

    context 'past the end of the schedule' do
      let(:today) { Date.civil(2020, 1, 1) }

      it 'returns paint' do
        expect(subject).to eq('paint')
      end

      include_examples 'landing page aliases'
    end

    describe 'when using a custom schedule' do
      let(:schedule) do
        <<~CSV
          2019-02-17,apples
          2019-03-02,paint
          2019-12-31,dogs
        CSV
      end

      around do |example|
        ENV['CAMPAIGN_SCHEDULE'] = schedule
        example.run
        ENV.delete('CAMPAIGN_SCHEDULE')
      end

      context 'before the start date' do
        let(:today) { Date.civil(2019, 2, 16) }

        it 'returns apples' do
          expect(subject).to eq('apples')
        end

        include_examples 'landing page aliases'
      end

      context 'from the 17 February, 2019' do
        let(:today) { Date.civil(2019, 2, 17) }

        it 'returns paint' do
          expect(subject).to eq('paint')
        end

        include_examples 'landing page aliases'
      end

      context 'from the 2 March, 2019' do
        let(:today) { Date.civil(2019, 3, 2) }

        it 'returns dogs' do
          expect(subject).to eq('dogs')
        end

        include_examples 'landing page aliases'
      end

      context 'past the end of the schedule' do
        let(:today) { Date.civil(2020, 1, 1) }

        it 'returns dogs' do
          expect(subject).to eq('dogs')
        end

        include_examples 'landing page aliases'
      end
    end
  end
end
