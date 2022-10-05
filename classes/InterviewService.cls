public class InterviewService {

    public static final Integer MAX_INTERVIEW_PER_WEEK = 3;

    public static void preventCreateInterview(List<Interview__c> interviews) {
        Map<Id,Integer> interviewsCount = new Map<Id,Integer>();
        List<AggregateResult> aggregateResults = InterviewSelector.getInterviewListThisWeek(interviews);

        for (AggregateResult ar : aggregateResults) {
            Id intId = (Id) ar.get('Interviewer__c');
            for (Interview__c inter : interviews) {
                if (inter.Interviewer__c == intId) {
                    interviewsCount.put(intId, (Integer) ar.get('interviewCount'));
                }
            }
        }
        for (Interview__c inter : interviews) {
            if (interviewsCount.get(inter.Interviewer__c) >= MAX_INTERVIEW_PER_WEEK && inter.Scheduled_interview_date__c != null) {
                inter.addError('You already have 3 interviews per week. Please choose another date');
            } else if (inter.Stage__c == 'Arranged') {
                inter.Stage__c = 'Scheduled';
            }
        }
    }
}
