import { LightningElement } from 'lwc';

export default class RenderConditionalTemplate extends LightningElement {
    isVissible=true;
    handleClick=()=>{
        if(this.isVissible){
            this.isVissible=false
        }else{
            this.isVissible=true
        }
    }
}