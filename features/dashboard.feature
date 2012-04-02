@wip
Feature: Dashboard

  # Background:
  #   # this only needs to happen once to test the scenario outline
  #   # Given I am user, "jdoe", "jdoe@example.com", "abcd1234"
  #   Given I am signed in as, "ben", "ben@frontofficemedia.com", "fom556"
  #   And I am managing a team

  # @javascript
  Scenario: Management Tabs
    Given I am signed in as, "testuser", "testuser@example.com", "password"
    And I am managing a team
    Then I can navigate the following tabs:
      |Trades      |Offer A Trade                          |
      |Waiver Wire |Waiver Wire                            |
      |Roster      |Review your Roster                     |
      |Game Review |Review Player Performance for Last Week|
