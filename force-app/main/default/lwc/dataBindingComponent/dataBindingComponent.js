import { LightningElement } from 'lwc';

export default class DataBindingComponent extends LightningElement {
    firstName='Rohan'
    name=''

    handleNameEnter(event){
        this.name=event.target.value;
    }
}