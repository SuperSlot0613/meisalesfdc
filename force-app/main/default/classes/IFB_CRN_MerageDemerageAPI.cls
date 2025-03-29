@RestResource(urlMapping='/CRNMERAGEDEMERAGEAPI')
global with sharing class IFB_CRN_MerageDemerageAPI {
  @HttpPost
  global static void IFB_CRN_MerageDemerageAPIPOST() {
    RestRequest request = RestContext.request;
    String requeststr = '';
    String requestHeader = '';
    String requestbody = '';
    String responseStr = '';
    try {
      if (request.requestBody != null) {
        requeststr = request.requestBody.toString();
      }

      Map<String, Object> parameter = (Map<String, Object>) JSON.deserializeUntyped(
        requeststr
      );
      requestHeader = JSON.serialize(
        parameter.get('crnMergeDemerageinDRMRequest')
      );
      parameter = (Map<String, Object>) JSON.deserializeUntyped(requestHeader);
      requestbody = JSON.serialize(parameter.get('msgBdy'));
      System.debug('This is map of all rquest' + parameter);
      CC_CRN_MergeDeMergeInBoundReqProcessor CC_CRN_obj = new CC_CRN_MergeDeMergeInBoundReqProcessor();
      responseStr = CC_CRN_obj.process(requestbody);
      System.debug('This is response in Main' + responsestr);
    } catch (Exception e) {
      String errorResponseWrapper = e.getMessage();
      RestResponse responseRestObj = new RestResponse();
      responseRestObj.addHeader('Content-Type', 'application/json');
      responseRestObj.responseBody = Blob.valueOf(errorResponseWrapper);
      RestContext.response = responseRestObj;
    }
    RestResponse responseRest = new RestResponse();
    responseRest.addHeader('Content-Type', 'application/json');
    responseRest.responseBody = Blob.valueOf(responseStr);
    RestContext.response = responseRest;
  }
}
