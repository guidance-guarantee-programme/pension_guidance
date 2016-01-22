When(/^I visit the (?:homepage|Pension Wise website)$/) do
  @page = Pages::Home.new
  @page.load
end

Then(/^I see links to guides/) do
  step 'I can navigate to guides from the footer'
end

Then(/^I can navigate to guides from the footer$/) do
  expect(@page.footer).to have_categories

  @page.footer.categories.each do |category|
    expect(category).to have_header
    expect(category).to have_links
  end
end
