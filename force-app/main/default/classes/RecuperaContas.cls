public with sharing class RecuperaContas {

    public List<Account> contas {get; set;}

    public RecuperaContas() {

        contas = new List<Account>();
        contas = [SELECT Id, Name FROM Account];
    }

    public void imprimeContas(){
        for (Account conta : contas) {
            System.debug(conta.Name);
        }
    }
}