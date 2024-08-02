public with sharing class RecuperaNovosLeads {

    public List<Lead> listaNovosLeads {get; set;}

    public RecuperaNovosLeads(String status) {

        listaNovosLeads = new List<Lead>();
        listaNovosLeads = [SELECT Id, FirstName, LastName FROM Lead WHERE Status = :status];

    }

    public void imprimeNovosLeads(){
        for (Lead novoLead : listaNovosLeads) {
            System.debug('Nome: '+novoLead.FirstName+' '+novoLead.LastName);
        }
    }
}