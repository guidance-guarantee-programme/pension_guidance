RSpec.describe HomeHelper, type: :helper do
  describe '#banner_image' do
    subject { helper.banner_image(today) }

    context 'before the start date' do
      let(:today) { Date.civil(2019, 2, 16) }

      it 'returns peppers' do
        expect(subject).to eq('peppers')
      end
    end

    context 'from the 17 February, 2019' do
      let(:today) { Date.civil(2019, 2, 17) }

      it 'returns apples' do
        expect(subject).to eq('apples')
      end
    end

    context 'from the 2 March, 2019' do
      let(:today) { Date.civil(2019, 3, 2) }

      it 'returns paint' do
        expect(subject).to eq('paint')
      end
    end

    context 'past the end of the schedule' do
      let(:today) { Date.civil(2020, 1, 1) }

      it 'returns paint' do
        expect(subject).to eq('paint')
      end
    end

    describe 'when using a custom schedule' do
      let(:schedule) do
        <<~CSV
          2019-02-17,paint
          2019-03-02,peppers
          2019-12-31,apples
        CSV
      end

      around do |example|
        ENV['BANNER_SCHEDULE'] = schedule
        example.run
        ENV.delete('BANNER_SCHEDULE')
      end

      context 'before the start date' do
        let(:today) { Date.civil(2019, 2, 16) }

        it 'returns paint' do
          expect(subject).to eq('paint')
        end
      end

      context 'from the 17 February, 2019' do
        let(:today) { Date.civil(2019, 2, 17) }

        it 'returns peppers' do
          expect(subject).to eq('peppers')
        end
      end

      context 'from the 2 March, 2019' do
        let(:today) { Date.civil(2019, 3, 2) }

        it 'returns apples' do
          expect(subject).to eq('apples')
        end
      end

      context 'past the end of the schedule' do
        let(:today) { Date.civil(2020, 1, 1) }

        it 'returns apples' do
          expect(subject).to eq('apples')
        end
      end
    end
  end
end
