trigger Agreement_Trigger on Apttus__APTS_Agreement__c (before update, before insert, after insert, after update) {
	if (!UserInfo.getProfileId().equalsIgnoreCase(System.Label.Data_Loader_Profile_Id)) {
		if (Trigger.isBefore) {
			if (Trigger.isUpdate) {
			
			AgreementTriggerHandler.checkMandatoryFields(Trigger.new, Trigger.oldMap);
	
			}
		}
		
	}
	/*
	* CLM changes:Rajeev Ketha
	* CLM Services - E2ECLM- 3, 4,6, 9,10,11
	*/
	if (Trigger.isAfter && Trigger.isUpdate) {
		CLM_AgrmntCustomActionsCtrl.shreWithTeamWhenOwnerChange(Trigger.newMap, Trigger.oldMap);

		AgreementTriggerHandler.afterUpdate(Trigger.newMap, Trigger.oldMap);//CLM chganges
		
	}
	if (Trigger.isBefore && Trigger.isInsert) {
		AgreementTriggerHandler.beforeInsert(Trigger.new); /* DSI-1857 */
	}
	if (Trigger.isAfter && Trigger.isInsert) {
		CLM_AgrmntCustomActionsCtrl.creatAgrmntTeamRoles(Trigger.new);
		AgreementTriggerHandler.afterInsert(Trigger.new); /* DSI-1857 */
		
	}
}