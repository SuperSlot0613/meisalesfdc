public class demoSoql {
    
    public static void myMethod(){
        
        List<Account> acclist=[Select Name from Account];
        
        for(integer i=0;i<acclist.size();i++){
            System.debug(acclist[i].Name);
        }
        
        for(Account a:acclist){
            System.debug('Acc Name = '+a.Name);
        }
    }
    
    public static void myContact(String s){
        List<Contact> conList=[Select firstName, lastName, email from Contact where firstName='John'];
    }

}