import { LightningElement } from 'lwc';

export default class LifeCycleHookExample extends LightningElement {
    constructor(){
        super();
        console.log("This is constructor and first Hook")
    }

    connectedCallback(){
        console.log("Call Recieved from Connected Call Back");
    }

    renderedCallback(){
        console.log("Render call back function calleld");
    }
    
}