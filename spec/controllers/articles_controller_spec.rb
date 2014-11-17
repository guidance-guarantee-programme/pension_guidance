RSpec.describe ArticlesController, type: :controller do

  describe 'GET show' do
    context 'existing article' do
      before do
        get :show, id: 'your-pension-pot-value'
      end

      it 'returns 200' do
        expect(response).to be_success
      end

      it 'renders the right template' do
        expect(response).to render_template('your_pension_pot_value')
      end
    end

    context 'non-existent article' do
      before do
        get :show, id: 'non-existent-article'
      end

      it 'returns 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

end
