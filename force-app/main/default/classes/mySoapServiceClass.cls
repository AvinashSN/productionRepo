global with sharing class mySoapServiceClass {
    
    webservice static Account getAccount()
    {
        return [Select Id,Name from Account limit 1];
    }

}