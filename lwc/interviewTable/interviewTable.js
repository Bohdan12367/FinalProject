import {api, LightningElement, wire} from 'lwc';
import getInterviews from '@salesforce/apex/InterviewTableController.getInterviews';
import {NavigationMixin} from "lightning/navigation";

// const actions = [
//     {label : 'View', name:'view'},
// ];

const columns = [
    // {label: 'Id',fieldName: 'Id'},
    { label: 'Name Interview', fieldName: 'Name'},
    //     type: "url",
    //     typeAttributes: { label: { fieldName: "Interview" }, tooltip:"Interview", target: "_blank"}
    // },
    { label: 'Status Interview', fieldName: 'Stage__c'},
    // {
    //     type:'action',
    //     typeAttributes : {rowActions: actions},
    // },
];
export default class InterviewTable extends LightningElement {
    @api recordId;

    data = [];
    columns = columns;
    error;
    record = {};

    connectedCallback() {
        console.log(this.recordId);
        getInterviews({CandidateId: this.recordId})
            .then(result =>{
                this.data = result;
                // let temp = [];
                // for(let x=0;x<result.length;x++){
                //     let tempRecord = Object.assign({}, result[x]); //cloning object
                //     tempRecord.LinkUrl = "/" + tempRecord.Id;
                //     temp.push(tempRecord);
                // }
                // this.data = temp;
            })
            .catch(error =>{
                this.error = error;
            })
    }

    handleRowAction(event){
        console.log(event.detail.row.Id)
        //const actionName = event.detail;
        //const row = event.detail.row.Id;
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: event.detail.row.Id,
                    //objectApiName : 'Interview__c',
                    actionName: 'view'
                }
            });

        }


}
