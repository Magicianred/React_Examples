Feature: Show the Contact Confirm page
    In order to show the Contact Confirm page
    As a generic site user
    I want show the page and the data sent

    Scenario: Show contact confirm page
        Given path '/contactconfirm'
        Then I show Contact Confirm page

    Scenario: Show the data sent
        Given path '/contactconfirm'
        Then I show the data sent
            And a text with data for email
            And a text with data for name
            And a text with data for the message
            And a text for the thanking