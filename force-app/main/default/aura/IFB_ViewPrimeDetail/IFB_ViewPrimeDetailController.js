({
	doinit : function(component, event, helper) {
        component.set("v.blnSpinnerShow",true);
		var pagerefrence=component.get("v.pageReference");
        var currentuser=component.get("v.CurrenteUser");
        console.log("This is current user",currentuser)
		var parseUrl=new URL(window.location.href);
		var recordId=parseUrl.searchParams.get("c__recordId");
		var serno=parseUrl.searchParams.get("c__sn");
		console.log("This is serno number",serno);
        console.log("This is record id",recordId);
        component.set("v.recordId",recordId);
        component.set("v.cardserno",serno);

	    var workspaceAPI=component.find("workspace");
		workspaceAPI.getFocusedTabInfo().then(function(response){
			var focusedTabId=response.tabId;
			workspaceAPI.setTabLabel({
				tabId:focusedTabId,
				label:"Card Details"
			});
			workspaceAPI.setTabIcon({
				tabId:focusedTabId,
				icon:"utility:table",
				iconAlt:"Details"
			});
		}).catch(function(error){
			console.log("This is error coming",error);
		});
        console.log("Setting open Tab UI");
        component.set("v.blnSpinnerShow",false);
        helper.getPrimeDetails(component,event,helper);

	},
    
    closeT : function(component,event,helper){
        var workspaceAPI=component.find("workspace");
		workspaceAPI.getFocusedTabInfo().then(function(response){
			var focusedTabId=response.tabId;
            workspaceAPI.closeTab({tabId:focusedTabId});
		}).catch(function(error){
			console.log("This is error coming",error);
		});
    }
})