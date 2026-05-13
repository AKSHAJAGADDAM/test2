/**
 * @description Test class for AccountManager to test DML operations.
 */
@isTest
private class AccountManagerTest {

    /**
     * @description Tests the updateAccountDescription method with a successful update.
     */
    @isTest
    static void testUpdateAccountDescription_Success() {
        // 1. **Arrange (Setup Test Data)**
        // All test data must be created within the test method or setup method.
        String originalName = 'Test Account for Update';
        String newDesc = 'Description updated by unit test on ' + System.today();

        // Create and insert a new Account record (this is "mocking" the data)
        Account acc = new Account(Name = originalName, Description = 'Original Description');
        insert acc;

        // 2. **Act (Execute Method)**
        Boolean success = AccountManager.updateAccountDescription(acc.Id, newDesc);

        // 3. **Assert (Verify Results)**
        // Check if the method reported success
        System.assertEquals(true, success, 'The update method should return true on success.');

        // Re-query the database to verify the field value was actually updated.
        // DML operations done in the test method are only visible to the test method.
        Account updatedAcc = [SELECT Id, Name, Description FROM Account WHERE Id = :acc.Id];

        System.assertEquals(newDesc, updatedAcc.Description, 'The Description field should have the new value.');
    }

    /**
     * @description Tests the updateAccountDescription method when invalid data (null) is passed.
     */
    @isTest
    static void testUpdateAccountDescription_InvalidInputs() {
        // 1. **Act & Assert for Null ID**
        Boolean success1 = AccountManager.updateAccountDescription(null, 'Some Description');
        System.assertEquals(false, success1, 'Should return false when Account Id is null.');

        // 2. **Act & Assert for Blank Description**
        Account acc = new Account(Name = 'Temp Acc', Description = 'Old');
        insert acc;
        Boolean success2 = AccountManager.updateAccountDescription(acc.Id, '');
        System.assertEquals(false, success2, 'Should return false when Description is blank.');
    }

    /**
     * @description Tests the updateAccountDescription method when the record ID does not exist.
     */
    @isTest
    static void testUpdateAccountDescription_RecordNotFound() {
        // Use a fake 18-character ID (does not point to any actual record)
        Id fakeId = '001000000000000AAA';

        // **Act & Assert**
        // The method should catch the QueryException and return false.
        Boolean success = AccountManager.updateAccountDescription(fakeId, 'New Desc');
        System.assertEquals(false, success, 'Should return false when the Account ID does not exist.');
    }
}