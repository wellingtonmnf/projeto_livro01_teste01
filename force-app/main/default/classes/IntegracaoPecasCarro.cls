public with sharing class IntegracaoPecasCarro {

    public static void getPartsCar(String carCode){

        String endpoint = 'https://pecascarros.com/getPecas/' + carCode;

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        List<Part__c> partsToUpsert = null;

        if (response.getStatusCode() == 200) {
            Map<String,Object> resultData = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
            List<Object> carParts = (List<Object>)resultData.get('carParts');
            partsToUpsert = new List<Part__c>();

            for (Object carPart : carParts) {
                Map<String,Object> partData = (Map<String,Object>)carPart;
                Part__c part = new Part__c();
                part.Name = (String)partData.get('partName');
                part.PartCost__c = (Double)partData.get('partPrice');
                partsToUpsert.add(part);
            }
        } 

        if (partsToUpsert != null && !partsToUpsert.isEmpty()) {
            try {
                upsert partsToUpsert;
            } catch (Exception e) {
                System.debug(e.getMessage());
            }        
        } 

    }
}