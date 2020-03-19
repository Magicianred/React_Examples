Feature: Show the Footer site
    In order to show the footer
    As a generic site user
    I want show the footer of site

    Scenario: Show Footer site
        Given path '/'
        Then I show the footer of the site
            And I show the text 'This is the footer'