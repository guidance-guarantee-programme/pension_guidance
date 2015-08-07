Given(/^I (?:am on|visit) the home page$/) do
  @page = Pages::Home.new
  @page.load
end

When(/^I search for something relevant$/) do
  @page.search.input.set 'annuity'
  @page.search.submit.click
end

When(/^I search for something irrelevant$/) do
  @page.search.input.set 'Student loans'
  @page.search.submit.click
end

When(/^I search for a query that returns two pages of results$/) do
  step 'I search for something relevant'
end

When(/^I go to the next page of results$/) do
  page = Pages::SearchResults.new

  page.pagination.next_button.click
end

When(/^I go to the third page of a query that returns two pages of results$/) do
  visit(search_results_path(query: 'annuity', page: 3))
end

When(/^I submit a search with no query$/) do
  @page.search.input.set ''
  @page.search.submit.click
end

Then(/^I should see the search box$/) do
  expect(@page.search.input).to be_visible
end

Then(/^I should see the search page$/) do
  page = Pages::SearchResults.new

  expected_heading = 'Search Pension Wise'
  expected_title = 'Search - Pension Wise'

  expect(page.title).to eq(expected_title)
  expect(page.heading).to have_content(expected_heading)
  expect(page).not_to have_results
end

Then(/^I should see search results$/) do
  page = Pages::SearchResults.new

  expected_heading = 'Search results for “annuity”'
  expected_title = 'annuity - Search - Pension Wise'

  expect(page.title).to eq(expected_title)
  expect(page.heading).to have_content(expected_heading)
  expect(page).to have_results
end

Then(/^I should see no search results$/) do
  page = Pages::SearchResults.new

  expected_heading = 'Search results for “Student loans”'
  expected_title = 'Student loans - Search - Pension Wise'

  expect(page.title).to eq(expected_title)
  expect(page.heading).to have_content(expected_heading)
  expect(page).to have_no_results
end

Then(/^I should prompted to try another search term$/) do
  page = Pages::SearchResults.new

  expect(page).to have_content('No results were found. Please try a different search.')
end

Then(/^I should see the "Next" button$/) do
  page = Pages::SearchResults.new

  expect(page.pagination).to have_next_button
end

Then(/^I should see the "Previous" button$/) do
  page = Pages::SearchResults.new

  expect(page.pagination).to have_previous_button
end

Then(/^I should not see the "Next" button$/) do
  page = Pages::SearchResults.new

  expect(page.pagination).not_to have_next_button
end

Then(/^I should not see the "Previous" button$/) do
  page = Pages::SearchResults.new

  expect(page.pagination).not_to have_previous_button
end

Then(/^I should be on page (\d+) of (\d+) of the search results$/) do |current_page, number_of_pages|
  page = Pages::SearchResults.new

  previous_page = current_page.to_i - 1

  expect(page.pagination.previous_title).to have_content("#{previous_page} of #{number_of_pages}")
end

Then(/^I should see what the next page number is$/) do
  page = Pages::SearchResults.new

  expect(page.pagination.next_title).to have_content('2 of 2')
end

Then(/^I should see what the previous page number is$/) do
  page = Pages::SearchResults.new

  expect(page.pagination.previous_title).to have_content('1 of 2')
end
