Feature: Customer leaves feedback
  As a Pension Wise analyst
  I want customers to leave feedback
  So we can improve the service

Scenario: Customer leaves feedback
  When I visit the feedback page
  And I leave feedback
  Then I am thanked for my feedback

Scenario: Customer leaves invalid feedback
  When I visit the feedback page
  And I leave invalid feedback
  Then I see error messages

