public with sharing class InterviewSelector {

    public static List<AggregateResult> getInterviewListThisWeek(List<Interview__c> interviews) {
        String query = 'SELECT Interviewer__c, COUNT(Id) interviewCount FROM Interview__c WHERE WEEK_IN_YEAR(Scheduled_interview_date__c) In (';
        for (Interview__c inter : interviews) {
            Date i = inter.Scheduled_interview_date__c;
            Integer monthNumber = Integer.valueOf(Datetime.newInstanceGmt(i.toStartOfWeek(), Time.newInstance(12,0,0,0)).format('w'))-1;
            query += monthNumber + ',';
        }
        query = query.removeEnd(',');
        query += ') GROUP BY Interviewer__c';
        return Database.query(query);
    }
}
