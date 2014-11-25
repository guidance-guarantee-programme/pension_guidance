RSpec.describe ArticlesController, type: :controller do

  describe 'GET show' do
    context 'existing article' do
      let(:article) { instance_double(Article) }

      before do
        expect(ArticleRepository).to receive(:find).and_return(article)

        get :show, id: 'your-pension-pot-value'
      end

      specify { expect(response).to be_success }
      specify { expect(assigns(:article)).to_not be_nil }
    end

    context 'non-existent article' do
      it 'should be not found' do
        get :show, id: 'non-existent-article'

        expect(response).to be_not_found
      end
    end
  end

end
