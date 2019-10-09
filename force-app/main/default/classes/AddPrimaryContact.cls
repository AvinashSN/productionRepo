public class AddPrimaryContact implements Queueable{
    
    private Contact c;
    private String stateName;
    
    public  AddPrimaryContact(Contact records, String stateAbbr)
    {
        this.c = records;
        this.stateName = stateAbbr;
    }
    
    public void execute(QueueableContext context)
    {
        List<Account> lstAcct=[Select Id from Account where BillingState =: this.stateName limit 200];
        List<Contact> lstContact=new List<Contact>();
        
        for(Account a:lstAcct)
        {
            contact c=new contact();
            c= this.c.clone(false,false,false);
            c.AccountId=a.Id;
            lstContact.add(c);
        }
        insert lstContact;
        system.debug('lstContact===>'+lstContact);
    }

}