require 'spec_helper'

RSpec.feature 'Customer feedback', js: true do
  scenario 'Can be accessed via Tesco landing page' do
    skip 'temporarily disabled due to zendesk'

    visit '/en/tesco'

    click_on 'contact us'

    expect(page).to have_content('Feedback')
    expect(page).to have_content('Message')
  end
end
