public class ContactAndLeadSearch {
    
    public static List<List<sObject>> searchContactsAndLeads(String searchStr)
    {
        List<List<sObject>> lstSearchRes = [FIND :searchStr IN ALL FIELDS RETURNING Contact(ID,NAME,LASTNAME), Lead(Name) ];
        return lstSearchRes;
    }
}