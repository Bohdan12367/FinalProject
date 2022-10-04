public with sharing class InterviewTableController {

    @AuraEnabled(Cacheable=true)
    public static List<Interview__c> getInterviewsPerWeek(Id CandidateId){
        String query = buildQuery(false,true);
        return Database.query(query);
    }

    @AuraEnabled(Cacheable=true)
    public static List<Interview__c> getAllInterviews(Id CandidateId){
        String query = buildQuery(false,false);
        return Database.query(query);
    }

    @AuraEnabled(Cacheable=true)
    public static Integer getInterviewsCount(Id CandidateId){
        String query = buildQuery(true,false);
        return Database.countQuery(query);
    }

    private static String buildQuery(Boolean aggregate, Boolean additionCondition){
        String query = 'SELECT ';
        if (aggregate){
            query += 'COUNT() ';
        } else {
            query += 'Id, Name, Stage__c, Scheduled_interview_date__c  ';
        }
        query += 'FROM Interview__c WHERE Candidate__c =: CandidateId ';
        if (additionCondition){
            query += 'AND Scheduled_interview_date__c = NEXT_N_DAYS:7 ';
        }
        return query;
    }
}
