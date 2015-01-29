RSpec.describe GuidesController, type: :controller do
  describe 'GET show' do
    before do
      routes.draw { get '/:id', to: 'guides#show' }
    end

    after do
      Rails.application.routes_reloader.reload!
    end

    context 'existing guide' do
      let(:guide) { instance_double(Guide) }

      before do
        expect_any_instance_of(GuideRepository).to receive(:find).and_return(guide)

        get :show, id: 'your-pension-pot-value'
      end

      specify { expect(response).to be_success }
      specify { expect(assigns(:guide)).to_not be_nil }
    end

    context 'non-existent guide' do
      it 'should raise exception' do
        expect { get :show, id: 'non-existent-guide' }.to raise_exception(GuideRepository::GuideNotFound)
      end
    end
  end
end
