When(/^I visit a guide$/) do
  step 'I visit the scams guide'
end

When(/^I visit the (.*) guide$/) do |slug|
  @guide = Pages::Guide.new
  @guide.load(slug: slug)
end

Then(/^the guide is displayed$/) do
  expect(@guide).to be_displayed
end

Then(/^the page title corresponds to the title of the guide/) do
  expect(@guide.title).to include('How to avoid a pension scam')
end

And(/^the page heading corresponds to the title of the guide$/) do
  expect(@guide.primary_heading).to have_content('How to avoid a pension scam')
end

Then(/^the page meta description corresponds to the meta description of the guide$/) do
  expected_description = 'How to spot the signs of a pension scam, how to protect yourself, ' \
    'and what to do if you’ve been targeted.'
  expect(@guide).to have_meta(:description, expected_description)
end

Then(/^I can navigate to each option available to me$/) do
  expect(@guide.option_links.map(&:text))
    .to eq(['More on leaving your whole pot untouched',
            'More on getting a guaranteed income (annuity)',
            'More on adjustable income',
            'More on taking cash in chunks',
            'More on taking your whole pot in one go',
            'More on mixing your options'])
end
