When(/^I visit the feedback page$/) do
  @page = Pages::Feedback.new
  @page.load
end

When(/^I leave feedback$/) do
  @page.feedback.tap do |f|
    f.name.set 'Ben'
    f.email.set 'ben@example.com'
    f.message.set 'This is awesome!'
    f.submit.click
  end
end

When(/^I leave invalid feedback$/) do
  @page.feedback.submit.click
end

Then(/^I am thanked for my feedback$/) do
  expect(page).to have_content('Thank you for your help')
end

Then(/^I see error messages$/) do
  expect(@page).to have_errors
end
