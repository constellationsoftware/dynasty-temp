Feature: Sign in

  @javascript
  Scenario: Sign in successful
    Given I visit the sign in page
    # When I enter my proper credentials, "test@example.com" and "password"
    When I enter my proper credentials, "ben@frontofficemedia.com" and "fom556"
    Then I should be on the landing page

    