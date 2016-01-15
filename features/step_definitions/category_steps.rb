When(/^I visit a category$/) do
  @page = Pages::Category.new
  @page.load(slug: 'taking-your-pension-money')
end

Then(/^the page title corresponds to the title of the category/) do
  expect(@page.title).to include('Taking your pension money')
end

And(/^the page heading corresponds to the title of the category$/) do
  expect(@page.heading).to have_content('Taking your pension money')
end

Then(/^the page meta description corresponds to the meta description of the category/) do
  expected_description = 'The different ways you can take money from your pension, ' \
                         'shopping around and making your money last.'

  expect(@page).to have_meta(:description, expected_description)
end
