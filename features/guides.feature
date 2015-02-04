Feature: Guides
  As a visitor to the website
  I want informative content on the website
  So that I can educate myself about pensions and retirement

  Scenario Outline: Load a guide
    When I visit the <Slug> guide
    Then the guide is displayed

  Examples:
    | Slug                      |
    | 6-things-you-need-to-know |
    | benefits                  |
    | complaints                |
    | divorce                   |
    | living-abroad             |
    | making-money-last         |
    | pension-complaints        |
    | pension-pot-options       |
    | pension-pot-value         |
    | pension-types             |
    | scams                     |
    | shop-around               |
    | tax                       |
    | work-out-income           |

  Scenario: Display guide title and heading
    When I visit a guide
    Then the page title corresponds to the title of the guide
    And the page heading corresponds to the title of the guide

  Scenario: Include guide meta description
    When I visit a guide
    Then the page meta description corresponds to the meta description of the guide

  Scenario: Display related content
    When I visit a guide
    Then I can navigate to related content

  Scenario: Display a guide that belongs to a journey
    When I visit a guide that is part of '6 things you need to know'
    Then I can navigate to the next step in that journey
    And I can navigate to the previous step in that journey
    Then I can navigate directly to other steps in that journey
    And I can navigate to content related to the journey
    And the current guide is highlighted
