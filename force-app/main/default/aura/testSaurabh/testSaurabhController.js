({
	addNumber : function(component) {
		var addvalue=component.get("v.num1")+component.get("v.num2");
        component.set("v.sum",addvalue);
	},
    getNumbers : function(component) {
   		var numbers=[];
        for(var i=0;i<=10;i++){
    		numbers.push({value:i});
        }
        component.set('v.num',numbers);
	},
    getName : function(cmp) {
   		var firstname=cmp.find('firstname').get("v.value")
    	var lastname=cmp.find('LastName').get('v.value')
    	var outPut=cmp.find('nameOutput')
    	outPut.set("v.value",firstname+lastname)
	},
    handleClick : function(cmp,event) {
   		var attributevalue=cmp.get('v.text')
        console.log("Current text"+attributevalue)
        var target;
        if(event.getSource){
            target=event.getSource();
            cmp.set('v.text',target.get('v.label'));
        }else{
            target=event.target.value
            cmp.set('v.text',event.target.value+"******")
        }
	},
    echo : function(cmp) {
   		var action=cmp.get("c.serverEcho");
        action.setParams({FirstName:cmp.get("v.FirstName")});
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
                alert("From Server : "+response.getReturnValue());
            }else if(state==="INCOMPLETE"){
                console.log("INCOMPLLETE ERROR")
            }else if(state==="ERROR"){
                var errors=response.getError();
                if(errors){
                    console.log("error"+errors);
                }
            }
        });
        $A.enqueueAction(action);
	},
    getOpps : function(cmp) {
   		var action=cmp.get("c.getOpportunities");
        debugger;
        action.setCallback(this,function(response){
            var state=response.getState();
            debugger;
            if(state=="SUCCESS"){
                cmp.set("v.Opportunity",response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
        
	},
})