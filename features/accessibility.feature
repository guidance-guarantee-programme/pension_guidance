@javascript
Feature: Accessibility of pages
  As a customer I want Pension Wise pages to be fully accessible
  so I can navigate the website regardless of my access needs

  Scenario: Homepage of the site is accessible
    When I visit the homepage
    Then the page should be accessible skipping: region

  Scenario Outline: Typical pages of the site are accessible
    When I visit the page <Slug>
    Then the page should be accessible skipping: region page-has-heading-one

    Examples:
      | Slug                     |
      | facebook-landing         |
      | leave-pot-untouched      |
      | tax                      |
      | summary-document/new     |

  Scenario: Location page is accessible
    When I visit a face to face booking location page
    Then the page should be accessible skipping: region

  Scenario: Appointment summary page is accessible
    When I visit the appointment summary page
    Then the page should be accessible skipping: region

  @booking_locations
  Scenario: Slot picker for face to face booking is not accessible while we develop our own slot picker
    When I view the face to face booking form
    Then the page should be accessible excluding ".SlotPicker" skipping: region
