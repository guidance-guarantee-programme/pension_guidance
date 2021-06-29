describe WelshLanguage::BookingRequestsController, type: :controller do
  describe 'it is embeddable' do
    it { expect(controller.class.ancestors).to include(Embeddable) }
  end
end
