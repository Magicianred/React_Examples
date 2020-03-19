Feature: Allowed the navigation of About Section
    In order to allowed the navigation
    As a generic site user
    I can follow the links to pages About Us, Who Are and Where Are

    Scenario: Go to page About
        Given path '/about'
        Then I show the page About Us

    Scenario: Go to page Who Are
        Given path '/about/whoare'
        Then I show the page Who Are

    Scenario: Go to page Where Are
        Given path '/about/whereare'
        Then I show the page Where Are