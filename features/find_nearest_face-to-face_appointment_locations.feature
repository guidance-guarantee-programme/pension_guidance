@vcr
Feature: Find nearest face-to-face appointment locations
  As a customer who'd prefer a face-to-face appointment
  I want the details of nearest appointment locations
  So that I can book a convenient face-to-face appointment

Scenario: Search using a valid postcode
  When I search for appointment locations near to a valid postcode
  Then I should see the 5 appointment locations nearest to that postcode

Scenario: Search using an invalid postcode (i.e. one that we can't find)
  When I search for appointment locations near to an invalid postcode
  Then I should be informed that Pension Wise cannot find that postcode

Scenario: Search without entering a postcode
  When I search for appointment locations without entering a postcode
  Then I am told to enter a valid postcode
