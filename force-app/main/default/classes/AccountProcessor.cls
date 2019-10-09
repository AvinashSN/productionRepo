public class AccountProcessor {
    
    @future
    public static void countContacts(List<Id> recordIds)
    {
        List<Account> accounts = [Select Name, (select Id from Contacts) from Account Where Id IN :recordIds];        
        List<Account> listAccount=new List<Account>();
        for(Account a: accounts)
        {
            List<Contact> s=a.Contacts;
            a.Number_of_Contacts__c=s.size();
            listAccount.add(a);            
        }
        if(listAccount.size()>0)
            update listAccount;
        
    }

}