@IsTest
public class TestDataFactory {

    public static List<Interview__c> createInterviewWithInterviewer(Integer numInterview, Integer numContact) {
        List<Contact> contacts  = new List<Contact>();
        for (Integer i = 0; i < numContact; i++){
            Contact c = new Contact(LastName = 'TestContact'+ i,RecordTypeId = '0127R000000WJ24QAG',Email = 'lukasevicboda@gmail.com');
            contacts.add(c);
        }
        insert contacts;
        List<Interview__c> interviews = new List<Interview__c>();
        for(Integer j = 0; j < numContact; j++) {
            Contact cont = contacts[j];
            for (Integer i = 0; i < numInterview; i++) {
                interviews.add(new Interview__c(Name = 'devops' + i, Interviewer__c =cont.Id,Stage__c = 'Arranged'));
            }
        }
        return interviews;
    }

    public static List<Interview__c> createInterviewWithInterviewer(Integer numInterview){
        Contact contact = new Contact(LastName = 'TestContact', RecordTypeId = '0127R000000WJ24QAG');
        insert contact;
        List<Interview__c> interviews = new List<Interview__c>();
        for (Integer i = 0; i < numInterview; i++) {
            interviews.add(new Interview__c(Name = 'devops' + i, Interviewer__c =contact.Id, Stage__c = 'Arranged'));
        }
        return interviews;
    }
}
