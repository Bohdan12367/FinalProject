@IsTest
public class InterviewServiceTest {

    @IsTest
    static void testInterview() {
        Contact c = TestDataFactory.createContact('Ivan');
        TestDataFactory.createInterviewsList(1,c.Id,true);
        Interview__c interview = TestDataFactory.createInterview(c.Id);
        interview.Scheduled_interview_date__c = Date.today();
        Test.startTest();
        update interview;
        Test.stopTest();
        System.equals('Scheduled', interview.Stage__c);
    }

    @IsTest
    static void testInterviewError() {
        Contact c = TestDataFactory.createContact('Ivan');
        TestDataFactory.createInterviewsList(3,c.Id,true);
        Interview__c interview = TestDataFactory.createInterview(c.Id);
        interview.Scheduled_interview_date__c = Date.today();
        Test.startTest();
        try {
            update interview;
        } catch (Exception ex) {
            Boolean expectedExceptionThrown =  ex.getMessage().contains('You already have 3 interviews per week. Please choose another date');
            System.assertEquals(expectedExceptionThrown, true);
        }
    }

    @IsTest
    static void testBulkInterview() {
        Contact c = TestDataFactory.createContact('Ivan');
        List<Interview__c> interviews = TestDataFactory.createInterviewsList(200, c.Id,false);
        Test.startTest();
        for (Integer i = 0; i < interviews.size(); i++) {
            interviews[i].Scheduled_interview_date__c = System.today() + 7;
        }
        update interviews;
        Test.stopTest();
        System.equals(200, [SELECT COUNT(Id) FROM Interview__c WHERE Interviewer__c =:c.Id]);
    }
}
