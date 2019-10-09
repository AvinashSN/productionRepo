public class MyBTParentCTRL {
    
    @AuraEnabled
    public static string GetMyValue(String myVal)
    {
        system.debug('===myVal==='+myVal);
        return myVal;
    }

}