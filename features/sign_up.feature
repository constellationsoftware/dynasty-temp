Feature: Sign up

  @javascript
  Scenario: Sign up successful
    Given I visit the sign up page
    When I enter valid info, "jdoe" and "jdoe@example.com" and "abcd1234"
    Then I should be on the landing page

  # @javascript
  # Scenario Outline: Sign up unsuccessful
  # 
  # Scenario: Sign up unsuccessful
  #   Given I visit the sign up page
  #   When I enter my duplicate info, "jdoe and jdoe@example.com" and "abc1234"
  #   Then I should be on the sign up error page
  # 
  #     |user name|user email|user password|user password confirm|expected outcome|
  #   
    
    # Welcome! You have signed up successfully.
    
    
    # dup user
    # bad email
    # unmatched password
    # bad password ?
    # blank password
    