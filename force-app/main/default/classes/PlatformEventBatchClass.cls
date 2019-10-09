global class PlatformEventBatchClass implements Database.Batchable<sObject>, 
Database.Stateful, 
Database.AllowsCallouts, 
Database.RaisesPlatformEvents {
    
    global Database.QueryLocator Start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator('Select Id,Name from Account');
    }
    global void execute (Database.BatchableContext bc, list<sObject> scope){}
    global void finish(Database.BatchableContext bc){}

}