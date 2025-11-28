/**
 * @description Test class for StringUtility to ensure string validation logic is correct.
 */
@isTest
private class StringUtilityTest {

    /**
     * @description Tests the method with a valid email format (Expected to pass).
     */
    @isTest
    static void testValidEmail() {
        // 1. Arrange (Setup Test Data)
        String validEmail = 'testuser@example.com';
        Boolean expectedResult = true;

        // 2. Act (Execute Method)
        Boolean actualResult = StringUtility.isValidEmailBasic(validEmail);

        // 3. Assert (Verify Results)
        System.assertEquals(expectedResult, actualResult, 'The method should return true for a valid email format.');
    }

    /**
     * @description Tests the method with an invalid format (missing '@' or '.') (Expected to pass).
     */
    @isTest
    static void testInvalidEmail() {
        // Test Case 1: Missing '@'
        Boolean result1 = StringUtility.isValidEmailBasic('testuser.com');
        System.assertEquals(false, result1, 'Should return false when missing @.');

        // Test Case 2: Missing '.'
        Boolean result2 = StringUtility.isValidEmailBasic('testuser@example');
        System.assertEquals(false, result2, 'Should return false when missing dot.');
    }

    /**
     * @description Tests the method with null or empty input (Expected to pass).
     */
    @isTest
    static void testBlankOrNullInput() {
        // Test Case 1: Null input
        Boolean result1 = StringUtility.isValidEmailBasic(null);
        System.assertEquals(false, result1, 'Should return false when input is null.');

        // Test Case 2: Empty string
        Boolean result2 = StringUtility.isValidEmailBasic('');
        System.assertEquals(false, result2, 'Should return false when input is an empty string.');

        // Test Case 3: Blank string (spaces)
        Boolean result3 = StringUtility.isValidEmailBasic('   ');
        System.assertEquals(false, result3, 'Should return false when input is a blank string.');
    }
}