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
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
                var responseRecord=response.getReturnValue();
                //console.log("This is the response",responseRecord);
                if(responseRecord[0].EntityInquiryResponse && responseRecord[0].InfoRequestResponse[0]){
                    responseRecord[0].strTAD=responseRecord[0].strTAD*(-1);
                    responseRecord[0].strMAD=responseRecord[0].strMAD*(-1);
                    responseRecord[0].currOutstanding=responseRecord[0].currOutstanding*(-1);
                    responseRecord[0].stmtDate=this.dateFormat(responseRecord[0].stmtDate);
                    responseRecord[0].paymentDueDt=this.dateFormat(responseRecord[0].paymentDueDt);
                    responseRecord[0].paymentDt=this.dateFormat(responseRecord[0].paymentDt);
                    component.set("v.strAccountSerNo",responseRecord[0].accountSerNo);
                    component.set("v.data",responseRecord[0]);
                    component.set("v.blnSpinnerShow",false);
                }
            }else{
                component.set("v.blnSpinnerShow",false);
                component.set("v.showDetails",false);
                component.set("v.errorMessage","Unfortunately, no record details were found!");
            }
        });
        
        var action1=component.get("c.getRewardsDetail");
        action1.setParams({
            "strResId":recId,
            "serNo":serno
        });
        
        action1.setCallback(this,function(response){
            var state=response.getState();
            if(state=='SUCCESS'){
                var responseReward=response.getReturnValue();
                //console.log('This reward response',responseReward);
                if(responseReward.Success=='Success'){
                    component.set('v.rewardRes',responseReward);
                    component.set("v.blnSpinnerShow",false);
                }else{
                    component.set("v.blnSpinnerShow", false);
                }
            }else if(state=='ERROR'){
                component.set("v.blnSpinnerShow", false);
                //console.log('We are not getting success response');
            }
        });
        
        $A.enqueueAction(action);
        
        $A.enqueueAction(action1);
	},
    
    dateFormat:function(dateString){
        var date1=new Date(dateString);
        return (((date1.getDate()>9)? date1.getDate() : ('0'+date1.getDate()))
                + '/'+((date1.getMonth()>8)? (date1.getMonth()+1) : ('0'+(date1.getMonth()+1)))
                +'/'+date1.getFullYear());
    },
    
    
    closeT : function(component,event,helper){
       
    }
})