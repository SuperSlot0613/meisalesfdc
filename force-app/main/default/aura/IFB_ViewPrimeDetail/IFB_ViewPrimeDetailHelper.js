({
	getPrimeDetails : function(component,event,helper) {
        var recId=component.get("v.recordId");
        var serno=component.get("v.cardserno");
        console.log("This is record id",recId);
        console.log("This is serno number",serno);
        var action=component.get("c.getPrimedetails");
        action.setParams({
            "strResId":recId,
            "serNo":serno
        });
        
        
		
	},
    closeT : function(component,event,helper){
       
    }
})