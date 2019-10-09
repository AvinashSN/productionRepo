@isTest
public class AddPrimaryContactTest {
    
    @isTest
    public static void testAddPrimaryContact()
    {
        AddPrimaryContactDataFactory.generateAccountData(50,'NY');
        AddPrimaryContactDataFactory.generateAccountData(50,'CA');
         Test.startTest();
         contact c=new contact(lastname='narnaware');
        AddPrimaryContact apc=new AddPrimaryContact(c,'CA');
        System.enqueueJob(apc);
        Test.stopTest();
        List<Contact> lst_Cont=[Select Id from Contact];
        system.assertEquals(50, lst_Cont.size());
        
    }

}