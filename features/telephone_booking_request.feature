Feature: Customer creates a Telephone Booking
  As a customer
  I want to book a telephone appointment
  So I can understand my pension options

Scenario: Customer without DC pot tries to book a telephone appointment
  Given the customer wants to book a phone appointment
  When they do not have a DC pot
  Then they are told that they are ineligible

Scenario: Customer below minimum age tries to book a telephone appointment
  Given the customer wants to book a phone appointment
  When they are below the minimum age
  Then they are told that they are ineligible

Scenario: Customer books a telephone appointment but the slot becomes unavailable
  Given the customer wants to book a phone appointment
  When the slot becomes unavailable while they are filling in their details
  And they choose another time slot
  Then their appointment is created
  And they see a confirmation of their appointment

Scenario: Eligible customer books a telephone appointment
  Given the customer wants to book a phone appointment
  When they are eligible for an appointment
  Then their appointment is created
  And they see a confirmation of their appointment

Scenario: Slots for a particular day are taken during the attempted booking
    Given the customer wants to book a phone appointment
    When they choose a date after the slots on that day have been taken
    Then they are told to choose another day

@pension_providers
Scenario: Tracking a final-nudge appointment
  Given a pension provider has visited via their landing page
  When they attempt to place an appointment
  Then they see the pension provider banner
