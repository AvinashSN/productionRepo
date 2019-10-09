@RestResource(urlMapping='/Accounts/*/contacts')
global class AccountManager {
    @HttpGet
    global static Account getAccount(){
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/')-18,
          request.requestURI.lastIndexOf('/'));
        system.debug(request.requestURI +'  '+accountId);
        Account Result = [SELECT Id, Name, (SELECT Id, Name From Contacts) From Account Where Id =: accountId];
        system.debug('Result is :' +Result);
        Return Result;
    }
}