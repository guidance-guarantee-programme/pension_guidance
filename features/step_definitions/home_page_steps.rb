When(/^I visit the (homepage|Pension Wise website)$/) do |_|
  @page = Pages::Home.new
  @page.load(locale: :en)
end

Then(/^I see information about the service/) do
  expect(@page.who).to be_visible
  expect(@page.what).to be_visible
  expect(@page.how).to be_visible
end

Then(/^I see a link to book a free appointment$/) do
  expect(@page.book).to be_visible
end
