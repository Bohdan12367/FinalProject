trigger InterviewTrigger on Interview__c (before insert) {
	InterviewTriggerHandler.handler(Trigger.New,Trigger.operationType);
}