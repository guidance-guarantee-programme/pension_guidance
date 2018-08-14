RSpec.describe HomeHelper, type: :helper do
  describe '#banner_image' do
    subject { helper.banner_image(today) }

    context 'before the start date' do
      let(:today) { Date.civil(2018, 8, 14) }

      it 'returns an empty string' do
        expect(subject).to be_empty
      end
    end

    context 'from the W/C 20 Aug' do
      let(:today) { Date.civil(2018, 8, 20) }

      it 'returns peppers' do
        expect(subject).to eq('peppers')
      end
    end

    context 'from the W/C 27 Aug' do
      let(:today) { Date.civil(2018, 8, 27) }

      it 'returns peppers' do
        expect(subject).to eq('peppers')
      end
    end

    context 'from the W/C 3 Sep' do
      let(:today) { Date.civil(2018, 9, 3) }

      it 'returns paint' do
        expect(subject).to eq('paint')
      end
    end

    context 'from the W/C 10 Sep' do
      let(:today) { Date.civil(2018, 9, 10) }

      it 'returns paint' do
        expect(subject).to eq('paint')
      end
    end

    context 'from the W/C 17 Sep' do
      let(:today) { Date.civil(2018, 9, 17) }

      it 'returns peppers' do
        expect(subject).to eq('peppers')
      end
    end

    context 'from the W/C 24 Sep' do
      let(:today) { Date.civil(2018, 9, 24) }

      it 'returns peppers' do
        expect(subject).to eq('peppers')
      end
    end

    context 'from the W/C 1 Oct' do
      let(:today) { Date.civil(2018, 10, 1) }

      it 'returns paint' do
        expect(subject).to eq('paint')
      end
    end

    context 'from the W/C 8 Oct' do
      let(:today) { Date.civil(2018, 10, 8) }

      it 'returns paint' do
        expect(subject).to eq('paint')
      end
    end

    context 'from the W/C 15 Oct' do
      let(:today) { Date.civil(2018, 10, 15) }

      it 'returns peppers' do
        expect(subject).to eq('peppers')
      end
    end

    context 'from the W/C 22 Oct' do
      let(:today) { Date.civil(2018, 10, 22) }

      it 'returns peppers' do
        expect(subject).to eq('peppers')
      end
    end
  end
end
