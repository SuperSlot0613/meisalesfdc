({
	doInit : function(component, event, helper) {
		var action=component.get('c.findAll');
        action.setCallback(this,function(a){
            component.set('v.contacts',a.getReturnValue());
        })
        $A.enqueueAction(action);
	},
    searchKeyChange : function(component, event, helper) {
		var action=component.get('c.findByName');
        action.setCallback(this,function(a){
            component.set('v.contacts',a.getReturnValue());
        })
        $A.enqueueAction(action);
	}
})