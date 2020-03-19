Feature: Show a home page
    In order to show a home page
    As a generic site user
    I want show the page and the message to users

    Scenario: Show home page
        Given path '/'
        Then I show home page

    Scenario: Show the header
        Given path '/'
        Then I show the site header
        
    Scenario: Show the site menu
        Given path '/'
        Then I show the site menu

    Scenario: Show the site footer
        Given path '/'
        Then I show the site footer

    Scenario: Show first message to users
        Given path '/'
        Then I show the first message

    Scenario: I press the next button
        Given path '/'
            And I click the button Next
        Then I show the second message