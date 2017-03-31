Feature: Journey navigation
  As a visitor to the website considering the 6 options
  I want to be able to easily move between pages
  So that I can find the best option for me

  Scenario Outline: Guide navigation
    When I visit the <Slug> guide
    Then next button navigates to <Next path>
    Then previous button navigates to <Previous path>

    Examples:
      | Slug                | Previous path           | Next path            |
      | leave-pot-untouched |                         | /en/guaranteed-income   |
      | guaranteed-income   | /en/leave-pot-untouched | /en/adjustable-income   |
      | adjustable-income   | /en/guaranteed-income   | /en/take-cash-in-chunks |
      | take-cash-in-chunks | /en/adjustable-income   | /en/take-whole-pot      |
      | take-whole-pot      | /en/take-cash-in-chunks | /en/mix-options         |
      | mix-options         | /en/take-whole-pot      |                      |
