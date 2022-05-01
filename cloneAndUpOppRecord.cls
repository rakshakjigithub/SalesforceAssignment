@RestResource(urlMapping='/cloneAndUpdateOpp/*')
global with sharing class cloneAndUpOppRecord {
	@HttpPost
    global static Id cloneOpp(){
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;
        string jsonString=req.requestBody.tostring();
        System.debug('JsonString-->>'+jsonString);
        responseWrapper wResp=(responseWrapper) JSON.deserialize(jsonString,responseWrapper.class);
        System.debug('WResp-->>'+wResp);
        Opportunity oppClone=new Opportunity();
        oppClone.name=wResp.oppName;
        oppClone.type=wResp.oppType;
        oppClone.StageName=wResp.oppStageName;
        oppClone.CloseDate=wResp.oppCloseDate;
        oppClone.Amount=wResp.oppAmount;
        insert oppClone;
        return oppClone.Id;
    }
    @HttpPatch
    global static Id updateOpp() {
        RestRequest request = RestContext.request;
        String oppId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        System.debug(oppId);
        Opportunity opp = [SELECT Id FROM Opportunity WHERE Id = :oppId];
        // Deserialize the JSON string into name-value pairs
        string jsonStr=request.requestBody.tostring();
        System.debug('JsonString-->>'+jsonStr);
        responseWrapper wRes=(responseWrapper) JSON.deserialize(jsonStr,responseWrapper.class);
        System.debug('WRes-->>'+wRes);
        //Opportunity opp=new Opportunity();
        opp.name=wRes.oppName;
        opp.type=wRes.oppType;
        opp.StageName=wRes.oppStageName;
        opp.CloseDate=wRes.oppCloseDate;
        opp.Amount=wRes.oppAmount;
        update opp;
        return opp.id;
    }
    public class responseWrapper{
        public string oppName;
        public String oppType;
        public String oppStageName;
        public Date oppCloseDate;
        public Decimal oppAmount;
    }
}