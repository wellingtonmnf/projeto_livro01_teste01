trigger ReminderWhenPartIsInserted on Part__c (after insert) {

    List<Task> tasks = new List<Task>();
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();

    // Obtém os Owners das peças inseridas
    Map<Id, User> owners = new Map<Id, User>();
    for (User user : [SELECT Id, Email FROM User WHERE Id IN (SELECT OwnerId FROM Part__c WHERE Id IN :Trigger.new)]) {
        owners.put(user.Id, user);
    }

    for (Part__c part : Trigger.new) {
        // Cria uma tarefa relacionada ao registro de "Lembrete"
        Task task = new Task();
        task.Subject = 'Lembrete: Revisar peça inserida ' + part.Name;
        task.ActivityDate = Date.today();
        task.WhatId = part.Id;
        tasks.add(task);

        // Obtém o email do proprietário da peça
        User owner = owners.get(part.OwnerId);

        // Verifica se o usuário tem email antes de tentar enviar
        if (owner != null && String.isNotBlank(owner.Email)) {
            // Envia um email para o usuário que incluiu o registro
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new List<String>{owner.Email});
            mail.setSubject('Nova peça de carro cadastrada ' + part.Name);
            mail.setPlainTextBody('Nova peça de carro cadastrada ' + part.Name + '\nData:' + System.today());
            mails.add(mail);
        }
    }

    // Insere as tarefas e envia os emails se houver algum
    insert tasks;
    if (!mails.isEmpty()) {
        Messaging.sendEmail(mails);
    }

}