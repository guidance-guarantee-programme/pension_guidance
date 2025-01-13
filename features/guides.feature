Feature: Guides
  As a visitor to the website
  I want informative content on the website
  So that I can educate myself about pensions and retirement

  Scenario Outline: Load a guide
    When I visit the <Slug> guide
    Then the guide is displayed

    Examples:
      | Slug                   |
      | adjustable-income      |
      | benefits               |
      | book                   |
      | care-costs             |
      | cookies                |
      | debt                   |
      | divorce                |
      | financial-advice       |
      | guaranteed-income      |
      | ill-health             |
      | leave-pot-untouched    |
      | living-abroad          |
      | making-money-last      |
      | mix-options            |
      | pension-complaints     |
      | pension-pot-options    |
      | pension-pot-value      |
      | pension-statements     |
      | pension-recycling      |
      | pension-types          |
      | scams                  |
      | shop-around            |
      | state-pension          |
      | after-your-appointment |
      | take-cash-in-chunks    |
      | take-whole-pot         |
      | tax                    |
      | transfer-pension       |
      | when-you-die           |
      | work-out-income        |
      | your-pension-before-55 |

  Scenario: Display guide title and heading
    When I visit a guide
    Then the page title corresponds to the title of the guide
    And the page heading corresponds to the title of the guide

  Scenario: Include guide meta description
    When I visit a guide
    Then the page meta description corresponds to the meta description of the guide

  Scenario: Navigate directly to each option from the options guide
    When I visit the pension-pot-options guide
    Then I can navigate to each option available to me
