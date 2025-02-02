import { LightningElement } from 'lwc';

export default class ListChildComponent extends LightningElement {
    chilemessage=""
    handleinput(event){
        this.chilemessage=event.target.value
    }

    handleClick(event){
        console.log(this.chilemessage)
        let evt=new CustomEvent('send',{detail:this.chilemessage,bubbles:true})
        this.dispatchEvent(evt)
    }

}