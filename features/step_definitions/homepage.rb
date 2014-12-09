When(/^I visit the homepage$/) do
  @homepage = Pages::Homepage.new
  @homepage.load
end

Then(/^I see links to articles$/) do
  expect(@homepage).to have_links
end
