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
      | 35000           | 0                     | 3.00          | 12                | 5     | 40656.59    |
      | 125000          | 100                   | 3.00          | 12                | 7     | 163503.54   |
      | 225000          | 0                     | 3.00          | 12                | 7     | 277504.83   |

