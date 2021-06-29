When(/^I visit a guide$/) do
  step 'I visit the scams guide'
end

When(/^I visit the (.*) guide$/) do |slug|
  @page = Pages::Guide.new
  @page.load(locale: :en, slug: slug)
end

Then(/^the guide is displayed$/) do
  expect(@page).to be_displayed
end

Then(/^the page title corresponds to the title of the guide/) do
  expect(@page.title).to include('How to avoid a pension scam')
end

And(/^the page heading corresponds to the title of the guide$/) do
  expect(@page.primary_heading).to have_content('How to avoid a pension scam')
end

Then(/^the page meta description corresponds to the meta description of the guide$/) do
  expected_description = 'How to spot the signs of a pension scam, how to protect yourself, ' \
    'and what to do if you’ve been targeted.'
  expect(@page).to have_meta(:description, expected_description)
end

Then(/^I can navigate to each option available to me$/) do
  expect(@page.option_links.map(&:text))
    .to eq(['More on leaving your whole pot untouched',
            'More on getting a guaranteed income (annuity)',
            'More on adjustable income',
            'More on taking cash in chunks',
            'More on taking your whole pot in one go',
            'More on mixing your options'])
end

Then(/^next button navigates to (.*)$/) do |path|
  if path.present?
    expect(@page.next_link['href']).to eq(path)
  else
    expect(@page).not_to have_next_link
  end
end

Then(/^previous button navigates to (.*)$/) do |path|
  if path.present?
    expect(@page.previous_link['href']).to eq(path)
  else
    expect(@page).not_to have_previous_link
  end
end
