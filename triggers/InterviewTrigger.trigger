trigger InterviewTrigger on Interview__c (before insert, before update) {
	InterviewTriggerHandler.handler(Trigger.new,Trigger.operationType);
}
