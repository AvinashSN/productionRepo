public class LeadDataFactory {

    public static List<Lead> generateLeadData(Integer numOfLead)
    {
        List<Lead> lstLead=new List<Lead>();
        for(Integer i=0;i<numOfLead;i++)
        {
            Lead l=new Lead(LastName='test'+i,Company='testCompany'+i,Status='Working - Contacted');
            lstLead.add(l);
        }
        insert lstLead;
        return lstLead;
    }
}