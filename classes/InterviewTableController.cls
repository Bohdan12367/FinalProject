public with sharing class InterviewTableController {

    @AuraEnabled(Cacheable=true)
    public static List<Interview__c> getInterviewsPerWeek(Id candidateId) {
        String query = buildQuery(false,true);
        return Database.query(query);
    }

    @AuraEnabled(Cacheable=true)
    public static List<Interview__c> getAllInterviews(Id candidateId) {
        String query = buildQuery(false,false);
        return Database.query(query);
    }

    @AuraEnabled(Cacheable=true)
    public static Integer getInterviewsCount(Id candidateId) {
        String query = buildQuery(true,false);
        return Database.countQuery(query);
    }

    private static String buildQuery(Boolean aggregate, Boolean additionCondition) {
        String query = 'SELECT ';
        if (aggregate) {
            query += 'COUNT() ';
        } else {
            query += 'Id, Name, Stage__c  ';
        }
        query += 'FROM Interview__c WHERE Candidate__c =: candidateId ';
        if (additionCondition) {
            query += 'AND Scheduled_interview_date__c = THIS_WEEK ';
        }
        return query;
    }
}
