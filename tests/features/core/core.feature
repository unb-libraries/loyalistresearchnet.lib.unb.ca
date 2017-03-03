# Basic functionality testing.
# Ref : phase2/behat-suite
# http://behat-drupal-extension.readthedocs.io/en/3.1/drupalapi.htm

@api
Feature: Core
  In order to know the website is running
  As a website user
  I need to be able to view the site title and login

  @api
    Scenario: Run cron
      Given I am logged in as a user with the "administrator" role
      When I run cron
      And am on "admin/reports/dblog"
      Then I should see the link "Cron run completed"

    Scenario: Create users
      Given users:
      | name     | mail            | status |
      | Joe User | joe@example.com | 1      |
      And I am logged in as a user with the "administrator" role
      When I visit "admin/people"
      Then I should see the link "Joe User"

    Scenario: Login as a user created during this scenario
      Given users:
      | name      | status |
      | Test user |      1 |
      When I am logged in as "Test user"
      And I visit "user"
      Then I should see the heading "Test user"

    Scenario: Create a term
      Given I am logged in as a user with the "administrator" role
      When I am viewing a "tags" term with the name "My tag"
      Then I should see the heading "My tag"

    Scenario: Create many terms
      Given "tags" terms:
      | name    |
      | Tag one |
      | Tag two |
      And I am logged in as a user with the "administrator" role
      When I go to "admin/structure/taxonomy/manage/tags/overview"
      Then I should see "Tag one"
      And I should see "Tag two"

      Scenario: Visit Home
        Given I am logged in as a user with the "administrator" role
        When I visit "node/15"
        Then I should see the heading "The Loyalist Collection at UNB"
        And I should see the link "The Marianne Grey Otty Database"

      Scenario: Visit Recent Publications
        Given I am logged in as a user with the "administrator" role
        When I visit "node/16"
        Then I should see the heading "Recent Publications"
        And I should see the link "Oxford Bibliographies Online `Atlantic' Series"

      Scenario: Visit Primary Sources
        Given I am logged in as a user with the "administrator" role
        When I visit "node/39"
        Then I should see the heading "Online Primary Sources"
        And I should see the link "Archives and Repositories"

      Scenario: Visit Secondary Sources
        Given I am logged in as a user with the "administrator" role
        When I visit "node/28"
        Then I should see the heading "Secondary Sources"
        And I should see the link "Loyalists in Prince Edward Island"

      Scenario: Visit Researchers
        Given I am logged in as a user with the "administrator" role
        When I visit "node/5"
        Then I should see the heading "Researchers"
        And I should see the link "Kelly K. Chaves"

      Scenario: Visit Contact
        Given I am logged in as a user with the "administrator" role
        When I visit "node/12"
        Then I should see the heading "Contact the LRN"
