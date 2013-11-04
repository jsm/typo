Feature: Merge Articles
  As a blog administrator
  In order to keep down the amount of redundant content
  I want to be able to merge articles together

  Background:
    Given the blog is set up
    And "publisher" is a publisher
    And "author1" is a contributor
    And "author2" is a contributor
    And "Article A" is published by "author1" with the following text:
    """
    This is Article A
    I'm talking about Penguins
    Here's some more info about Penguins
    """
    And "Article B" is published by "author2" with the following text:
    """
    This is Article B
    I'm talking about Penguins
    Here's some more info about Penguins
    """
    And a guest comments on "Article A" with "Comment A"
    And a guest comments on "Article B" with "Comment B"

  Scenario: When articles are merged, the merged article should contain the text of both previous articles
    Given I am logged into the admin panel
    And I am editing "Article A"
    Then I should see element with id "merge-article"
    When I enter "Article B"'s ID into "merge-article-id"
    And I press "Merge Articles"
    Then I should be editing "Article A"
    And "Article A" should have a title of "Article A"
    And "Article A" should have an author of "author1"
    And "Article A" should have 2 comments
    And "Article A" should have the following body:
    """
    This is Article A
    I'm talking about Penguins
    Here's some more info about Penguins
    This is Article B
    """

  Scenario: A non-admin cannot merge two articles
    Given I am logged in as "publisher"
    And I am editing "Article A"
    Then I should not see element with id "merge-article"
