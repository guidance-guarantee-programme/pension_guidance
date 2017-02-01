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
