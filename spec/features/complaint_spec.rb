require 'spec_helper'

RSpec.feature 'Customer complaints' do
  scenario 'a complaint can be completed via the contact page', js: true do
    visit '/contact'

    click_on 'Accept all cookies'

    fill_in 'Name', with: 'Jim Bob'
    fill_in 'Email', with: 'jim@bob.com'
    fill_in 'complaint_phone_booking_message', with: 'Some phone booking feedback'

    click_on 'Send complaint'

    expect(page).to have_content('Your complaint has been submitted')
    expect(page).not_to have_content('please fill in and submit the form below')
  end
end
