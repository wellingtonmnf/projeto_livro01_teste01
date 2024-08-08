public with sharing class ContaContatoV2 {

    public Map<Id, List<Contact>> contasComContatosMap {get; set;}
    public Map<Id, Account> contasSemContatosMap {get; set;}
    public List<Account> contas = [SELECT Id, Name FROM Account];  

    public ContaContatoV2() {

        contasComContatosMap = new Map<Id, List<Contact>>();
        contasSemContatosMap = new Map<Id, Account>();
        List<Contact> contatos = new List<Contact>();
        for (Contact contato : [SELECT Id, FirstName, LastName, AccountId FROM Contact WHERE AccountId = :contas] ) {
            List<Contact> contatoTemp = new List<Contact>();
            if(contasComContatosMap.containsKey(contato.AccountId)){
                contatoTemp = contasComContatosMap.get(contato.AccountId);
                contatoTemp.add(contato);
                contasComContatosMap.put(contato.AccountId, contatoTemp);
            }else{
                contatoTemp.add(contato);
                contasComContatosMap.put(contato.AccountId, contatoTemp);
            }
        }
        for(Account conta : contas) {
            if (!contasComContatosMap.containsKey(conta.Id)) {
                contasSemContatosMap.put(conta.Id, conta);
            }
        }
    }

    public void imprimirContatosDeContas() {
        for (Id contaId : contasComContatosMap.keySet()) {
            Account conta = contasSemContatosMap.get(contaId);
            for(Contact contato : contasComContatosMap.get(contaId)){
                System.debug('A conta ' + conta.Name + ' tem o seguinte contato: ' + contato.FirstName + ' ' + contato.LastName);
            }
        }
    }

}