RSpec.describe 'Take whole pot calculator', type: :feature do
  with_and_without_javascript do
    scenario 'Calculates tax payable and money receivable' do
      visit '/take-whole-pot'

      fill_in 'pot', with: 100_000
      fill_in 'income', with: 7_000
      fill_in 'pension', with: 5_000
      select 'Annual', from: 'pension_frequency'
      click_on 'Calculate'

      expect(page.find('.t-pot-tax')).to have_content('£23,923.00')
    end
  end
end
