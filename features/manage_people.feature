Feature: Manage People
  As a user
  I want to be able to manage training data
  In order to modify or add to the training data

  Scenario: Adding a person
    Given I visit "/people"
    And I click on the "New Person" button
    And I fill out the form with the following information:
    | gender | height | weight |
    | female | 60     | 135    |
    When I click on the "Submit" button
    Then I should see a success message

  Scenario Outline: Adding invalid people
    Given I visit "/people"
    And I click on the "New Person" button
    And I select the <gender> from "person[gender]"
    And I fill the "person[height]" field with <height>
    And I fill the "person[weight]" field with <weight>
    When I click on the "Submit" button
    Then I should not see a success message
  Examples:
    | gender | height | weight | notes |
    | female |        | 135    | no height |
    | female |        |        | no height or weight |
    | female | 60     |        | no weight           |
    | female | -1     | 135    | negative weight     |
    | female | 60     | -1     | negative height     |
    | female | -1     | -1     | negative height and weight |
    | male |        | 135    | no height |
    | male |        |        | no height or weight |
    | male | 60     |        | no weight           |
    | male | -1     | 135    | negative weight     |
    | male | 60     | -1     | negative height     |
    | male | -1     | -1     | negative height and weight |

  Scenario: Deleting a person
    Given I have the following "person" records:
      | id | gender | height | weight |
      | 1  | female | 60     | 135    |
      | 2  | male   | 60     | 135    |
    When I visit "/people"
    And I click on the "destroy_1" link
    Then the page should not have the word "female"
    And the page should have the word "male"

  Scenario: Editing a person
    Given I have the following "person" records:
      | id | gender | height | weight |
      | 1  | female | 60     | 135    |
    When I visit "/people"
    And I click on the "edit_1" link
    And I select the male from "person[gender]"
    And I fill the "person[height]" field with 72
    And I fill the "person[weight]" field with 165
    And I click on the "Submit" button
    And I visit "/people"
    Then the page should have the word "male"
    And the page should have the word "72"
    And the page should have the word "165"
    And the page should not have the word "female"
    And the page should not have the word "60"
    And the page should not have the word "135"
