Feature: Categories
  As a visitor to the website
  I want to browse content on the website grouped by category
  So that I can find the information I need

  Scenario: Display category title and heading
    When I visit a category
    Then the page title corresponds to the title of the category
    And the page heading corresponds to the title of the category

  Scenario: Include category meta description
    When I visit a category
    Then the page meta description corresponds to the meta description of the category
