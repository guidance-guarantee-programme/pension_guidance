Feature: Journey navigation
  As a visitor to the website considering the 6 options
  I want to be able to easily move between pages
  So that I can find the best option for me

  Scenario Outline: Guide navigation
    When I visit the <Slug> guide
    Then next button navigates to <Next path>
    Then previous button navigates to <Previous path>

    Examples:
      | Slug                | Previous path        | Next path            |
      | leave-pot-untouched |                      | /guaranteed-income   |
      | guaranteed-income   | /leave-pot-untouched | /adjustable-income   |
      | adjustable-income   | /guaranteed-income   | /take-cash-in-chunks |
      | take-cash-in-chunks | /adjustable-income   | /take-whole-pot      |
      | take-whole-pot      | /take-cash-in-chunks | /mix-options         |
      | mix-options         | /take-whole-pot      |                      |
