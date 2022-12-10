public class AccountExtension {
    public String searchKey {get;set;}
    public List<Contact> cList {get; set;}
    public Id selectedRowId {get; set;}
    public Id pageAccId {get; set;}
    public AccountExtension(Apexpages.StandardController stController){
        pageAccId = Apexpages.CurrentPage().getParameters().get('id');
        doSearch();
    }

    public void doSearch(){
        if (searchKey == null) {
            cList = [SELECT AccountId, Name, Title, Phone, Is_Primary_Contact__c FROM Contact Where Contact.AccountId =:pageAccId ORDER BY Name ASC LIMIT 100];
        }
        if (searchKey != null) {
            cList = [SELECT AccountId, Name, Title, Phone, Is_Primary_Contact__c FROM Contact Where Name LIKE :'%'+searchKey+'%' AND Contact.AccountId =:pageAccId ORDER BY Name ASC LIMIT 100];
        }
    }

    public void choosePrimaryContact(){
        for(Contact contact : cList){
            
            if(contact.Id == selectedRowId){
                contact.Is_Primary_Contact__c = true;
            }
            else {
                contact.Is_Primary_Contact__c = false;
            }
        }
        update cList;
    }
}
