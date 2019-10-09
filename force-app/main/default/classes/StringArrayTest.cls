public class StringArrayTest {
    
    public static List<String> generateStringArray(Integer count)
    {
        List<String> lstStr=new List<String>();
        for(integer i=0;i<count;i++)
        {
            lstStr.add('Test '+i);
        }
        return lstStr;
    }

}