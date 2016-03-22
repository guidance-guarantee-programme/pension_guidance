Feature: Digital appointment summaries
  As a customer who has already had a Pension Wise phone appointment
  I want to be able to see a digital version of the summary document I have been sent in the post
  So that I can understand the options discussed and my next steps

  Scenario: See the link in the footer
    When I visit the homepage
    Then I see a link to the digital appointment summary page

  Scenario Outline: Generate summaries for both appointment types
    When I visit the digital appointment summary generator
    And I select <age> as my age range
    And I view the appointment summary
    Then I see a <age> type appointment summary

    Examples:
      | age        |
      | 55 or over |
      | 50 to 54   |

  Scenario Outline: Extra information can be included
    Given I want extra information about "<topic>"
    When I select 55 or over as my age range
    And I view the appointment summary
    Then it should include extra information about "<topic>"

    Examples:
      | topic                                   |
      | How my pension effects my benefits      |
      | Getting help with debt                  |
      | Taking my pension if I have ill health  |
      | Final salary or career average pensions |

  Scenario: Save as PDF
    Given I generate a valid appointment summary
    When I click the Save button
    Then I should be presented with a PDF version

  Scenario: Print summary
    Given I generate a valid appointment summary
    When I click the Print button
    Then I should see a print friendly document
