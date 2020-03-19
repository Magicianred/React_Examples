Feature: Show the About Us page
    In order to show the About us page
    As a generic site user
    I want show the page and the links to go in subsections

    Scenario: Show about page
        Given path '/about'
        Then I show About page

    Scenario: Show the about section menu
        Given path '/about'
        Then I show the about section menu

    Scenario: Show link to Who Are page
        Given path '/about'
        Then I show the link to '/about/whoare'

    Scenario: Show link to Where Are page
        Given path '/about'
        Then I show the link to '/about/whereare'