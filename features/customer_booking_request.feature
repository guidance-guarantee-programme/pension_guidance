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

@javascript @booking_locations @time_travel @realtime_availability @pension_providers
Scenario: Pension provider makes a realtime online appointment
  Given a location is enabled for online booking
  And the date is "2018-11-01"
  And the provider visits their landing page
  When I browse for the location "Hackney"
  And I opt to book online
  Then I see the location name "Hackney"
  And I see the pension provider banner
  When I choose the first available realtime slot
  Then I see the pension provider banner
  When I provide my personal details
  And I pass the basic eligibility requirements
  Then I see my one chosen slot
  When I submit my completed Booking Request
  Then my appointment is confirmed

@javascript @booking_locations @time_travel @realtime_availability
Scenario: Customer makes a realtime online appointment
  Given a location is enabled for online booking
  And the date is "2018-11-01"
  When I browse for the location "Hackney"
  And I opt to book online
  Then I see the location name "Hackney"
  When I choose the first available realtime slot
  And I provide my personal details
  And I pass the basic eligibility requirements
  Then I see my one chosen slot
  When I submit my completed Booking Request
  Then my appointment is confirmed

@javascript @booking_locations @time_travel @mock_mailgun
Scenario: Customer makes a mistakes in their email address and gets a suggestions
  Given a location is enabled for online booking
  And the date is "2016-06-17"
  When I browse for the location "Hackney"
  And I opt to book online
  And I choose one available appointment slot
  And I enter an email address with a typo
  Then I see a correction suggestion
  When I enter an invalid email address
  Then I see a warning of an invalid email address

@javascript @booking_locations @time_travel
Scenario: Customer chooses a single slot
  Given a location is enabled for online booking
  And the date is "2016-06-17"
  When I browse for the location "Hackney"
  And I opt to book online
  And I choose one available appointment slot
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
  And I choose one available appointment slot
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
  Then I cannot book online
