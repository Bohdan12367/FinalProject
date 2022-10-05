@IsTest
public class InterviewServiceTest {

    @IsTest
    static void testInterview() {
        List<Interview__c> interviews = TestDataFactory.createInterviewWithInterviewer(3);
        Test.startTest();
        insert interviews;
        for(Integer i=0; i<interviews.size(); i++) {
            interviews[i].Scheduled_interview_date__c = System.today() + 1;
        }
        update interviews;
        Test.stopTest();
        System.equals('Scheduled', interviews[0].Stage__c);
    }

    @IsTest
    static void testInterviewError() {
        List<Interview__c> interviews = TestDataFactory.createInterviewWithInterviewer(10);
        System.debug(interviews.size());
        Test.startTest();
        try {
            for (Integer i = 0; i < interviews.size(); i++) {
                interviews[i].Scheduled_interview_date__c = System.today() + 1;
            }
            update interviews;
        } catch (Exception ex) {
            Boolean expectedExceptionThrown =  ex.getMessage().contains('You already have 3 interviews per week for this interviewer. Please choose another interviewer');
            System.assertEquals(expectedExceptionThrown, false);
        }
        Test.stopTest();
    }

    @IsTest
    static void testBulkInterview() {
        List<Interview__c> interviews = TestDataFactory.createInterviewWithInterviewer(20, 30);
        Test.startTest();
        insert interviews;
        for (Integer i = 0; i < interviews.size(); i++) {
            interviews[i].Scheduled_interview_date__c = System.today() + 1;
        }
        update interviews;
        Test.stopTest();
        System.equals(20, interviews.size());
    }
}
