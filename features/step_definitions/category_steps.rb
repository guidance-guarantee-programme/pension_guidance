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

Then(/^I can navigate to guides that belong to the category$/) do
  expect(@page.guide_links.map(&:text))
    .to eq(['Shop around and compare providers',
            'Make your money last',
            'Work out what you’ll have in retirement',
            'Taking your pension before 55',
            'How to avoid a pension scam',
            'Leave your pot untouched',
            'Get a guaranteed income (annuity)',
            'Get an adjustable income',
            'Take cash in chunks',
            'Take your whole pot',
            'Mix your options'])
end
