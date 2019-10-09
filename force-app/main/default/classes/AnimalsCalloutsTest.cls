@isTest
public class AnimalsCalloutsTest {

    @isTest public static void testGetCallOut()
    {
        StaticResourceCalloutMock mock= new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
    }
}