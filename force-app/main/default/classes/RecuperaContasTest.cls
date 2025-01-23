@isTest
private class RecuperaContasTest {

    @TestSetup
    static void criarContas(){
        List<Account> contas = new List<Account>(); 
        for (Integer i = 1; i <= 5; i++) {
            contas.add(new Account(Name='ContaTeste'+i));
        }
        insert contas;
    }

    @isTest
    static void testImprimeContas() { 
        RecuperaContas rc = new RecuperaContas();
        Test.startTest();
        rc.imprimeContas();
        Test.stopTest();
        System.assertEquals(5, rc.contas.size(), 'Todas as contas foram recuperadas');
    }
}