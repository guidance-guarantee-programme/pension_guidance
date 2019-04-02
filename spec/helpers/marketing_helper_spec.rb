RSpec.describe MarketingHelper, type: :helper do
  describe '#current_campaign' do
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

    %w(apples dogs paint peppers).each do |param|
      context "when the :campaign param is set to '#{param}'" do
        before do
          helper.params[:campaign] = param
        end

        it 'returns the correct campaign' do
          expect(helper.current_campaign).to eq(param)
        end
      end
    end
  end

  describe '#campaign_phone_number' do
    context 'when there is no :platform param set' do
      it 'defaults to 0800 138 3375' do
        expect(helper.campaign_phone_number).to eq('0800 138 3375')
      end
    end

    context 'when :platform is set to facebook' do
      before do
        helper.params[:platform] = 'facebook'
      end

      it 'returns 0800 138 1586' do
        expect(helper.campaign_phone_number).to eq('0800 138 1586')
      end
    end

    context 'when :platform is set to google' do
      before do
        helper.params[:platform] = 'google'
      end

      it 'returns 0800 138 1586' do
        expect(helper.campaign_phone_number).to eq('0800 138 8293')
      end
    end

    context 'when :platform is set to linkedin' do
      before do
        helper.params[:platform] = 'linkedin'
      end

      it 'returns 0800 138 1582' do
        expect(helper.campaign_phone_number).to eq('0800 138 1582')
      end
    end

    context 'when :platform is set to an unknown value' do
      before do
        helper.params[:platform] = 'unknown'
      end

      it 'returns 0800 138 3375' do
        expect(helper.campaign_phone_number).to eq('0800 138 3375')
      end
    end
  end
end
