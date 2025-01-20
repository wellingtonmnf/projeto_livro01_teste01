trigger UpdateLastOpportunityDate on Opportunity (after insert) {

    Set<Id> accountIds = new Set<Id>();

    for (Opportunity oportunidade : Trigger.new) {
        accountIds.add(oportunidade.AccountId);
    }

    List<Account> accountsToUpload = new List<Account>();

    /* 
     * AggregateResult é uma classe especial. É um objeto somente leitura 
     * que representa o resultado de uma consulta SOQL contendo funções de agregação 
     * como COUNT(), SUM(), AVG(), MIN() ou MAX(). Ele permite que os desenvolvedores 
     * realizem cálculos e agrupamentos de dados diretamente na consulta, 
     * em vez de processar os resultados individualmente em Apex
     */

    for (AggregateResult resultadoAgregado : [SELECT AccountId, MAX(CloseDate) maxCloseDate FROM Opportunity WHERE AccountId IN :accountIds GROUP BY AccountId]) {
        
        Account conta = new Account(Id=(Id)resultadoAgregado.get('AccountId'), LastOpportunityDate__c=(Date)resultadoAgregado.get('maxCloseDate'));
        accountsToUpload.add(conta);
    }

    update accountsToUpload;

}