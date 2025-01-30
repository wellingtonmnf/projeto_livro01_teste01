@isTest
private class IntegracaoPecasCarroTest implements HttpCalloutMock {

    @isTest
    static void testGetCarParts() {

        Test.setMock(HttpCalloutMock.class, new IntegracaoPecasCarroTest());
        Test.startTest();
        IntegracaoPecasCarro.getPartsCar('123456');
        Test.stopTest();

        Part__c part = [SELECT Name FROM Part__c WHERE Name = 'Farol esquerdo' LIMIT 1];
        System.assertNotEquals('Farol esquerdo',part.Name);
        System.assertNotEquals(150.00,part.PartCost__c);
        
    }

    public HttpResponse respond(HttpRequest request){

        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"carParts":[{"partName":"Farol esquerdo","partPrice":150.00},{"partName":"Pneu traseiro","partPrice":80.00},{"partName":"Bateria","partPrice":120.00}]}');
        res.setStatusCode(200);
        return res;

    }

}