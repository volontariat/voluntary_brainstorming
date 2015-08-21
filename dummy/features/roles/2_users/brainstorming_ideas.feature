@javascript
Feature: Manage brainstorming ideas

  Background:
       
    Given a user named "user"
    And I log in as "user"
    
  Scenario: Create, edit and destroy brainstorming ideas
    Given a brainstorming
    When I go to the brainstorming page
    And I click the new idea link
    And I fill in "Name" with "Dummy idea"
    And I press "Create Idea"
    Then I should see "Successfully saved idea."
    And I should not see "No ideas found." 
    And I should see "Dummy idea"
    When I click the edit link of the first idea
    And I fill in "Name" with "Dummy idea2"
    And I press "Update Idea"
    Then I should see "Successfully saved idea."
    And I should see "Dummy idea2"
    When I click the remove link of the first idea
    Then I should see "No ideas found."