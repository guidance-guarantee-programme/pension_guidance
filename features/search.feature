@vcr
Feature: Searching
  As a user visiting the website
  I want to search by keyword
  So that I can find the content I am looking for

  Scenario: The search box is visible in the header
    When I visit the home page
    Then I should see the search box

  Scenario: Search can be performed
    Given I am on the home page
    When I search for something relevant
    Then I should see search results

  Scenario: A relevant message is displayed when no results are found
    Given I am on the home page
    When I search for something irrelevant
    Then I should see no search results
    And I should prompted to try another search term

  Scenario: A relevant message is displayed if a search is performed with no keywords
    Given I am on the home page
    When I submit a search with no query
    Then I should see the search page

  Scenario: Browsing paginated results
    When I am on the home page
    And I search for a query that returns two pages of results
    Then I should see what the next page number is
    And I should see the "Next" button
    And I should not see the "Previous" button
    When I go to the next page of results
    Then I should see what the previous page number is
    And I should not see the "Next" button
    And I should see the "Previous" button

  Scenario: Manually browsing past the last page of results
    When I am on the home page
    And I go to the third page of a query that returns two pages of results
    Then I should be on page 2 of 2 of the search results
