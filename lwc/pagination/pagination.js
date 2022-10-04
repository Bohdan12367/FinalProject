import { LightningElement, api } from 'lwc';


export default class Pagination extends LightningElement {
    allRecords;
    recordSize = 5;
    currentPage = 1;
    totalPages = 0;
    visibleRecords;

    get records() {
        return this.visibleRecords;
    }
    @api
    set records(data) {
        if (data) {
            this.allRecords = data;
            this.visibleRecords = data.slice(0, this.recordSize);
            this.totalPages = Math.ceil(data.length / this.recordSize);
            this.updateRecords();
            this.currentPage = 1;
        }
    }
    get disablePrevious() {
        return this.currentPage <= 1;
    }

    get disableNext() {
        return this.currentPage >= this.totalPages;
    }

    previousPage() {
        if (this.currentPage > 1) {
            this.currentPage = this.currentPage - 1;
            this.updateRecords();
        }
    }
    nextPage() {
        if (this.currentPage < this.totalPages) {
            this.currentPage = this.currentPage + 1;
            this.updateRecords();
        }
    }

    updateRecords() {
        const start = (this.currentPage - 1) * this.recordSize;
        const end = this.recordSize * this.currentPage;
        this.visibleRecords = this.allRecords.slice(start, end)
        this.dispatchEvent(new CustomEvent('update', {
            detail: {
                records: this.visibleRecords
            }
        }))
    }
}
