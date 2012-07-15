Feature: Sign in
  In order to discuss with other members
  A person
  Should be able to view all available rooms

  Scenario: User is not signed up
    Given I am not inside forum
    When I go to the forum path
    Then I see the available rooms
