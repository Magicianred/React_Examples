Feature: Show the Who Are page
    In order to show the Who Are page
    As a generic site user
    I want show the page and the links to show single person

    Scenario: Show Who Are page
        Given path '/about/whoare'
        Then I show Who Are page

    Scenario: Show the about section menu
        Given path '/about/whoare'
        Then I show the about section menu
            But I don't see any people details

    Scenario: Show almost one link/button to Person details
        Given path '/about/whoare'
        Then I show almost one link/button to show people details

    Scenario: Click on link/button to Person details
        Given path '/about/whoare'
        Then I click on link/button
            And I show people details