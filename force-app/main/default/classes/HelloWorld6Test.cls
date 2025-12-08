@IsTest
private class HelloWorld6Test {

    @IsTest
    static void testSayHello6() {
        // Test setup is minimal since the method is simple and static.

        // **Call the method being tested**
        // Since sayHello5 is a static method, we call it using the class name.
        System.debug('--- Starting testSayHello6 execution ---');
        HelloWorld6.sayHello6();
        System.debug('--- Completed testSayHello6 execution ---');

        // **Assertions (Optional but good practice):**
        // For a method that only executes System.debug, a common check is 
        // to assert that the execution finished without throwing an exception.
        // We can use System.assert(true) to confirm the code path was reached 
        // and execution completed successfully.
        System.assert(true, 'The sayHello6 method should execute without errors.');

        // Note: You *cannot* directly test or assert the content of System.debug() 
        // messages in an Apex unit test.
    }
}