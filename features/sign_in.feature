Feature: Sign in

  @javascript
  Scenario: Sign in successful
    Given I visit the sign in page
    When I enter my proper credentials, "ben@frontofficemedia.com" and "fom556"
    Then I should be on the landing page

  @javascript
  Scenario: Sign in unsuccessful
    Given I visit the sign in page
    When I enter my improper credentials, "test@example.com" and "password"
    Then I should not be on the landing page
