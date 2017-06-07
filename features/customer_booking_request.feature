Feature: Customer creates a Booking Request
  As a customer
  I want to request an appointment
  So I can understand my pension options

Scenario: Customer browses an online booking enabled location
  Given a location is enabled for online booking
  When I browse for the location "Hackney"
  Then I can book online

Scenario: Customer browses a regular location
  Given no locations are enabled for online booking
  When I browse for the location "Hackney"
  Then I cannot book online

@javascript @booking_locations @time_travel
Scenario: Customer makes an online Booking Request
  Given a location is enabled for online booking
  And the date is "2016-06-17"
  When I browse for the location "Hackney"
  And I opt to book online
  Then I see the location name "Hackney"
  When I choose three available appointment slots
  And I provide my personal details
  And I pass the basic eligibility requirements
  And I submit my completed Booking Request
  Then my Booking Request is confirmed

@javascript @booking_locations @time_travel
Scenario: Customer navigates between Booking Request steps
  Given a location is enabled for online booking
  And the date is "2016-06-17"
  When I browse for the location "Hackney"
  And I opt to book online
  Then I see the location name "Hackney"
  When I choose three available appointment slots
  And I go back
  Then my chosen slots persist
  When I go forward
  And I provide my personal details
  And I pass the basic eligibility requirements
  And I submit my completed Booking Request
  Then my Booking Request is confirmed

@javascript @booking_locations @time_travel @mock_mailgun
Scenario: Customer makes a mistakes in their email address and gets a suggestions
  Given a location is enabled for online booking
  And the date is "2016-06-17"
  When I browse for the location "Hackney"
  And I opt to book online
  And I choose three available appointment slots
  And I enter an email address with a typo
  Then I see a correction suggestion
  When I enter an invalid email address
  Then I see a warning of an invalid email address

@javascript @booking_locations @time_travel
Scenario: Customer attempts an invalid Booking Request
  Given a location is enabled for online booking
  And the date is "2016-06-17"
  When I browse for the location "Hackney"
  And I opt to book online
  And I choose one available appointment slot
  Then I am told to choose further slots
  When I choose a further two appointment slots
  Then I progress to the personal details step
  When I pass the basic eligibility requirements
  And I submit my incomplete Booking Request
  Then I am told to complete my personal details

@javascript @booking_locations @time_travel
Scenario: Customer is ineligible for guidance
  Given a location is enabled for online booking
  And the date is "2016-06-17"
  When I browse for the location "Hackney"
  And I opt to book online
  And I choose three available appointment slots
  And I provide my personal details
  And I provide ineligible details
  When I submit my completed Booking Request
  Then I am told I am ineligible for guidance

@javascript @booking_locations @time_travel
Scenario: Customer leaves inline feedback
  Given a location is enabled for online booking
  And the date is "2016-06-17"
  When I browse for the location "Hackney"
  And I opt to book online
  When I complete the inline feedback
  Then I see my feedback was sent

@booking_locations @no_availability
Scenario: Customer attempts to book a location with no availability
  Given a location is enabled for online booking
  When I browse for the location "Hackney"
  And I opt to book online
  Then I see the location name "Hackney"
  And I see a message to phone for availability
