When(/^I visit the (?:homepage|Pension Wise website)$/) do
  @page = Pages::Home.new
  @page.load(locale: :en)
end

Then(/^I see links to the different pension options/) do
  option_links_text = @page.options.map(&:text)
  expect(option_links_text).to eq(
    [
      'Leave your pot untouched',
      'Guaranteed income (annuity)',
      'Adjustable income',
      'Take cash in chunks',
      'Take whole pot',
      'Mix your options'
    ]
  )
end
