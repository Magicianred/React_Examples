Feature: Startup the application
    In order to use the application
    As a generic site user
    I want show the site

    Scenario: Show home page as start page
        Given path '/'
        Then I show home page