global class AccountNumberUpdate implements Database.Batchable<sObject>,Database.Stateful{
    
    integer recordProcess=0;
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        System.debug('Inside Start method');
        String Query='select id,BillingCity, BillingCountry, BillingState, AccountNumber,BillingStreet from Account where AccountNumber =\'XXXX\'';
        return Database.getQueryLocator(Query);
    }
    
    global void execute(Database.BatchableContext BC,List<Account> accList){
        System.debug('Inside execute method');
        for(Account acc:accList){
            acc.AccountNumber='YYYY';
            recordProcess+=1;
        }
        update accList;
    }
    
    global void finish(Database.BatchableContext BC){
        System.debug('Inside Finish method');
        System.debug('Number of recorde process'+recordProcess);
    }

}