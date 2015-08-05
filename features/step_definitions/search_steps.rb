Given(/^I (?:am on|visit) the home page$/) do
  @page = Pages::Home.new
  @page.load
end

Then(/^I should see the search box$/) do
  expect(@page.search.input).to be_visible
end
