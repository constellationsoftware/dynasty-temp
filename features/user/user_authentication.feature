Feature: User Login
    Scenario: User is not registered and attempts to sign in
        Given I do not exist as a user
        When I log in
        Then I should see an invalid login message
            And I should be logged out

    Scenario: User signing in through login page succeeds
        Given I exist as a user
        When I log in
        Then I should be logged in
