/***********************************************
*	Trigger Name : AccountMemberTrigger 
*	Created By : Accenture IDC
*	Created Date :28/August/2017
*	Description : This will handle the Account Team Actions
*	Requirement : Lead & certification Sharing
*********************************************/


trigger AccountMemberTrigger on Account_Member__c (before insert , before update, After insert , before delete,  after update, after delete) {
	
	if(Trigger.isDelete){  
		AccountMemberHelperPRM.unshareCertificationOnDelete(Trigger.old);
	}
	
	if(Trigger.isInsert){
		AccountMemberHanlderPRM.sharePSM(Trigger.new);
		if(Trigger.isBefore){
			AccountMemberHanlderPRM.beforeInsertOperation(Trigger.New);
		}
	}
	if(Trigger.isUpdate){
		AccountMemberHanlderPRM.shareUpdatePSM(Trigger.new,Trigger.new[0],Trigger.Old[0]);
		if(Trigger.isBefore){
			AccountMemberHanlderPRM.beforeUpdateOperation(Trigger.New);
		}
	}
	
}