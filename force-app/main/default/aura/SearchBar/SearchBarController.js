({
	serachKeychange : function(component, event, helper) {
		var myEvent=$A.get('SearchKeychange');
        myEvent.setParams({"searchKey":event.taregt.value});
        myEvent.fire();
	}
})