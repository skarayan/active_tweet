Feature: Search Twitter by hash tag
  In order to find relevant links
  As a user
  I want to search the Twitter stream by a hash tag

  Scenario: Search for tweets
    Given that there are at least 100 tweets for the term #hello
    When I search for #hello
    Then I should get 100 tweets

  Scenario: Search with a limit
    Given that there are at least 100 tweets for the term #hello
    When I search for #hello
    And limit to 50 results
    Then I should get 50 tweets

  Scenario: Search for links inside tweets
    Given that there are 20 links and a few tweets associated with the term #hello
    When I search for #hello
    And filter for links
    Then I should get 20 links

  Scenario: Search for unique links inside tweets
    Given that there are 15 unique links out of 20 total associated with the term #hello
    When I search for #hello
    And filter for links
    Then I should get 15 links
