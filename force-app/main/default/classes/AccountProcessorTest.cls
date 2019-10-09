@isTest
private class AccountProcessorTest {
        
    private static testMethod void testAccountProcessor()
    {
        AccountDataFactory.generateAccountsData(3,4);
        Test.startTest();
        List<Id> acctIds=new List<Id>();
        for(Account a:[Select Id from Account])
        {
            acctIds.add(a.Id);
        }
        AccountProcessor.countContacts(acctIds);
        Test.stopTest();
    }

}