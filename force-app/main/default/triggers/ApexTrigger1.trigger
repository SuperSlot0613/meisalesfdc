trigger ApexTrigger1 on Account (before update) {
    Account a=Trigger.new[0];
    a.Name=a.Name + 'Limitted';

}