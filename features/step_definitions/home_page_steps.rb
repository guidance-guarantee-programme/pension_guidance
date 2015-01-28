When(/^I visit the (?:homepage|Pension Wise website)$/) do
  @homepage = Pages::Home.new
  @homepage.load
end

Then(/^I see links to guides/) do
  expect(@homepage).to have_links
end
