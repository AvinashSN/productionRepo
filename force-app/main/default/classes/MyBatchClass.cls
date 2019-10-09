Global class MyBatchClass implements Database.Batchable<sObject>,Database.Stateful,Database.AllowsCallouts {
	String Query='';
    global Database.QueryLocator start(Database.BatchableContext bc)
    {
        return database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext bc,list<sObject> scope)
    {
        
    }
    global void finish(Database.BatchableContext bc)
    {
        
    }
}