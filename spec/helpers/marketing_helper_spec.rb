RSpec.describe MarketingHelper, type: :helper do
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
