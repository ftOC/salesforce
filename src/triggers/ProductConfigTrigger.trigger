trigger ProductConfigTrigger on Apttus_Config2__ProductConfiguration__c (After update,Before Insert,After insert){
	if(Trigger.isAfter ){
		
		if(Trigger.IsUpdate){
			if(Nokia_CPQ_Constants.ProductConfigAfterUpdate == 'True'){
				ProductConfigTriggerHandler.afterUpdate(Trigger.new, Trigger.old);
				Nokia_CPQ_Constants.ProductConfigAfterUpdate = 'False';
				// ProductConfigTriggerHandler.afterInsert(Trigger.newMap);

			}
			ProductConfigTriggerHandler.afterUpdate_QTC(Trigger.new, Trigger.old);
		}
		else if(Trigger.IsInsert){

		}
	}else if(Trigger.isBefore) {
		if(Trigger.isInsert)
	{
		//Nokia CPQ REQ:6624 
		ProductConfigTriggerHandler.beforeInsert(Trigger.new);
	}
		else if(Trigger.isUpdate){
			
		}
	}
// Added by Nandeesh
	if(Trigger.IsAfter){
		if(Trigger.isUpdate ){	   
				ProductConfigTriggerHandler.insertSitePhaseRec(Trigger.New);
		}
	}
}