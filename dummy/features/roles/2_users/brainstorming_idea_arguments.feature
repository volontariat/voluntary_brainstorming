@javascript
Feature: Manage brainstorming idea arguments

  Background:
       
    Given a user named "user"
    And I log in as "user"
    
  Scenario: Create, edit and destroy brainstorming idea argument
    Given a brainstorming
    And a brainstorming idea
    When I go to the brainstorming page
    And I click the new argument link
    And I fill in "Topic" with "Dummy argument"
    And I press "Create Argument"
    #Then I should see an alert telling me that "Successfully saved argument."
    And I should see "Dummy argument"
    And I click the edit link of the first argument
    And I fill in "Topic" with "Dummy argument2"
    And I press "Update Argument"
    Then I should see an alert telling me that "Successfully saved argument."
    And I should see "Dummy argument2"
    And I click the remove link of the first argument
    #Then I should see an alert telling me that "Successfully removed argument."
    And I should not see "Dummy argument2"