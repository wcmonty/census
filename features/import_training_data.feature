Feature: Import Training Data
  As a developer
  I want to be able to import training data
  In order to classify incomplete data

  Scenario: Import data from a local, valid file
    Given I have a file named "data.json" with the following data:
    """
      {
        "people": [
          {
            "person": {
              "id": 1,
              "height": 5.18,
              "weight": 166.67,
              "gender": "Female"
            }
          }
        ]
      }
    """
    When I import the data from "data.json"
    And I delete the file named "data.json"
    Then there should be the following "person" records:
    | height | weight | gender |
    | 62     | 167    | Female |

  Scenario: Import data from a remote, valid file
    When I import the data from "https://gist.githubusercontent.com/wcmonty/e00b663d38f67fb49175/raw/0ab05fd8c126663ea88dc6fa4af901bfac46cdd8/gender_classifier_training_data.json"
    Then there should be the following "person" records:
    | height | weight | gender |
    | 62     | 167    | Female |
