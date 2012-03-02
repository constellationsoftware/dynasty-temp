Feature: Team Banking

  These are team level banking features
  
  # initial balance
  # 
  # 
  
  Scenario: See team account balance
    Given I own a team
    When I visit team stats page
    Then I should see "Account Balance"

# wait on this    
  # Scenario: Successfully add money to my account
  #   Given I own a team
  #   When I deposit $10 to my account
  #   Then I should see my account increase $10
  #   And I should see issued dynasty dollars increase $10