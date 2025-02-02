public with sharing class contactController {
    
    @AuraEnabled
    public static List<Contact> findAll(){
        return [Select id,name,phone from Contact LIMIT 50];
    }
    
    @AuraEnabled
    public static List<Contact> findByName(String serachKey){
        String name='%'+serachKey+'%';
        return [Select id,name,phone from Contact where name LIKE:name LIMIT 50];
    }
    
    @AuraEnabled
    public static Contact findById(String contactId){
        return [Select id,name,title,phone,mobilephone,Account.Name from Contact where id=:contactId];
    }
    
}