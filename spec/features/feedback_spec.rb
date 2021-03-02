require 'spec_helper'

RSpec.feature 'Customer feedback', js: true do
  scenario 'Can be accessed via Tesco landing page' do
    visit '/en/tesco'

    click_on 'Accept all cookies'
    click_on 'contact us'

    expect(page).to have_content('Feedback')
    expect(page).to have_content('Message')
  end
end
