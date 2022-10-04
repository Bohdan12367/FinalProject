@IsTest
public class InterviewServiceTest {
	@IsTest
    static void testInterview() {
        Contact objContact = new Contact(LastName='Tolik',RecordTypeId='0127R000000WGwnQAG');
        insert objContact;

        Interview__c objInterview = new Interview__c(Name='devops interview',Interviewer__c=objContact.Id,Stage__c='Arranged');
        Interview__c objInterview1 = new Interview__c(Name='devops interview1',Interviewer__c=objContact.Id,Stage__c='Arranged');
        Interview__c objInterview2 = new Interview__c(Name='devops interview2',Interviewer__c=objContact.Id,Stage__c='Arranged');

        Test.startTest();
        insert objInterview;
        insert objInterview1;
        insert objInterview2;

        Test.stopTest();
        List<Interview__c> interviews = [SELECT Interviewer__c FROM Interview__c];
        System.equals(3, interviews.size());
    }
    @IsTest
    static void testInterviewError() {
        Contact objContact = new Contact(LastName='Tolik',RecordTypeId='0127R000000WGwnQAG');
        insert objContact;

        Interview__c objInterview = new Interview__c(Name='devops interview',Interviewer__c=objContact.Id,Stage__c='Arranged');
        Interview__c objInterview1 = new Interview__c(Name='devops interview1',Interviewer__c=objContact.Id,Stage__c='Arranged');
        Interview__c objInterview2 = new Interview__c(Name='devops interview2',Interviewer__c=objContact.Id,Stage__c='Arranged');
    	Interview__c objInterview3 = new Interview__c(Name='devops interview3',Interviewer__c=objContact.Id);

        Test.startTest();
        try {
          	insert objInterview;
        	insert objInterview1;
        	insert objInterview2;
        	insert objInterview3;
        }
        catch (DmlException ex) {
      		System.assertEquals(StatusCode.FIELD_CUSTOM_VALIDATION_EXCEPTION, ex.getDmlType(0));
      		System.assertEquals('You already have 3 interviews per week for this interviewer. Please choose another interviewer', ex.getDmlMessage(0));
        }
        Test.stopTest();
    }


}
