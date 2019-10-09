public class RandomContactFactory {

    public static List<Contact> generateRandomContacts(Integer numOfContact, String lstname)
    {
        List<Contact> contacts=new List<Contact>();
        
        for(Integer i=0;i<numofContact;i++)
        {
            Contact c= new Contact(FirstName='Test'+i,LastName=lstname);
            contacts.add(c);
        }
        return contacts;
    }
    
}