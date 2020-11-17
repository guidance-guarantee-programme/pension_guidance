@vcr
Feature: View face-to-face appointment location details
  As a customer who'd prefer a face-to-face appointment
  I want full details of a specific appointment location
  So that I can book a face-to-face appointment at that location

Scenario: From search results
  Given I have searched for appointment locations near to a valid postcode
  When I drill down into a specific search result
  Then I should see the details of that appointment location

Scenario: Appointment location that handles its own booking
  When I view the details of an appointment location that handles its own booking
  Then I should see the following appointment location details:
    | its name                              |
    | its address                           |
    | its Pension Wise booking phone number |

Scenario: Appointment location that doesn't handle its own booking
  When I view the details of an appointment location that doesn't handle its own booking
  Then I should see the following appointment location details:
    | its name                                           |
    | its address                                        |
    | booking location Pension Wise booking phone number |
