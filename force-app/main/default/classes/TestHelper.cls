@IsTest
public class TestHelper {
    public static Account makeAccount() {
        Account a = new Account(Name = 'Test');
        insert a;
        return a;
    }
}