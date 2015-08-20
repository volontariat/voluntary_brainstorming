@javascript
Feature: Manage brainstormings

  Background:
       
    Given a user named "user"
    And I log in as "user"
    
  Scenario: Create, edit and destroy brainstormings
    And I go to the new brainstorming page
    And I fill in "Name" with "Dummy"
    And I fill in "Text" with "Text"
    And I press "Create Brainstorming"
    And wait 2 seconds
    Then I should see "Successfully saved brainstorming."
    And I should see "Dummy"
    When I go to the brainstorming edit page
    And I fill in "Name" with "Dummy2"
    And I press "Update Brainstorming"
    And wait 2 seconds
    Then I should see "Successfully saved brainstorming."
    And I should see "Dummy2"
    When I go to the user brainstormings page
    And delete the first brainstorming
    Then I should see "No brainstormings found."