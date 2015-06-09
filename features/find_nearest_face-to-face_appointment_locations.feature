Feature: Find nearest face-to-face appointment locations
  As a customer who'd prefer a face-to-face appointment
  I want the details of nearest appointment locations
  So that I can book a convenient face-to-face appointment

@wip
Scenario: Search using a valid postcode
  When I search for appointment locations near to a valid postcode
  Then I should see the 5 appointment locations nearest to that postcode

@todo
Scenario: Search using an invalid postcode (i.e. one that we can't find)
  When I search for appointment locations near to an invalid postcode
  Then I should be informed that Pension Wise cannot find that postcode

@todo
Scenario: Bookmark search results
  Given I have searched for appointment locations near to a valid postcode
  And I have bookmarked the page
  When I visit the bookmarked page
  Then I should see the 5 appointment locations nearest to that postcode
