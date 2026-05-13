@isTest
private class HelloWorldTest {

    /**
     * @description Tests that the getGreeting method returns the correct string.
     */
    @isTest
    static void testGetGreeting() {
        // 1. Arrange (Setup Expected Data)
        String expectedMessage = 'Hello, World!';

        // 2. Act (Execute the Method)
        // Call the static method directly from the class
        String actualMessage = HelloWorld.getGreeting();

        // 3. Assert (Verify the Results)
        // System.assertEquals checks if the actual result matches the expected result
        System.assertEquals(expectedMessage, actualMessage, 'The returned message should be "Hello, World!".');
    }
}