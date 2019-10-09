public class MDController {
    
    @AuraEnabled
    public static String SaveContact(String email,String Lastname)
    {  String res='';
      		system.debug('===con==='+email);
            system.debug('===lstObjCon==='+Lastname);
        try{
		List<Contact> lstobjCon=new List<Contact>();
        Contact con=new contact();
		con.LastName=Lastname;
        con.email =email;
        lstObjCon.add(con);
              system.debug('===con==='+con);
            system.debug('===lstObjCon==='+lstObjCon);
        Insert lstobjCon;
        
            res='Success';
        }
        catch(exception ex)
        {
            res=ex.getMessage();
        }
     system.debug('===res==='+res);
       return res;
        
    }

}