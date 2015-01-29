Feature: Guides
  As a visitor to the website
  I want informative content on the website
  So that I can educate myself about pensions and retirement

  Scenario Outline: Load a guide
    When I visit the <id> guide
    Then the guide is displayed

  Examples:
    | id                        |
    | 6-things-you-need-to-know |
    | know-your-pension-type    |
    | making-money-last         |
    | pension-pot-value         |
    | shop-around               |
    | tax                       |

  Scenario: Display guide title and heading
    When I visit a guide
    Then the page title corresponds to the title of the guide
    And the page heading corresponds to the title of the guide
