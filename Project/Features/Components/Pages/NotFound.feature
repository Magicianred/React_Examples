Feature: Show the Not Found page
    In order to show the Not Found page
    As a generic site user
    I want show the page

    Scenario: Show Not Found page
        Given path '/notfound'
        Then I show Not Found page
        And I see the text 'not found'

    Scenario: Show Not Found page
        Given path '/invalidpath'
        Then I show Not Found page
        And I see the text 'not found'

    Scenario: Show Not Found page
        Given path '/incorrectpath'
        Then I show Not Found page
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