Feature: Govspeak
  As a content editor
  I want to write guides in govspeak
  So that I don't have to hustle developers

  Scenario: Add guide
    When I add a guide written in govspeak
    Then the guide appears on the website
    And the page title corresponds to the title of the guide
