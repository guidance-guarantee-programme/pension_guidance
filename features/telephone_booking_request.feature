Feature: Customer creates a Telephone Booking
  As a customer
  I want to book a telephone appointment
  So I can understand my pension options

Scenario: Lloyds employee creates a signposted telephone appointment
  Given the customer makes a Lloyds signposting referral
  Then they are show the Lloyds signposting banner

Scenario: TPAS agent creates a 'smarter signposting' telephone appointment
  Given the agent makes a smarter signposting referral
  Then they are redirected to the telephone booking
  And they are shown the signposting banner
  When they are eligible for an appointment
  Then their appointment is created
  And they see a confirmation of their appointment

Scenario: TPAS agent cancels a 'smarter signposting' referral
  Given the agent makes a smarter signposting referral
  Then they are redirected to the telephone booking
  And they are shown the signposting banner
  When they cancel the referral
  Then they are redirected to the telephone booking
  And they are not shown the signposting banner

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
