Feature: Calculators
  As a visitor to the website considering the 6 options
  I want to input my own numbers
  So that I can find out what the options mean to me

  Scenario Outline: Load a guide
    When I visit the <Slug> guide
    Then the calculator is displayed

    Examples:
      | Slug                |
      | adjustable-income   |
      | guaranteed-income   |
      | leave-pot-untouched |
      | take-cash-in-chunks |
      | take-whole-pot      |

  @javascript
  Scenario: Estimate a monthly income from a customer's pot that lasts until their life expectancy
    Given I am on the adjustable income guide
    When I input the total value of my pension pot and my age
    Then I should see an income that will last until my life expectancy
    And it explains the values are estimates based on the amount remaining growing at 3% per year

  @javascript
  Scenario: Estimate how long a customer's pot would last with a specified income
    Given I am on the adjustable income guide
    When I input the total value of my pension pot and my age
    And I change the income to another amount
    Then it shows me what age my desired income will last until
    And it shows me a suggested monthly income that will last until an average life expectancy for someone of my age

  @javascript
  Scenario: Estimate how much pot could be worth in the future if left untouched
    Given I am on the leaving your whole pension pot untouched guide
    When I input the total value of my pension pot and how much I could contribute each year
    Then I should see how much my pot could be worth for each of the next 5 years
    And it explains the values are estimates based on growth at 3% per year
    And it explains the values will be affected by inflation and how much my provider charges for managing the pot

  @javascript
  Scenario: Estimate how much tax after taking first chunk
    Given I am on the take cash in chunks guide
    When I input the total value of my pension pot, my income for the year and how much cash I want to take upfront
    Then I should see how much tax I might pay
    And I should see how cash I would get
    And I should see how the remaining value of my pot

  @javascript
  Scenario: Estimate how much my guaranteed income could be
    Given I am on the guaranteed income guide
    When I input the total value of my pension pot, and the age I will retire
    Then I should see how much my tax free lump sum could be
    And I should see how much my guaranteed income could be
