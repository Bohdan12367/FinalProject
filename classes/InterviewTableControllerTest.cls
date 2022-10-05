@IsTest
public with sharing class InterviewTableControllerTest {

    @TestSetup static void setup() {
        Interview__c inter = new Interview__c(Name = 'devops', Candidate__c = '0037R00003GK6AaQAL', Stage__c = 'Arranged', Scheduled_interview_date__c = System.today());

        insert inter;
    }

    @IsTest
    static void testAllInterviews() {
        Interview__c inter = [SELECT Name,Candidate__c,Stage__c FROM Interview__c WHERE Candidate__c =: '0037R00003GK6AaQAL' LIMIT 1];

        Test.startTest();
        List<Interview__c> inters = InterviewTableController.getAllInterviews('0037R00003GK6AaQAL');
        List<Interview__c> intersPerWeek = InterviewTableController.getInterviewsPerWeek('0037R00003GK6AaQAL');
        Test.stopTest();

        System.equals(1, intersPerWeek.size());
        System.equals(inter.Name, inters[0].Name);
    }

    @IsTest
    static void testPerWeekInterviews() {
        List<AggregateResult> inters = [SELECT COUNT(Id) FROM Interview__c WHERE Candidate__c =: '0037R00003GK6AaQAL'];

        Test.startTest();
        Integer inter = InterviewTableController.getInterviewsCount('0037R00003GK6AaQAL');
        Test.stopTest();

        System.equals(inters[0],inter);

    }
}
