Feature: movies should appear in alphabetical order, not added order

Scenario: view movie list after adding movie (declarative and DRY)

  Given I have added "Zorro" with rating "PG-13"
  And   I have added "Apocalypse Now" with rating "R"
  Then  I should see "Apocalypse Now" before "Zorro" on the RottenPotatoes home page sorted by title
