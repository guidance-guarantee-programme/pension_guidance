Feature: Customer creates a Booking Request
  As a customer
  I want to request an appointment
  So I can understand my pension options

Scenario: Customer browses an online booking enabled location
  Given a location is enabled for online booking
  When I browse for the location
  Then I can book online

Scenario: Customer browses a regular location
  Given no locations are enabled for online booking
  When I browse for the location
  Then I cannot book online

@javascript @booking_locations @booking_requests @time_travel
Scenario: Customer makes an online Booking Request
  Given a location is enabled for online booking
  And the date is "2016-06-17"
  When I browse for the location
  And I opt to book online
  And I choose three available appointment slots
  And I provide my personal details
  And I pass the basic eligibility requirements
  And I submit my completed Booking Request
  Then my Booking Request is confirmed
