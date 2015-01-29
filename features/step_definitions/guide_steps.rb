When(/^I visit a guide$/) do
  step 'I visit the tax guide'
end

When(/^I visit the (.*) guide$/) do |slug|
  @guide = Pages::Guide.new
  @guide.load(slug: slug)
end

Then(/^the guide is displayed$/) do
  expect(@guide).to be_displayed
end

Then(/^the page title corresponds to the title of the guide/) do
  expect(@guide.title).to include('Tax you pay on your pension')
end

And(/^the page heading corresponds to the title of the guide$/) do
  expect(@guide.primary_heading).to have_content('Tax you pay on your pension')
end
