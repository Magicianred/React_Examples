Feature: Show the About Section Menu
    In order to show about section menu and allowed the navigation
    As a generic site user
    I want show the about section menu and the links to navigate

    Scenario: Show About Section Menu
        Given path '/about'
        Then I show the about section menu
            And I show the link to '/about' (about us page)
            And I show the link to '/whoare' (who are page)
            And I show the link to '/whereare' (where are page)