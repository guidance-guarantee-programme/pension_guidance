RSpec.describe GuidesController, type: :controller do
  describe 'GET show' do
    before do
      routes.draw do
        get '/:locale/:id', to: 'guides#show', as: :guide
      end
    end

    after do
      Rails.application.routes_reloader.reload!
    end

    context 'existing guide' do
      let(:guide) { instance_spy(Guide, content_type: :govspeak) }

      before do
        allow_any_instance_of(GuideRepository).to receive(:find).and_return(guide)

        get :show, params: { locale: :en, id: 'your-pension-pot-value' }
      end

      specify { expect(response).to be_successful }
      specify { expect(assigns(:guide)).to_not be_nil }
    end

    context 'non-existent guide' do
      it 'should raise exception' do
        expect { get :show, params: { locale: :en, id: 'non-existent-guide' } }
          .to raise_exception(GuideRepository::GuideNotFound)
      end
    end
  end
end
