global class MyBatchWithoutFinish implements Database.Batchable<sObject> {
    String query='Select Id from Account';
    global database.QueryLocator Start(Database.BatchableContext bc)
    {
     return database.getQueryLocator(query) ; 
    }
    global void execute(Database.BatchableContext bc, List<sObject> scope)
    {
        
    }
    global void finish(Database.BatchableContext bc)
    {
    
    }

}