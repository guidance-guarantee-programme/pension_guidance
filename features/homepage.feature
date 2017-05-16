Feature: Homepage
  As a first time visitor to the website
  I want to see some basic information about Pension Guidance
  So that I can decide whether and how to engage further

  Scenario: Visit homepage
    When I visit the homepage
    Then I see information about the service
    And I see a link to book a free appointment
