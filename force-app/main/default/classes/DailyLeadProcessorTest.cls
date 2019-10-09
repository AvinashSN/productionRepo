@isTest
public class DailyLeadProcessorTest {
    
    @isTest
    public static void TestDailyLeadProcessor()
    {
		List<Lead> myLead = LeadDataFactory.generateLeadData(200);
         String CRON_EXP = '0 0 0 15 3 ? 2022';
        Test.startTest();
        String jobId = System.schedule('ScheduledApexTest', CRON_EXP, new DailyLeadProcessor()); 
        Test.stopTest();
        
        List<Lead> testLead=[select id from lead where leadSource='Dreamforce'];
        system.assertEquals(200, testLead.size());
    }
}