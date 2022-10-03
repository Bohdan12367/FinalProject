public with sharing class InterviewTableController {

    @AuraEnabled(Cacheable=true)
    public static List<Interview__c> getInterviews(Id CandidateId){
        return [SELECT Id,Name,Stage__c FROM Interview__c WHERE (Candidate__c=:CandidateId  AND CreatedDate =THIS_WEEK)];
    }
}
