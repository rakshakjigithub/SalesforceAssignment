trigger OpportunityTrigger on Opportunity (after insert, after update) {
    OpportunityTriggerHandler oppHandler = new OpportunityTriggerHandler();
    	if(Trigger.isAfter && Trigger.isInsert ){
        	oppHandler.cloneOppExt(Trigger.new);
        }
        if(Trigger.isAfter && Trigger.isUpdate && !System.isFuture()){
            oppHandler.updateOppExt(Trigger.new);
        }
}