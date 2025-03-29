public with sharing class CC_CRN_MergeDeMergeInBoundReqProcessor {
  public class crnMerageReqWrapper {
    @AuraEnabled
    public String olduci { get; set; }
    @AuraEnabled
    public String srcSystemId { get; set; }
  }

  public class FinalResponse {
    public String statusReason;
    public String Status;
    public String errorCode;
  }

  public String process(String requestStructure) {
    FinalResponse response = new FinalResponse();
    String responseStr = '';
    try {
      if (requestStructure != null) {
        crnMerageReqWrapper msgBodyWrapper = (crnMerageReqWrapper) JSON.deserializeStrict(
          requestStructure,
          crnMerageReqWrapper.class
        );
        System.debug('requestStructure' + requestStructure);
        System.debug(msgBodyWrapper);
        response = processRequest(msgBodyWrapper);
        responseStr = JSON.serialize(response);
      }
    } catch (Exception ex) {
      response.statusReason = ex.getMessage();
      response.Status = 'ERROR';
      response.errorCode = '400';
    }
    return responseStr;
  }

  public FinalResponse processRequest(crnMerageReqWrapper reqWrapper) {
    FinalResponse responeWrapper = new FinalResponse();
    String duprifix = '_DUP';
    String oblUcic = reqWrapper.olduci;
    String srcSystemId = reqWrapper.srcSystemId;
    List<String> parts = srcSystemId.split('_');
    String accountNumber = parts[0];
    String cardserno = parts[1];
    List<Account> Dummyacc = new List<Account>();
    try {
      if (
        oblUcic != null &&
        oblUcic != '' &&
        srcSystemId != null &&
        srcSystemId != ''
      ) {
        List<Card__c> cardlist = new List<Card__c>();
        List<Financial_Account__c> finaAcctobeUpdated = new List<Financial_Account__c>();
        List<SObject> objToBeUpdated = new List<SObject>();
        Dummyacc = [
          SELECT Id
          FROM Account
          WHERE AccountNumber = :system.Label.IFB_CC_CRNMergeDummyUCIC
          LIMIT 1
        ];
        if (Dummyacc.isEmpty()) {
          responeWrapper.statusReason = 'Dummy Account doesnt exists';
          responeWrapper.Status = 'ERROR';
        }

        cardlist = [
          SELECT
            Id,
            Name,
            Ownership_Type__c,
            Account_Holder__c,
            Account_Holder__r.AccountNumber,
            Financial_Account__c,
            Financial_Account__r.Account_Holder_Name__c,
            Financial_Account__r.Account_Holder_Name__r.AccountNumber,
            Financial_Account__r.Financial_Account_Name__c
          FROM Card__c
          WHERE
            Name = :cardserno
            AND Account_Holder__r.AccountNumber = :oblUcic
            AND Financial_Account__r.Financial_Account_Name__c = :accountNumber
        ];

        if (!cardlist.isEmpty()) {
          for (Card__c cardData : cardlist) {
            cardData.Name = cardData.Name + duprifix;
            cardData.Ownership_Type__c = 'NA';
            cardData.Account_Holder__c = Dummyacc[0].Id;
            if (cardData.Financial_Account__c != null) {
              Financial_Account__c finanacc = new Financial_Account__c();
              finanacc.Id = cardData.Financial_Account__c;
              finanacc.Financial_Account_Name__c =
                cardData.Financial_Account__r.Name + duprifix;
              finanacc.Account_Holder_Name__c = Dummyacc[0].Id;
              finaAcctobeUpdated.add(finanacc);
            }
          }
          objToBeUpdated.addall(cardlist);
          if (!finaAcctobeUpdated.isEmpty()) {
            objToBeUpdated.addall(finaAcctobeUpdated);
          }

          if (objToBeUpdated.size() > 0 && objToBeUpdated != null) {
            update objToBeUpdated;
            responeWrapper.statusReason = 'SUCCESS';
            responeWrapper.Status = 'SUCCESS';
            responeWrapper.errorCode = 'null';
          }
        } else {
          responeWrapper.statusReason = 'No Card exists for the UCIC and SOurce system ID';
          responeWrapper.Status = 'ERROR';
          responeWrapper.errorCode = '200';
        }
      } else {
        responeWrapper.statusReason = 'Please pass a valid request with OLD UCIC and SOurce System ID';
        responeWrapper.Status = 'ERROR';
      }
    } catch (Exception e) {
      System.debug(e.getMessage() + '****' + e.getLineNumber() + '%');
      responeWrapper.status = e.getMessage();
      responeWrapper.statusReason = String.valueOf(e.getMessage());
      responeWrapper.errorCode = '400';
      return responeWrapper;
    }
    return responeWrapper;
  }
}
