Feature: Using the Admin Auctions panel
  As an admin of the Micropurchase system
  I want to be able to modify existing auctions in an admin
  So that I will be able to more efficiently work with the system

  Scenario: Visiting the auctions index and a single auction
    Given I am an administrator
    And there is an open auction
    When I sign in
    And I visit the auctions admin page
    Then I will not see a warning I must be an admin
    And I should see the auction

    When I click on the auction's title
    Then I should see the winning bid for the auction
    And I should see the auction's description

  Scenario: Adding a multi-bid auction
    Given I am an administrator
    When I sign in
    And I visit the auctions admin page
    And I click on the "Create a new auction" link
    And I edit the new auction form
    And I click to create an auction
    Then I should see the auction's title
    And I should see the auction's deadline

  Scenario: Creating an invalid auction
    Given I am an administrator
    And I sign in
    And I visit the auctions admin page
    When I click on the "Create a new auction" link
    And I edit the new auction form
    And I set the auction start price to $24000
    And I click to create an auction
    Then I should see an alert that
      """
      You do not have permission to publish auctions with a start price over $3500
      """

  Scenario: Updating an auction
    Given I am an administrator
    And there is an open auction
    When I sign in
    And I visit the auctions admin page

    When I click to edit the auction
    Then I should be able to edit the existing auction form

    When I click on the "Update" button
    Then I expect my auction changes to have been saved

    When I click on the auction's title
    Then I should see new content on the page

  Scenario: I get a CSV file containing Sam.gov data for the winning vendor
    Given I am an administrator
    And I sign in
    And there is a closed auction
    And the winning bidder has a valid DUNS number
    When I visit the admin auction page for that auction
    And I click on the link to generate a winning bidder CSV report
    Then the file should contain the following data from Sam.gov:
      """
      13GG Vendor Name,
      13JJ Vendor Address Line 1,
      13KK Vendor Address Line 2,
      13LL Vendor Address Line 3,
      13MM Vendor Address City,
      13NN Vendor Address State,
      13PP Vendor Zip Code,
      13QQ Vendor Country Code,
      13RR Vendor Phone Number,
      13SS Vendor Fax Number,
      2B Effective Date,
      2C Current Completion Date,
      3A Base And All Options Value,
      3B Base And Exercised Options Value,
      3C Action Obligation,
      6M Description of Requirement,
      6N Purchase Card as Payment Method,
      6R National Interest Action,
      9A DUNS Number,
      9B Contractor Name from Contract,
      10J Commercial Item Test Program,
      10M Solicitation Procedures,
      Sudol, Brendan,
      4301 N Henderson Rd Apt 408,
      Arlington,
      VA,
      222032511,
      USA,
      5404218332,
      Y,
      None,
      N,
      SP1
      """
