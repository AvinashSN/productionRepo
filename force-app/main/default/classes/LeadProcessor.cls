global class LeadProcessor implements Database.Batchable<sObject>{
    global Integer recordsProcessed = 0;
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id,LeadSource  FROM LEAD'
        );
    }

    global void execute(Database.BatchableContext bc, List<Lead> scope){
        // process each batch of records
        List<Lead> leads = new List<Lead>();
        for (Lead lead : scope) {
              lead.LeadSource='Dreamforce';
            leads.add(lead);
            }
        if(leads.size()>0)
         update leads;
        recordsProcessed=leads.size();
    }    

    global void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Shazam!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, 
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        // call some utility to send email
       // EmailUtils.sendMessage(a, recordsProcessed);
    }    

}