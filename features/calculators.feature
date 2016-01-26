Feature: Calculators
  As a visitor to the website considering the 6 options
  I want to input my own numbers
  So that I can find out what the options mean to me

  Scenario Outline: Load a guide
    When I visit the <Slug> guide
    Then the calculator is displayed

    Examples:
      | Slug           |
      | take-whole-pot |

  @wip
  Scenario: Estimate how much pot could be worth in the future if left untouched
    Given I am on the leaving your whole pension pot untouched guide
    When I input the total value of my pension pot and how much I could contribute each year
    Then I should see how much my pot could be worth for each of the next 5 years
    And it explains the values are estimates based on growth at 3% per year
    And it explains the values will be affected by inflation and how much my provider charges for managing the pot
    
  Scenario: Estimate how much my pension pot could be worth in the future if left untouched
    Given I have <principleValue> as my starting amount
    And I am paying <monthlyContributions> as my monthly contribution
    And the annual interest rate is <interestRate>
    And interest gets paid <compoundFrequency> times per year
    When the pot is untouched for <time> years
    Then the total amount is <futureValue>
    
  Examples:
      | principleValue  | monthlyContributions  | interestRate  | compoundFrequency | time  | futureValue |
      | 25000           | 150                   | 3.00          | 12                | 5     | 38737       |
      | 35000           | 0                     | 3.00          | 12                | 5     |             |
      | 125000          | 100                   | 3.00          | 12                | 7     |             |
      | 225000          | 0                     | 3.00          | 12                | 7     |             |

