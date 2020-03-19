Feature: Show the Header site
    In order to show site logo and allowed the navigation
    As a generic site user
    I want show the header of site and the links to navigate

    Scenario: Show Header site
        Given path '/'
        Then I show the header of the site
        And I show the site logo
        And I show the link to '/' (home page)
        And I show the link to '/about' (about us page)
        And I show the link to '/contact' (contact us page)
        And I show the link to '/abcdefg' (an incorrect path to go NotFound page)
        And I show the link to '/docs' (documentazione)