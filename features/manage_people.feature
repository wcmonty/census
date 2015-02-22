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