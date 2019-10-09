global class AccountBatchClass implements Database.Batchable<sObject>
{
    //Comments for testing VS Code
    //testsfdx 
    global String query ='Select Id, Name from Account';
    global Database.QueryLocator Start(Database.BatchableContext bc)
    {
      return Database.getQueryLocator(query) ;  
    }
    global void execute(Database.BatchableContext bc, List<sObject> scope)
    {
        List<Account> lstAct=new List<Account>();
        for(sObject obj : scope)
        {
            Account objAcct=new Account();
            objAcct.Id=(Id)obj.get('Id');
            objAcct.Name=(String)obj.get('Name');
            
            if(objAcct.Name == 'Avinash')
            {
                objAcct.AccountNumber ='123456';
                lstAct.add(objAcct);
            }
        }
        if(lstAct.size()>0)
        {
            update lstAct;
        }
    }
    global void finish(Database.BatchableContext bc)
    {
        AsyncApexJob a=[Select Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email from AsyncApexJob 
                       where Id =: bc.getJobId()];
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        String[] Address=new String[]{a.CreatedBy.Email};
        mail.setToAddresses(Address);
        mail.setSubject('AccountBatchClass'+a.Status);
        mail.setPlainTextBody('AccountBatchClass'+a.TotalJobItems + 'Failure: '+a.NumberOfErrors);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
        
        
    }

}