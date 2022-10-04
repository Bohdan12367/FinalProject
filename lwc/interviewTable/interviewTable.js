import {api, LightningElement} from 'lwc';
import getInterviewsPerWeek from '@salesforce/apex/InterviewTableController.getInterviewsPerWeek';
import getInterviewsCount from '@salesforce/apex/InterviewTableController.getInterviewsCount';
import getAllInterviews from '@salesforce/apex/InterviewTableController.getAllInterviews';

const actions = [
    { label: 'View', checked: 'true', name: 'view' },
];

const columns = [
    { label: 'Name Interview', fieldName: 'Name' },
    { label: 'Status Interview', fieldName: 'Stage__c' },
    { label: 'Status Interviewkfrlfjrl', fieldName: 'Scheduled_interview_date__c' },
    {
        type: 'action',
        typeAttributes: {rowActions: actions, menuAlignment: 'left'},
    },
];
export default class InterviewTable extends LightningElement {
    @api recordId;
    dataCount = [];
    dataAll = [];
    dataPerWeek = [];
    dataOffer;
    dataReject;
    columns = columns;
    error;
    visibleInterviews;
    percentOffer;
    percentReject;
    rejectedCount = 0;
    count = 0;

    updateInterviewsHandler(event) {
        this.visibleInterviews = [...event.detail.records]
    }

    connectedCallback() {
        getInterviewsPerWeek({CandidateId: this.recordId})
            .then(result => {
                this.dataPerWeek = result;
            })
            .catch(error => {
                this.error = error;
            })
        getInterviewsCount({CandidateId: this.recordId})
            .then(result => {
                this.dataCount = result;
            })
            .catch(error => {
                this.error = error;
            })
        getAllInterviews({CandidateId: this.recordId})
            .then(result => {
                this.dataAll = result;
                this.handleInterviewStage();
            })
            .catch(error => {
                this.error = error;
            })
    }

    //TODO: забрати консольлоги
    //TODO: позабиртаи пробели
    //TODO: забрати коменти
    //TODO: offeracept видалити нахер
    handleInterviewStage(){
        console.log(this.dataAll);
        for(let item of this.dataAll){
            console.log(item.Stage__c);
            if(item.Stage__c === 'Offer Sent' || item.Stage__c === 'Offer Signed' || item.Stage__c === 'Refused'){
                console.log(item.Stage__c);
                this.count++;
            }else if(item.Stage__c === 'Rejected by interviewer'){
                this.rejectedCount++;
            }
        }
        this.percentOffer = this.count/this.dataCount * 100;
        this.percentReject = this.rejectedCount/this.dataCount * 100;
    }

    handleRowAction(event){
        const row = event.detail.row.Id;
         window.open('/'+row);

        }


}
