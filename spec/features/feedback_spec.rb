require 'spec_helper'

RSpec.feature 'Customer feedback', js: true do
  scenario 'Can be accessed via Tesco landing page' do
    visit '/en/tesco'

    click_on 'contact us'

    expect(page).to have_content('Feedback')
    expect(page).to have_content('Message')
  end

  scenario 'can be left on the pension type tool' do
    begin
      allow_forgery_protection = FeedbacksController.allow_forgery_protection
      FeedbacksController.allow_forgery_protection = true

      visit '/pension-type-tool'

      click_on 'Is there anything wrong with this page?'

      fill_in 'Name', with: 'Jim Bob'
      fill_in 'Email', with: 'jim@bob.com'
      fill_in 'Message', with: 'Some feedback'

      click_on 'Send feedback'

      expect(page).to have_content('Thank you for your help')
    ensure
      FeedbacksController.allow_forgery_protection = allow_forgery_protection
    end
  end
end
