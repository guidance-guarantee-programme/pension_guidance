@wip
Feature: Guides
  As a visitor to the website
  I want informative content on the website
  So that I can educate myself about pensions and retirement

  Scenario Outline: Load a guide
    When I visit the <id> guide
    Then the guide exists

  Examples:
    | id                                   |
    | 7_things_to_get_you_started          |
    | check_the_value_of_your_pension_pot  |
    | how_long_your_money_needs_to_last    |
    | how_to_shop_around_for_the_best_deal |
    | know_your_pension_type               |
    | tax_you_pay_on_your_pension          |
