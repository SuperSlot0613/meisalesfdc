/**
* @File Name : offerRecordGetter.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : October 6, 2024
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | October 6, 2024 |   | Initial Version
**/

public class offerRecordGetter {

    @AuraEnabled(cacheable=true)
    public static List<Offer__c> findById(String recordId){
      System.debug(recordId);
      List<Offer__c> offerrecord=[Select id,Offer_Status__c,External_Offer_ID__c,Max_Offer_Amount__c, Min_Offer_Amount__c, Max_ROI__c, Min_ROI__c,Card_benefits_offered__c,Offered_Card_Best_Fit__c,Product_Category__c from Offer__c where Id=:recordId];
      return offerrecord;
    }

    @AuraEnabled(cacheable=true)
    public static String getCustomLabel(String labelName) {
          try {
              String value=System.Label.get('',labelName,'en');
              return value;
          } catch (Exception e) {
              return 'Label Not Found';
          }
    }
}