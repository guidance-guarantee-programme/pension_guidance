Feature: Govspeak
  As a content editor
  I want to write articles in govspeak
  So that I don't have to hustle developers

  Scenario: Add article
    When I add an article written in govspeak
    Then the article appears on the website
    And the page title corresponds to the title of the article
