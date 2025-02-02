import { LightningElement,wire } from 'lwc';
import getHighRevenueAccountRecords from '@salesforce/apex/AccountController.getHighRevenueAccountRecords';

export default class HighRevenueAccount extends LightningElement {
    accountToDisplay=[]
    countofRecords=5

    connectedCallback(){
        getHighRevenueAccountRecords({count:this.countofRecords}).then(response=>{
            console.log("Response using imperative approach",response);
            this.accountToDisplay=response;
        }).catch(error=>{
            console.error('Error',error)
        })
    }

    setCount(event){
        console.log('Value',event.target.value)
        let inputValue=event.target.value;
        if(inputValue=='') return;
        this.countofRecords=inputValue;
        getHighRevenueAccountRecords({count:this.countofRecords}).then(response=>{
            console.log('Response using imperative approach',response)
            this.accountToDisplay=response;
        }).catch(error=>{
            console.error('Error',error)
        })

    }

    // @wire(getHighRevenueAccountRecords)
    // getAccountHandler(response){
    //     const {data,error}=response
    //     if(error){
    //         console.log(error)
    //         return
    //     }
    //     if(data){
    //         this.accountToDisplay=data;
    //     }
    // }
}