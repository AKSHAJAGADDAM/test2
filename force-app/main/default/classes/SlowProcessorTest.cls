@isTest
private class SlowProcessorTest {
    
    @isTest
    static void testWithIntentionalDelay() {
        Test.startTest();
        
        Long startTime = System.now().getTime();
        Long endTime = startTime + 10000;
        while (System.now().getTime() < endTime) {
            // Busy wait
        }
        
        List<String> testData = new List<String>();
        for (Integer i = 0; i < 100; i++) {
            testData.add('Test Item ' + i);
        }
        
        String result = SlowProcessor.processLargeDataSet(testData);
        
        Test.stopTest();
        
        System.assertNotEquals(null, result);
    }
    
    @isTest
    static void testWithLargeDataQueries() {
        List<Account> accounts = new List<Account>();
        
        for (Integer i = 0; i < 200; i++) {
            accounts.add(new Account(
                Name = 'Test Account ' + i,
                Description = 'Test description ' + i
            ));
        }
        insert accounts;
        
        List<Contact> contacts = new List<Contact>();
        for (Account acc : accounts) {
            for (Integer i = 0; i < 5; i++) {
                contacts.add(new Contact(
                    FirstName = 'Test',
                    LastName = 'Contact ' + i,
                    AccountId = acc.Id
                ));
            }
        }
        insert contacts;
        
        Test.startTest();
        
        List<Account> queriedAccounts = [
            SELECT Id, Name, Description,
                (SELECT Id, FirstName, LastName FROM Contacts)
            FROM Account
            WHERE Name LIKE 'Test Account%'
        ];
        
        for (Account acc : queriedAccounts) {
            for (Contact con : acc.Contacts) {
                SlowProcessor.performComplexCalculation();
            }
        }
        
        Test.stopTest();
        
        System.assertEquals(200, queriedAccounts.size());
    }
    
    @isTest
    static void testCombinedSlowOperations() {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 100; i++) {
            accounts.add(new Account(Name = 'Slow Test ' + i));
        }
        insert accounts;
        
        Test.startTest();
        
        List<Account> results = [SELECT Id, Name FROM Account WHERE Name LIKE '%Slow%'];
        
        for (Integer i = 0; i < 100; i++) {
            SlowProcessor.performComplexCalculation();
        }
        
        Long startTime = System.now().getTime();
        Long endTime = startTime + 8000;
        while (System.now().getTime() < endTime) {
            // Busy wait
        }
        
        Test.stopTest();
        
        System.assert(results.size() > 0);
    }
    
    // Mock class defined INSIDE the test class - this fixes the compile error
    private class MockSlowHttpCallout implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"status":"success"}');
            res.setStatusCode(200);
            
            Long startTime = System.now().getTime();
            Long endTime = startTime + 3000;
            while (System.now().getTime() < endTime) {
                // Busy wait
            }
            
            return res;
        }
    }
}