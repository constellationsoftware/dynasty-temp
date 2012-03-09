Feature: Roles

  # @rack_test 
  # @javascript
  Scenario Outline: Test roles
    Given a user role, "<role>"
    When I visit a user role test page, "<page>"
    Then I should see the status, "<status>"
    
    Examples:
    | role | page | status |

    | user | admin               | fail |
    | user | user                | succeed |
    | user | team_owner          | fail |
    | user | league_founder      | fail |
    | user | league_commissioner | fail |
    | user | banker              | fail |

    | admin | admin               | succeed |
    | admin | user                | succeed |
    | admin | team_owner          | succeed |
    | admin | league_founder      | succeed |
    | admin | league_commissioner | succeed |
    | admin | banker              | succeed |

    | team_owner | admin               | fail |
    | team_owner | user                | succeed |
    | team_owner | team_owner          | succeed |
    | team_owner | league_founder      | fail |
    | team_owner | league_commissioner | fail |
    | team_owner | banker              | fail |

    | league_founder | admin               | fail |
    | league_founder | user                | succeed |
    | league_founder | team_owner          | fail |
    | league_founder | league_founder      | succeed |
    | league_founder | league_commissioner | fail |
    | league_founder | banker              | fail |

    | league_commissioner | admin               | fail |
    | league_commissioner | user                | succeed |
    | league_commissioner | team_owner          | fail |
    | league_commissioner | league_founder      | fail |
    | league_commissioner | league_commissioner | succeed |
    | league_commissioner | banker              | fail |

    | banker | admin               | fail |
    | banker | user                | succeed |
    | banker | team_owner          | fail |
    | banker | league_founder      | fail |
    | banker | league_commissioner | fail |
    | banker | banker              | succeed |
