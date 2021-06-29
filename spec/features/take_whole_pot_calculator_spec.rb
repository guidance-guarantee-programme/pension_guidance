RSpec.describe 'Take whole pot calculator', type: :feature do
  with_and_without_javascript do
    scenario 'Calculates tax payable and money receivable' do
      visit '/en/take-whole-pot'

      fill_in 'pot', with: 100_000
      fill_in 'income', with: 7_000
      click_on 'Calculate'

      expect(page.find('.t-pot-received')).to have_content('£79,768')
      expect(page.find('.t-pot-tax')).to have_content('£20,232')
    end
  end
end
