public class DailyLeadProcessor implements Schedulable  {

    public void execute(SchedulableContext ctx) {
        List<Lead> lstlead=[Select Id,LeadSource from Lead where LeadSource=null limit 200];
        List<Lead> updateLeadlst=new List<Lead>();
        for(Lead l: lstLead)
        {
            l.LeadSource='Dreamforce';
            updateLeadlst.add(l);
        }
        if(updateLeadlst.size()>0)
        update updateLeadlst;
    }
}