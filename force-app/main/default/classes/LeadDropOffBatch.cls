/**
* @File Name : LeadDropOffBatch.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : October 20, 2024
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | October 20, 2024 |   | Initial Version
**/

global class LeadDropOffBatch implements Database.Batchable<sObject>{

	Set<Lead> leadlist=new Set<Lead>();
	List<Lead> updateLead=new List<Lead>();

	List<String> leadstatus=new String[]{'Contact Center','New'};
	List<String> leadoffer=new String[]{'Active','In Progress'};

	String strcc='Credit Card';
	String strsource='Internet';

	List<String> lead2hDrop=system.label.DropIn2hCampaignList.split(',');
	List<String> lead4hDrop=system.label.DropIn4hCampaignList.split(',');
	
	global Database.QueryLocator start(Database.BatchableContext bc){

		return Database.getQueryLocator('Select id,Status, Lead_Sub_Status__c, LastModifiedDate, Customer_ID__c, Offer_ID__c, Campaign__r.Name, Campaign__c,isNew__c from Lead'
		                                +' where Customer_ID__c != null And Segment_Type__c =:strcc And Lead_Source__c =:strsource'
										+' And (Offer_ID__c !=null and Status In:leadstatus) And (Campaign__r.Name In:lead2hDrop or Campaign__r.Name In:lead4hDrop)');
	}

	global void execute(Database.BatchableContext bc,List<Lead> llist){
		System.debug('This is list 2h campaign'+lead2hDrop);
		System.debug('This 4h camp'+lead4hDrop);
		System.debug('Hello I am execute');
		long longlastmodifiedDate;
		long longNowTime=Datetime.now().getTime();
		long longmiliseconddiff;
		long longminutediff;
		System.debug(longNowTime);
		System.debug('List of lead info'+llist);

		List<String> setofferdetail=new List<String>();
		List<String> setActiveofferdetail=new List<String>();

		for(Lead led:llist){
			setofferdetail.add(led.Offer_ID__c);
		}

		List<Offer__c> lstofferdetail=new List<Offer__c>();

		lstofferdetail=[select Name from Offer__c where Product__c ='Credit Card' and Offer_Status__c In:leadoffer and Name In:setofferdetail];
		System.debug('List of offer'+lstofferdetail);

		for(Offer__c offlist:lstofferdetail){
			setActiveofferdetail.add(offlist.Name);
		}
		System.debug('List of active offer'+setActiveofferdetail);

		Set<Lead> setofupdatelist=new Set<Lead>();

		for(Lead lrec:llist){
			longlastmodifiedDate=lrec.LastModifiedDate.getTime();
			longmiliseconddiff=longNowTime-longlastmodifiedDate;
			longminutediff=longmiliseconddiff/60000;
			System.debug('Longminute'+longminutediff);

			if(lrec.Campaign__c!=null && longminutediff>Long.valueOf(System.label.Drop2hCampaignTime) && lead2hDrop.contains(lrec.Campaign__r.Name)){
				setofupdatelist.add(lrec);
			}else if(lrec.Campaign__c!=null && longminutediff>Long.valueOf(System.label.Drop4hCampaignTime) && lead4hDrop.contains(lrec.Campaign__r.Name)){
				setofupdatelist.add(lrec);
			}
		}

		List<Lead> setupdateLead=new List<Lead>();

		if(setofupdatelist.size()>0){
			for(Lead setUpdate : setofupdatelist){
				setUpdate.Status='Contact Center';
				setUpdate.Lead_Sub_Status__c='Customer dropped';
				setUpdate.isNew__c=false;
				setupdateLead.add(setUpdate);
			}
		}
		System.debug('List of lead to be update'+setupdateLead);

		Database.SaveResult[] leaddrop = Database.update(setupdateLead, false);

		for(Database.SaveResult le:leaddrop){
			if(le.isSuccess()){
				System.debug('Successfully updated the lead'+le.getId());
			}else{
				for(Database.Error err : le.getErrors()) {
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Account fields that affected this error: ' + err.getFields());
                }
			}
		}

	}

	global void finish(Database.BatchableContext bc){
		System.debug('Hello i am Finish');
	}

}