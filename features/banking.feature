@wip
Feature: Banking

  # display total users
  # display total leagues
  # display total team owners
  # total issued dynasty dollars
  # total dynasty dollars for sale

  # total team salary commitments
  # display top 20 accounts ? cash or activity

  # currently unused
  # Scenario: Display various and sundry totals
  #   Given a user with the role of fed
  #   When the user visits a stats page
  #   Then the user will see "Total Users"
  #   And the user will see "Total Team Owners"
  #   And the user will see "Total Leagues"
  #   # there's a regex problem here
  #   # And the user will see "Total Dynasty Dollars"
  #   # And the user will see "Total Dynasty Dollars for sale"

  # these are unit tests at this point
  # and can be moved if required
  Scenario: Advance counter object
    Given a "counter" set to 1
    When the "counter" is advanced 1
    Then the "counter" is set to 2

  Scenario: Advance counter object from 9
    Given a "counter" set to 9
    When the "counter" is advanced 1
    Then the "counter" is set to 10
    
  Scenario: Retreat counter object
    Given a "counter" set to 2
    When the "counter" is retreated 1
    Then the "counter" is set to 1
    
  Scenario: Reset counter object
    Given a "counter" set to 1
    When the "counter" is reset
    Then the "counter" is set to 0

  Scenario: Reset counter object from 10
    Given a "counter" set to 10
    When the "counter" is reset
    Then the "counter" is set to 0

  # these test week-by-counter
  Scenario: Reset week counter
    Given a weekly counter
    When it's reset
    Then it returns 0

  Scenario: Advance weekly counter
    Given a weekly counter
    When the counter set to 1
    When the counter is advanced 1
    Then it returns 2

  Scenario: Retreat weekly counter
    Given a weekly counter
    When the counter set to 10
    When the counter is retreated 1
    Then it returns 9

  Scenario: Increment weekly counter
    Given a weekly counter
    When the counter set to 1
    When the counter is incremented
    Then it returns 2

  Scenario: Decrement weekly counter
    Given a weekly counter
    When the counter set to 10
    When the counter is decremented
    Then it returns 9
  
