RSpec.describe SearchResultsController, type: :controller do
  describe 'GET index' do
    let(:query) { 'query' }
    let(:search_results_collection) { double(any?: true) }
    let(:searcher) { double }

    before do
      allow(Search::PerformSearch).to receive(:new) { searcher }
      allow(searcher).to receive(:call) { search_results_collection }
    end

    context 'with a search term' do
      it 'calls the search' do
        expect(searcher).to receive(:call)

        get :index, query: query
      end

      context 'that returns results' do
        it 'assigns the result of the search reader to @search_results' do
          get :index, query: query

          expect(assigns(:search_results)).to eq(search_results_collection)
        end

        it 'renders the right template' do
          get :index, query: query

          expect(response).to render_template 'search_results/index_with_results'
        end
      end

      context 'that returns no results' do
        before { allow(search_results_collection).to receive(:any?) { false } }

        it 'renders the right template' do
          get :index, query: query

          expect(response).to render_template 'search_results/index_no_results'
        end
      end

      context 'but the lookup fails' do
        before do
          allow(searcher).to receive(:call) { fail 'failed lookup' }
        end

        it 'renders the error page' do
          get :index, query: query

          expect(response).to render_template 'search_results/index_error'
        end
      end
    end

    context 'without a search term' do
      it 'does not instantiate an search reader' do
        expect(Search::PerformSearch).to_not receive(:new)

        get :index
      end

      it 'renders the default template' do
        get :index

        expect(response).to render_template :index
      end
    end
  end
end
