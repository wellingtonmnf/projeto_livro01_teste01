/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class SendEmailToAccountOwnerTest {

    @TestSetup
    static void createTestData(){
        //Criação da conta de teste
        Account conta = new Account(Name='Test Account');
        insert conta;

        //Criação do usuário para associar à conta de teste
        Profile profile = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User user = new User(Alias='standt', Email='standarduser@testorg.com', EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId=profile.Id, TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');

        insert user;

        //Associação do usuário criado à conta de teste
        conta.OwnerId = user.Id;
        update conta;
    }

    @isTest
    static void testSendEmailToAccountOwner() {
        //Criação da oportunidade de teste associada à conta criada no testSetup
        Account conta = [SELECT Id, OwnerId FROM Account WHERE Name='Test Account'];
        Opportunity opp = new Opportunity(Name='Test Opportunity', StageName='Prospecting', CloseDate=Date.today().addDays(30), AccountId=conta.Id);

        insert opp;

        //Verificação de que o e-mail foi enviado corretamente
        Test.startTest();
        
        String userEmail = [SELECT Email FROM User WHERE Id = :conta.OwnerId LIMIT 1].Email;

        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toaddresses = new String[]{userEmail};
        message.subject = 'Nova Oportunidade Adicionada';
        message.setPlainTextBody('Uma nova oportunidade foi adicionada à sua conta'+conta.Name);

        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>{message};
        Messaging.SendEmailResult[] sentEmails = Messaging.sendEmail(messages);

        Test.stopTest();

        System.assertEquals(1, sentEmails.size(), 'Deve ter sido enviado apenas um e-mail');
    }
}