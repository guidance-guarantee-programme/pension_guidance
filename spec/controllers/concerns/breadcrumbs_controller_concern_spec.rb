RSpec.describe 'Breadcrumbs', type: :controller do
  let(:breadcrumb_1) { 'breadcrumb 1' }
  let(:breadcrumb_2) { 'breadcrumb 2' }
  let(:breadcrumbs) { [breadcrumb_1, breadcrumb_2] }

  controller do
    include Breadcrumbs

    public :breadcrumbs

    def index
      params.fetch('breadcrumbs', []).each do |b|
        breadcrumb b
      end
      head :ok
    end
  end

  context 'not setting a breadcrumb' do
    before do
      get :index
    end

    specify { expect(controller.breadcrumbs).to be_empty }
  end

  context 'setting a breadcrumb' do
    let(:breadcrumbs) { [breadcrumb_1] }

    before do
      get :index, params: { breadcrumbs: breadcrumbs }
    end

    specify { expect(controller.breadcrumbs).to eq(breadcrumbs) }
  end

  context 'setting multiple breadcrumbs' do
    before do
      get :index, params: { breadcrumbs: breadcrumbs }
    end

    specify { expect(controller.breadcrumbs).to eq(breadcrumbs) }
  end

  context 'after a request which has set a breadcrumb' do
    before do
      get :index, params: { breadcrumbs: breadcrumbs }
      get :index
    end

    specify { expect(controller.breadcrumbs).to be_empty }
  end
end
