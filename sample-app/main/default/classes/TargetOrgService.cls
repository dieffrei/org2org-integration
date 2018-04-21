public class TargetOrgService {
    
    public class SFEnvelope {
        public List<Account> records {get;set;}
    }
    
    private static final String ACCOUNTS_SOQL = 'SELECT Id, Name FROM Account LIMIT 10';
    
    public static List<Account> fetchAccounts() {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:TargetOrg/services/data/v41.0/query/?q=' + EncodingUtil.urlEncode(ACCOUNTS_SOQL, 'utf-8'));
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        Http http = new Http();
        HttpResponse response = http.send(request);
        String jsonResponse = response.getBody();
        SFEnvelope envelope = (SFEnvelope)JSON.deserialize(jsonResponse, SFEnvelope.class);
        return envelope.records;
    }
}