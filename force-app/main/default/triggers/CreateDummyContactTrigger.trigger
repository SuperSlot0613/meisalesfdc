trigger CreateDummyContactTrigger on Account (after insert,before Delete,before insert) {
    
    if(Trigger.isAfter && Trigger.isInsert){
        List<Contact> contactList=new List<Contact>();
        for(Account acc:Trigger.new){
            Contact con=new Contact();
            con.LastName=acc.name;
            con.FirstName='Dummy';
            con.AccountId=acc.Id;
            con.MailingCity=acc.BillingCity;
            con.MailingStreet=acc.BillingStreet;
            con.MailingState=acc.BillingState;
            contactList.add(con);
        }
        insert contactList; 
	}
    else if(Trigger.isBefore){
        if(Trigger.isDelete){
           List<Account> accList=new List<Account>();
           Set<Id> accIdSet=new Set<Id>();
           for(Account acc:Trigger.old){
               accIdSet.add(acc.id);
           }
           Map<Id,Account> accts=new Map<Id,Account>([Select id,name,(Select id from contacts) from account where id in :accIdSet]);
           for(Account acc:Trigger.old){
               if(accts.get(acc.Id).contacts.size()>0){
                   acc.addError('Account cannot be deleted because it has contact associated with it');
               }
           }
		}
        else if(Trigger.isInsert){
            for(Account acc:Trigger.new){
                if(String.isBlank(acc.BillingCity)){
                    acc.BillingCity='Mumbai';
                }
                if(String.isBlank(acc.BillingState)){
                    acc.BillingState='Maharashtra';
                }
                if(String.isBlank(acc.AccountNumber)){
                    acc.AccountNumber='YYYY';
                }
                if(String.isBlank(acc.BillingCountry)){
                    acc.BillingCountry='India';
                }
            }
        }
    }
}