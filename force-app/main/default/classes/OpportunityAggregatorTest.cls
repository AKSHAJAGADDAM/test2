/**
 * @description Test class for OpportunityAggregator.
 */
@isTest
private class OpportunityAggregatorTest {

    // Global variables to hold the IDs of the test data created in @testSetup
    static Id testAccountId;

    /**
     * @description Method to set up all test data required by the test methods.
     */
    @testSetup
    static void makeData() {
        // 1. Create a Test Account
        Account acc = new Account(Name = 'Aggregator Test Account');
        insert acc;
        testAccountId = acc.Id;

        // 2. Create Opportunities associated with the Account
        List<Opportunity> oppsToInsert = new List<Opportunity>();

        // Closed Won Opps (Total: 1500.50)
        oppsToInsert.add(new Opportunity(Name = 'Opp 1 - CW', AccountId = testAccountId, StageName = 'Closed Won', Amount = 1000.00, CloseDate = System.today().addDays(30)));
        oppsToInsert.add(new Opportunity(Name = 'Opp 2 - CW', AccountId = testAccountId, StageName = 'Closed Won', Amount = 500.50, CloseDate = System.today().addDays(30)));

        // Opps NOT to be counted (Closed Lost and Open)
        oppsToInsert.add(new Opportunity(Name = 'Opp 3 - CL', AccountId = testAccountId, StageName = 'Closed Lost', Amount = 200.00, CloseDate = System.today().addDays(30)));
        oppsToInsert.add(new Opportunity(Name = 'Opp 4 - Open', AccountId = testAccountId, StageName = 'Prospecting', Amount = 300.00, CloseDate = System.today().addDays(30)));

        insert oppsToInsert;
    }

    /**
     * @description Tests the method with valid data expecting the correct aggregate sum.
     */
    @isTest
    static void testTotalClosedWonAmount_Success() {
        // Expected sum: 1000.00 + 500.50 = 1500.50
        Decimal expectedAmount = 1500.50;

        // Act (Execute Method)
        Decimal actualAmount = OpportunityAggregator.getTotalClosedWonAmount(testAccountId);

        // Assert (Verify Results)
        System.assertEquals(expectedAmount, actualAmount, 'The total closed won amount should be 1500.50.');
    }

    /**
     * @description Tests the method when a non-existent Account ID is passed (no matching Opportunities).
     */
    @isTest
    static void testTotalClosedWonAmount_NoMatchingRecords() {
        // **FIXED:** Create a new Account that has NO Opportunities linked to it.
        Account otherAcc = new Account(Name = 'No Opps Account');
        insert otherAcc;

        // Act (Execute Method)
        Decimal actualAmount = OpportunityAggregator.getTotalClosedWonAmount(otherAcc.Id);

        // Assert (Verify Results)
        // The query should return 0 results, and the method should return 0.
        System.assertEquals(0, actualAmount, 'Amount should be 0 when no closed won opportunities exist for the Account.');
    }

    /**
     * @description Tests the method with a null Account ID input.
     */
    @isTest
    static void testTotalClosedWonAmount_NullId() {
        // Act & Assert
        Decimal actualAmount = OpportunityAggregator.getTotalClosedWonAmount(null);
        System.assertEquals(0, actualAmount, 'Amount should be 0 when Account Id is null.');
    }
}