global class AccountUpdateNullValues implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        System.debug('Inside Start method');
        String Query='select id,BillingCity, BillingCountry, BillingState, AccountNumber from Account where AccountNumber =null or BillingCity =null or BillingCountry =null or BillingState =null';
        return Database.getQueryLocator(Query);
    }
    
    global void execute(Database.BatchableContext BC,List<Account> accList){
        System.debug('Inside execute method');
        for(Account acc:accList){
            	if(String.isBlank(acc.BillingCity)){
                    acc.BillingCity='Mumbai';
                }
                if(String.isBlank(acc.BillingState)){
                    acc.BillingState='Maharashtra';
                }
                if(String.isBlank(acc.AccountNumber)){
                    acc.AccountNumber='XXXX';
                }
                if(String.isBlank(acc.BillingCountry)){
                    acc.BillingCountry='India';
                }
        }
        update accList;
    }
    
    global void finish(Database.BatchableContext BC){
        System.debug('Inside Finish method');
    }

}