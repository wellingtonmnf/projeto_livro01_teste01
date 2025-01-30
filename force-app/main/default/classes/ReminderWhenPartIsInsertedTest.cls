@isTest
private class ReminderWhenPartIsInsertedTest {

    @isTest
    static void createPart() {
        // Cria um registro de "Peça" de teste
        Test.startTest();
        Part__c part = new Part__c(Name = 'Part Test');
        insert part;
        Integer emailLimit = Limits.getEmailInvocations();
        Test.stopTest();
        // Verifica se a tarefa foi criada
        Task task = [SELECT Id, Subject, Description, ActivityDate, WhatId FROM Task WHERE WhatId = :part.Id];
        //* Verifica se o email foi enviado para o usuário que incluiu o registro.
        EmailMessage email = [SELECT Id, Subject FROM EmailMessage WHERE RelatedToId = :part.Id];

        System.assertNotEquals(null, task);
        System.assertEquals('Lembrete: Revisar peça inserida ' + part.Name, task.Subject);
        // Verifica se o email foi enviado
        System.assertEquals(1,emailLimit);
        System.assertEquals('Nova peça de carro cadastrada Part Test', email.Subject);

    }
}