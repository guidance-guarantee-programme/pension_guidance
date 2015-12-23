When(/^I visit the (?:homepage|Pension Wise website)$/) do
  @homepage = Pages::Home.new
  @homepage.load
end

Then(/^I see links to guides/) do
  expect(@homepage).to have_links
end

Then(/^I can navigate to guides from the footer$/) do
  expect(@homepage.footer).to have_categories

  @homepage.footer.categories.each do |category|
    expect(category).to have_header
    expect(category).to have_links
  end
end
