public class InterviewTriggerHandler {
    public static void handler(List<Interview__c> newInterviews,System.TriggerOperation triggerOperation){
    
    	 switch on triggerOperation {
            when BEFORE_INSERT {
                InterviewService.preventCreateInterview(newInterviews);
            }
         }
    }    
}