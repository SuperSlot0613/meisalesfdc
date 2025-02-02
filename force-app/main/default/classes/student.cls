public class student {
    
    public static void newmethod(){
        Date d1;
        
        d1=Date.today();
        System.debug(d1);
        
        d1=Date.newInstance(2018,01,01);
        
        System.debug(d1.toStartOfMonth());
        System.debug(d1.toStartOfWeek());
        System.debug(d1=d1.addDays(5));
        System.debug(d1=d1+5);
        
        System.debug(d1=d1.addMonths(5));
        
    }

}