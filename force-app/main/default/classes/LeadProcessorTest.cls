@isTest
private class LeadProcessorTest {

   private static testMethod void testLeadProcessor()
   {
       LeadDataFactory.generateLeadData(200);
       Test.startTest();
       LeadProcessor uca = new LeadProcessor();
       Id batchId = Database.executeBatch(uca);
       Test.stopTest();
   }
}