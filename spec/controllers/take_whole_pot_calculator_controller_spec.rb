RSpec.describe TakeWholePotCalculatorController, type: :controller do
  describe 'POST show' do
    let(:pot) { 100_000 }
    let(:income) { 10_000 }
    let(:pension) { 200 }
    let(:result) { double(pot_received: 0, pot_tax: 0) }

    context 'when the pension is paid weekly' do
      let(:pension_frequency) { 'weekly' }
      let(:total_income) { 20_400 }

      it 'calculates the total income' do
        expect(TakeWholePotCalculator).to receive(:new).with(
          pot, total_income
        ).and_return(result)

        get :show, pot: pot,
                   income: income,
                   pension: pension,
                   pension_frequency: pension_frequency
      end
    end

    context 'when the pension is paid annually' do
      let(:pension_frequency) { 'annually' }
      let(:total_income) { 10_200 }

      it 'calculates the total income' do
        expect(TakeWholePotCalculator).to receive(:new).with(
          pot, total_income
        ).and_return(result)

        post :show, pot: pot,
                    income: income,
                    pension: pension,
                    pension_frequency: pension_frequency
      end
    end
  end
end
