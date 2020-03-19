Feature: Show the Error page
    In order to show the Error page
    As a generic site user
    I want show the page

    Scenario: Show Error page
        Given path '/error'
        Then I show Error page
            And I see the text 'not found'

    Scenario: Show the header
        Given path '/'
        Then I show the site header
        
    Scenario: Show the site menu
        Given path '/'
        Then I show the site menu

    Scenario: Show the site footer
        Given path '/'
        Then I show the site footer