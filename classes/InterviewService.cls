public class InterviewService {
    public static void preventCreateInterview(List<Interview__c> interviews){
        Integer p=3;
        List<Id> ids = new List<Id>();
        //We are extracting interviews for this week
        List<Interview__c> thisWeekInterviewList =[SELECT Interviewer__c FROM Interview__c WHERE CreatedDate =THIS_WEEK];
        //we create a list with interview values
       	for(Interview__c interview : thisWeekInterviewList){
              ids.add(interview.Interviewer__c);
    	}
        
        Map<Id,Integer> elCount = new Map<Id,Integer>();
		//let's convert our data into a map and count the number of identical values
        for(Id key : ids){
       		if(!elCount.containsKey(key)){
            elCount.put(key,0);
      		}
            Integer currentInt=elCount.get(key)+1;
            elCount.put(key,currentInt);
        }
        //we will deduce an error with a larger number of interviews
        for(Interview__c inter : interviews){
       		 if (elCount.get(inter.interviewer__c) >=p){         
              	 inter.addError('You already have 3 interviews per week for this interviewer. Please choose another interviewer');
           	}
        }
           
    }
}