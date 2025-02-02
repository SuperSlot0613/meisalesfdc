import { LightningElement } from 'lwc';

export default class FormParentComponent extends LightningElement {
    chilemessage="No chile message"
    handlechil(event){
        this.chilemessage=event.detail
    }
}