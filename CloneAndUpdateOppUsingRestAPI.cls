public class CloneAndUpdateOppUsingRestAPI {
    public class OppWrap{
        public string oppName;
        public String oppType;
        public String oppStageName;
        public Date oppCloseDate;
        public Decimal oppAmount; 
        public oppWrap(String oppName,String oppType,String oppStageName,Date oppCloseDate,Decimal oppAmount)
        {
            this.oppName =oppName;
            this.oppType =oppType;
            this.oppStageName =oppStageName;
            this.oppCloseDate =oppCloseDate;
            this.oppAmount =oppAmount;
        } 
    }
    @future(callout=true)
	public static void makePostCallout(Set<Id> oppInIdSet) {
        
        //list<Opportunity> inOppList= (list<Opportunity>)JSON.deserialize(oppInList,list<Opportunity>.class);
        List<Opportunity> oppList=new List<Opportunity>();
        for(Opportunity op: [select id,name,amount,type,stageName,closeDate,AccountId,ExternalId__c from Opportunity where id in: oppInIdSet]){
            oppWrap oppObj=new oppWrap(op.Name,op.Type,op.StageName,op.CloseDate,op.Amount);
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('callout:OrgB/services/apexrest/cloneAndUpdateOpp');
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            System.debug('JSON'+JSON.serialize(oppObj));
            request.setBody(JSON.serialize(oppObj));
            HttpResponse response = http.send(request);
            System.debug('response'+response.getBody());
            Id exId = response.getBody().replace('"','');
            Opportunity oppo=new Opportunity();
            oppo.id=op.id;
            oppo.ExternalID__c=exId;
            oppList.add(oppo);
            // Parse the JSON response
            if(response.getStatusCode() != 201) {
                System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
            } else {
                System.debug(exId);
            }
        }
        if(oppList.size()>0){
            update oppList;
        }
        
    }
    @future(callout=true)
    public static void makePatchCallout(Set<Id> oppExIdSet) {
        
        //list<Opportunity> upOppList= (list<Opportunity>)JSON.deserialize(oppUpList,list<Opportunity>.class);
        for(Opportunity o: [select id,name,amount,type,stageName,closeDate,Account.name,ExternalId__c from Opportunity where ExternalId__c in: oppExIdSet]){
            oppWrap oppObj1=new oppWrap(o.Name,o.Type,o.StageName,o.CloseDate,o.Amount);
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            Id eId = o.externalId__c;
            System.debug(eId);
            request.setEndpoint('callout:OrgB/services/apexrest/cloneAndUpdateOpp/'+ eId);
            request.setMethod('PATCH');
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            System.debug('JSON'+JSON.serialize(oppObj1));
            request.setBody(JSON.serialize(oppObj1));
            HttpResponse response = http.send(request);
            // Parse the JSON response
            if(response.getStatusCode() != 201) {
                System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
            } else {
                System.debug(response.getBody());
            }
        }
        
    }        
}