Feature: Customer creates a Booking Request
  As a customer
  I want to request an appointment
  So I can understand my pension options

Scenario: Customer browses an online booking enabled location
  Given a location enabled for online booking
  When I browse for the location
  Then I can book online

Scenario: Customer browses a regular location
  Given no locations are enabled for online booking
  When I browse for the location
  Then I cannot book online

@vcr
Scenario: Customer makes an online Booking Request
  Given a location enabled for online booking
  When I browse for the location
  And I opt to book online
  And I choose a minimum of two available appointment slots
  And I provide my personal details
  And I pass the basic eligibility requirements
  Then my Booking Request is confirmed
