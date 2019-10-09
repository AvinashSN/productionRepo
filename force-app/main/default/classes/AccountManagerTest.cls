@isTest
private class AccountManagerTest {
    private static testMethod void testGetAccount(){
        Id recordId = createTestRecord();system.debug(recordId);
        RestRequest request = new RestRequest();
        request.requestUri = 'https://ap6.salesforce.com/services/apexrest/Accounts/'+recordId+'/Contacts';
        system.debug(request.requestUri);
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account thisAccount = AccountManager.getAccount();
        System.assert(thisAccount != null);
        System.assertEquals('Test record', thisAccount.Name);
    }
    static Id createTestRecord(){
         Account TestAcc = new Account(
          Name='Test record');
        insert TestAcc;
        Contact TestCon= new Contact(
        LastName='Test', 
        AccountId = TestAcc.id);
        return TestAcc.Id;
    }
}