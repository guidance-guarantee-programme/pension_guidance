@vcr
Feature: View face-to-face appointment location details
  As a customer who'd prefer a face-to-face appointment
  I want full details of a specific appointment location
  So that I can book a face-to-face appointment at that location

Scenario: From search results
  Given I have searched for appointment locations near to a valid postcode
  When I drill down into a specific search result
  Then I should see the details of that appointment location
  And I should be able to get back to the search results

Scenario: Bookmark a appointment location
  Given I have searched for appointment locations near to a valid postcode
  And I have drilled down into a specific search result
  And I have bookmarked the page
  When I visit the bookmarked page
  Then I should see the details of that appointment location

Scenario: Appointment location that handles its own booking
  When I view the details of an appointment location that handles its own booking
  Then I should see the following appointment location details:
    | its name                              |
    | its address                           |
    | its opening hours                     |
    | its Pension Wise booking phone number |
  And there are no search results to return to

Scenario: Appointment location that doesn't handle its own booking
  When I view the details of an appointment location that doesn't handle its own booking
  Then I should see the following appointment location details:
    | its name                                           |
    | its address                                        |
    | booking location opening hours                     |
    | booking location Pension Wise booking phone number |
