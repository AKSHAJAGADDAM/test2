public with sharing class SlowProcessor {
    
    public static String processLargeDataSet(List<String> data) {
        // Simulates some business logic
        Set<String> uniqueValues = new Set<String>();
        
        for (String item : data) {
            uniqueValues.add(item.toUpperCase());
        }
        
        return 'Processed ' + uniqueValues.size() + ' unique items';
    }
    
    public static void performComplexCalculation() {
        // Simulates CPU-intensive work
        Decimal result = 0;
        for (Integer i = 0; i < 10000; i++) {
            result += Math.sqrt(i) * Math.log(i + 1);
        }
    }
    
    @future(callout=true)
    public static void makeExternalCallout(String endpoint) {
        // Simulates an external callout
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        req.setTimeout(120000); // 2 minutes
        
        Http http = new Http();
        try {
            HttpResponse res = http.send(req);
        } catch (Exception e) {
            System.debug('Callout failed: ' + e.getMessage());
        }
    }
}