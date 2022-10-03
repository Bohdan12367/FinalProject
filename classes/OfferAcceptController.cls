public with sharing class OfferAcceptController {
    @AuraEnabled
    public static void updateStageSuccess(Id InterviewId){
        Interview__c interviewToUpdate = [SELECT Id, Stage__c FROM Interview__c WHERE Id=:InterviewId];
        interviewToUpdate.Stage__c = 'Offer Signed';
        update interviewToUpdate;
    }
    @AuraEnabled
    public static void updateStageUnSuccess(Id InterviewId){
        Interview__c interviewToUpdate = [SELECT Id, Stage__c FROM Interview__c WHERE Id=:InterviewId];
        interviewToUpdate.Stage__c = 'Refused';
        update interviewToUpdate;
    }
    @AuraEnabled(Cacheable=true)
    public static Interview__c getInterviews(Id InterviewId){
        return [SELECT Id, Stage__c FROM Interview__c WHERE Id=:InterviewId];
    }
//    public static Boolean offerSent(String InterviewId){
//        Boolean offer = false;
//        List<Interview__c> interviewList = new List<Interview__c>();
//        interviewList = [SELECT Id, Stage__c FROM Interview__c WHERE Id=:InterviewId];
//        for(Interview__c inter: interviewList){
//            if(inter.Stage__c == 'Offer Sent'){
//                offer = true;
//            }
//        }
//        return offer;
//    }
}
