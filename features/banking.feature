Feature: Banking

  # display total users
  # display total leagues
  # display total team owners
  # total issued dynasty dollars
  # total dynasty dollars for sale

  # total team salary commitments
  # display top 20 accounts ? cash or activity

  Scenario: Display various and sundry totals
    Given a user with the role of fed
    When the user visits a stats page
    Then the user will see "Total Users"
    And the user will see "Total Team Owners"
    And the user will see "Total Leagues"
    # there's a regex problem here
    # And the user will see "Total Dynasty Dollars"
    # And the user will see "Total Dynasty Dollars for sale"


  Scenario: Post simple transaction
    Given a user with the role of fed
    When a simple transaction is posted
    Then the ledger stays balanced

  Scenario: Post new team transaction
    Given a user with the role of fed
    When a new team transaction is posted for $250 for team 1
    Then the ledger stays balanced

  Scenario: Post payroll transaction
    Given a user with the role of fed
    When a payroll transaction is posted for $10 for team 1 for week 1
    Then the ledger stays balanced

  Scenario: Post revenue share transaction
    Given a user with the role of fed
    When a revenue share transaction is posted for $10 to team 1
    Then the ledger stays balanced

  Scenario: Post dynasty dollar transfer
    Given a user with the role of fed
    When a dynasty dollar transfer is posted for $10 from team 1 to team 10
    Then the ledger stays balanced

  Scenario: Post dynasty dollar purchase
    Given a user with the role of fed
    When a dynasty dollar purchase is posted for $10 to team 1
    Then the ledger stays balanced


  # Scenario: Display total issued dynasty dollars
  #   Given a user with the role of fed
  #   When the user visits a stats page
  #   Then the user will see "Total Dynasty Dollars"
