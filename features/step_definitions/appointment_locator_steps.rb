When(/^I search for appointment locations near to a valid postcode$/) do
  Pages::Locations.new.load(postcode: 'SW1A 2HQ')
end

Then(/^I should see the (\d+) appointment locations nearest to that postcode$/) do |number_of_locations|
  pending # express the regexp above with the code you wish you had
end
