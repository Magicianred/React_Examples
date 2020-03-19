Feature: Allowed the primary navigation of the site
    In order to allowed the navigation of the site
    As a generic site user
    I can follow the links to pages Home, About, Contact, Not Found, Error

    Scenario: Go to page Home page
        Given path '/'
        Then I show the page Home Page

    Scenario: Go to page About
        Given path '/about'
        Then I show the page About

    Scenario: Go to page Contact
        Given path '/contact'
        Then I show the page Contact

    Scenario: Go to page Not Found
        Given path '/notfound'
        Then I show the page Not Found

    Scenario: Go to page Error
        Given path '/error'
        Then I show the page Error