public class OpportunityTriggerHandler {
	Set<Id> oppIdIn = new Set<Id>();
    Set<Id> oppExId = new Set<Id>();
    
        public void cloneOppExt(List<Opportunity> listOppIn){
            for(Opportunity opp:listOppIn ){
                String recordTypeName = Schema.SObjectType.Opportunity.getRecordTypeInfosById().get(opp.recordtypeid).getname();
                if(recordTypeName=='External'){
                    oppIdIn.add(opp.id);
                }
                if(oppIdIn.size()>0){
                    CloneAndUpdateOppUsingRestAPI.makePostCallout(oppIdIn);
                }
            }
    	}
        public void updateOppExt(List<Opportunity> listOppUp){
            for(Opportunity opp: listOppUp){
                String recordTypeName = Schema.SObjectType.Opportunity.getRecordTypeInfosById().get(opp.recordtypeid).getname();
                if(recordTypeName=='External'){
                    oppExId.add(opp.ExternalId__c);
                }
                if(oppExId.size()>0){
                    CloneAndUpdateOppUsingRestAPI.makePatchCallout(oppExId);
                }
            }
        }
    
}