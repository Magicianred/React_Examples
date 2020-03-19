Feature: Show the Contact Us page
    In order to show the Contact us page
    As a generic site user
    I want show the page and the form module to send message

    Scenario: Show about page
        Given path '/contact'
        Then I show Contact Us page

    Scenario: Show form module to send message
        Given path '/contact'
        Then I show a send message form
        And a text field for email
        And a text field for name
        And a textarea field for the message
        And a button to send form

    Scenario: Form module cannot send if miss require fields
        Given path '/contact'
        And missing data in fields email, name or message
        And user click the button to send form
        Then the form doesn't send data
        And a message invite the user to complete fields
        