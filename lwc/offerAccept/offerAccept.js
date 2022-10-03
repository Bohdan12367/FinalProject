
import {LightningElement,api,wire} from 'lwc';
import updateStageSuccess from '@salesforce/apex/OfferAcceptController.updateStageSuccess';
import updateStageUnSuccess from '@salesforce/apex/OfferAcceptController.updateStageUnSuccess';
import getInterviews from '@salesforce/apex/OfferAcceptController.getInterviews';
import {refreshApex} from "@salesforce/apex";

export default class OfferAccept extends LightningElement {
    @api recordId;

    @wire(getInterviews, { InterviewId: '$recordId' })
    record;

    stageSuccess(){
        updateStageSuccess({InterviewId: this.recordId})
            .then(result => window.location.reload)
            .catch(error => console.log(error))
    }
    stageUnSuccess(){
        updateStageUnSuccess({InterviewId: this.recordId})
            .then(result => window.location.reload)
            .catch(error => console.log(error))
    }
}
