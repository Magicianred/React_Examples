Feature: Show the Where Are page
    In order to show the Where Are page
    As a generic site user
    I want show the page and the links to show single place

    Scenario: Show Where Are page
        Given path '/about/whereare'
        Then I show Where Are page

    Scenario: Show the about section menu
        Given path '/about/whereare'
        Then I show the about section menu
        And I don't see any place details

    Scenario: Show almost one link/button to Place details
        Given path '/about/whereare'
        Then I show almost one link/button to show place details

    Scenario: Click on link/button to Place details
        Given path '/about/whereare'
        Then I click on link/button
        And I show place details