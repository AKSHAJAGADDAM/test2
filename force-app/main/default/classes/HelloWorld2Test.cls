/**
 * @description Unit test class for HelloWorld to ensure the greeting is correct.
 */
@isTest
private class HelloWorld2Test {

    /**
     * @description Tests that the getGreeting method returns the correct string.
     */
    @isTest
    static void testGetGreeting() {
        // 1. Arrange (Setup Expected Data)
        String expectedMessage = 'Hello, World2!';

        // 2. Act (Execute the Method)
        // Call the static method directly from the class
        String actualMessage = HelloWorld2.getGreeting();

        // 3. Assert (Verify the Results)
        // System.assertEquals checks if the actual result matches the expected result
        System.assertEquals(expectedMessage, actualMessage, 'The returned message should be "Hello, World2!".');
    }
}