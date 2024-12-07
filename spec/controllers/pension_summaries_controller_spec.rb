describe PensionSummariesController, type: :controller do
  describe 'it is embeddable' do
    it { expect(controller.class.ancestors).to include(Embeddable) }
  end

  let(:pension_summary) { FactoryBot.create(:pension_summary, :generated) }

  context 'when providing an invalid or missing URN' do
    it 'does not add @urn to the assigns' do
      get :download, params: {
        locale: 'cy',
        id: pension_summary.id,
        urn: 'bad times!'
      }

      expect(assigns[:urn]).to be_nil
    end
  end

  context 'when providing a valid URN' do
    it 'adds @urn to the assigns' do
      get :download, params: {
        locale: 'cy',
        id: pension_summary.id,
        urn: 'PWD1-2ABC'
      }

      expect(assigns[:urn]).to eq('PWD1-2ABC')
    end
  end
end
