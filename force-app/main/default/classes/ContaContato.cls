public with sharing class ContaContato {

    public Map<Account, List<Contact>> contasComContatosMap {get; set;}

    public ContaContato() {
        contasComContatosMap = new Map<Account, List<Contact>>();
        List<Account> contas = [SELECT Id, Name FROM Account];
        for (Account conta : contas) {
            List<Contact> contatos = [SELECT Id, FirstName, LastName, AccountId FROM Contact WHERE AccountId = :conta.Id];
            contasComContatosMap.put(conta, contatos);
        }
    }

    public void imprimeLista(){
        for (Account conta : contasComContatosMap.keySet()) {
            System.debug('A conta ' + conta.Name + ' tem os seguintes contatos:');
            for (Contact contato : contasComContatosMap.get(conta)) {
                System.debug(contato.FirstName + ' ' + contato.LastName);
            }
        }
    }
}