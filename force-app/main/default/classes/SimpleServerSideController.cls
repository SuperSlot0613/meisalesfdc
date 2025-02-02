public with sharing class SimpleServerSideController {
    
    @AuraEnabled
    public static String serverEcho(String FirstName){
        return ('Hello from the server'+FirstName);
    }
    @AuraEnabled
    public static List<Opportunity> getOpportunities(){
        List<Opportunity> oppor=[Select id, name from Opportunity];
        return oppor;
    }

}