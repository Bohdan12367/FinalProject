@IsTest
public class TestDataFactory {

    public static Contact createContact(String nameContact) {
        Contact contact = new Contact(LastName = nameContact, RecordTypeId = '0127R000000WJ24QAG');
        insert contact;
        return contact;
    }

    public static List<Interview__c> createInterviewsList(Integer numInter, Id contactId, Boolean toUpdate) {
        List<Interview__c> interviews = new List<Interview__c>();
        for (Integer i = 0; i < numInter; i++) {
            interviews.add(new Interview__c(Name = 'devops' + i, Interviewer__c =contactId, Stage__c = 'Arranged'));
        }
        insert interviews;
        for (Interview__c i : interviews) {
            i.Scheduled_interview_date__c = Date.today();
        }
        if (toUpdate = true) {
            update interviews;
        }
        return interviews;
    }

    public static Interview__c createInterview (Id contactId) {
        Interview__c interview = new Interview__c(Name = 'devops', Interviewer__c = contactId, Stage__c = 'Arranged');
        insert interview;
        return interview;
    }
}
