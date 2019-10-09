@isTest
private class TestVerifyDate{
    @isTest static void VerifyDateCheckDate() {
        Date DateFirst = Date.today();
        Date DateSecond = DateFirst.addDays(25);
        Date DateThird = DateFirst.addDays(35);
        Date first = VerifyDate.CheckDates(DateFirst,DateSecond );
        Date Second = VerifyDate.CheckDates(DateFirst,DateThird );
        System.assertEquals(DateSecond , first );
        
    }
   
}