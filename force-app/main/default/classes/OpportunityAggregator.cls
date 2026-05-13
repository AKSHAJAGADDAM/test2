/**
 * @description Provides methods to calculate aggregate metrics for Sales data.
 */
public class OpportunityAggregator {

    /**
     * @description Calculates the total amount of all Closed Won Opportunities
     * associated with a given Account.
     * @param accountId The ID of the parent Account.
     * @return The total amount of Closed Won Opportunities, or 0 if none are found.
     */
    public static Decimal getTotalClosedWonAmount(Id accountId) {
        if (accountId == null) {
            return 0;
        }

        // Use the AggregateResult object to capture the results of the aggregate query
        AggregateResult[] results = [
            SELECT SUM(Amount) totalAmount
            FROM Opportunity
            WHERE AccountId = :accountId
            AND StageName = 'Closed Won'
            AND IsClosed = true
        ];

        // The query returns an array of AggregateResult objects.
        // For SUM() without GROUP BY, there will be exactly one result.
        if (results.size() > 0) {
            Object sumValue = results[0].get('totalAmount');

            // Aggregate results can return null if no records match the criteria.
            if (sumValue != null) {
                // Cast the result to Decimal and return it
                return (Decimal)sumValue;
            }
        }

        // Return 0 if no records are found or the sum is null
        return 0;
    }
}