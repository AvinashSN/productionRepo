public class AddPrimaryContactDataFactory {
    
    public static void generateAccountData(Integer numberofAccount, String billingState)
    {
        List<Account> lstAcct=new List<Account>();
        for(Integer i=0;i<numberofAccount;i++)
        {
            Account a=new Account();
            a.name='Test'+billingState+i;
            a.BillingState=billingState;
            lstAcct.add(a);
        }
        if(lstAcct.size()>0)
        insert lstAcct;
        system.debug('lstAcct===>'+lstAcct);
    }

}