/**
 * @description Provides methods to manage Account records.
 */
public class AccountManager {

    /**
     * @description Updates the Description field for a single Account record.
     * @param accountId The ID of the Account to update.
     * @param newDescription The new value for the Description field.
     * @return true if the update was successful, false otherwise.
     */
    public static Boolean updateAccountDescription(Id accountId, String newDescription) {
        if (accountId == null || String.isBlank(newDescription)) {
            return false;
        }

        try {
            // 1. Query the record
            // We use FOR UPDATE to lock the record until the transaction is complete,
            // which is good practice before updating critical data.
            Account acc = [
                SELECT Id, Name, Description
                FROM Account
                WHERE Id = :accountId
                LIMIT 1
                FOR UPDATE
            ];

            // 2. Modify the field
            acc.Description = newDescription;

            // 3. Perform the DML operation
            update acc;

            return true;

        } catch (DmlException e) {
            // Handle DML errors (e.g., validation rule failure, field truncation)
            System.debug('DML Error updating Account: ' + e.getMessage());
            return false;
        } catch (QueryException e) {
            // Handle errors if the record is not found
            System.debug('Query Error: Account not found for ID ' + accountId);
            return false;
        }
    }
}