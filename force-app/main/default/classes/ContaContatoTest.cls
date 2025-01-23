@isTest
private class ContaContatoTest {

    @isTest
    static void testContaContato() {
        //Criação de contas para teste
        List<Account> contas = new List<Account>();
        for (Integer i = 0; i < 3; i++) {
            contas.add(new Account(Name='ContaTeste'+i));
        }
        insert contas;

        //Criação de contatos para teste
        List<Contact> contatos = new List<Contact>();
        for (Integer i = 0; i < 6; i++) {
            Contact contato = new Contact(AccountId=contas[i/2].Id, FirstName='TestFirstName'+i, LastName='TestLastName'+i);
            contatos.add(contato);
        }
        insert contatos;

        //Execução do método que popula o mapa de contas e contatos
        Test.startTest();
        ContaContato ccc = new ContaContato();
        Test.stopTest();

        //Verificação dos resultados
        Map<Account,List<Contact>> contasComContatosMap = ccc.contasComContatosMap;
        System.assertEquals(contas.size(), contasComContatosMap.size());

        for (Account conta : contasComContatosMap.keySet()) {
            List<Contact> contatosParaConta = contasComContatosMap.get(conta);
            for (Contact contato : contatosParaConta) {
                System.assertEquals(conta.Id, contato.AccountId);
            }
        }
    }

}