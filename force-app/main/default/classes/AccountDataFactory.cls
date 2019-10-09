public class AccountDataFactory { 

    public static List<Account> generateAccountsData(Integer numOfAccount, Integer noOfContact)
    {
        List<Account> accounts=new List<Account>();        
        for(Integer i=0;i<numOfAccount;i++)
        {
            Account a= new Account(Name='TestAccount'+i);
            accounts.add(a);
        }
        insert accounts;
        List<Contact> contacts=new List<Contact>();
        for(Integer j=0;j<accounts.size();j++)
        {
            for(Integer k=0;k<noOfContact;k++)
            {
                Contact c=new Contact(LastName='TestContact'+k,AccountId=accounts[j].Id);
                contacts.add(c);
            }
        }
        insert contacts;
        
        return accounts;
        
    }
    


}