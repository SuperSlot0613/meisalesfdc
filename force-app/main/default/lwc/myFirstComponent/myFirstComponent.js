import { LightningElement } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent'

export default class MyFirstComponent extends LightningElement {
    mytitle='My fiest component'

    // connectedCallback(){
    //     const name="Salesforce Noob"
    //     name="Noob"
    //     if(this.mytitle){
    //         window.alert("Name const : "+name);
    //     }
    // }
    handleclick(event){
        this.ShowToast();
    }

    ShowToast(){
        const event=new ShowToastEvent({
            title:'Show toast demo',
            message:'Want to show example',
            variant:'error'
        })
        this.dispatchEvent(event);
    }

}