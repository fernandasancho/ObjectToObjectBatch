public class ContactToLeadBatch implements Database.Batchable<sObject>, Database.Stateful, Schedulable  {
    
    public string runType = 'non-ebet';
    
    public ContactToLeadBatch(){
        this('non-ebet');
    }
    
    public ContactToLeadBatch(String rType){
        this.runType = rType;
    }
    
    public void execute(SchedulableContext SC) {
      Id batchJobId = Database.executeBatch(new ContactToLeadBatch(), 100);
     }
    
    public Database.QueryLocator start(Database.BatchableContext BC) {
        
        // Query for the Contacts
        String query = 'SELECT Id, Email, Membership_Expiry__c, PerfectGymMember_ID__c, Sevenrooms_Contact_Id__c, Is_Deletion_Flagged__c, ' +
            'FirstName, LastName, Company_Name__c, Status__c, Phone, MobilePhone, Gender__c, OwnerId, Club__c, LeadSource, Member_Type__c, ' +
            'Employee_Registration_ID__c, BirthDate, BirthDay__c, HasOptedOutOfEmail, Occupation__c, Residential_Street__c, Residential_Suburb__c, ' +
            'Residential_Postcode__c, Residential_State__c, Residential_Country__c, Badge_No__c, Norths__c, Organisation__c, Organisation_s_Industry__c, ' +
            'Last_Updated_from_Priava__c, Last_Updated_from_Ivvy__c, Fitness_Prospect__c, Fitness_Prospect_LocationName__c, Northbridge_Soccer__c, ' +
            'Northern_Suburbs_Netball__c, Northbridge_Football_Club__c, Northern_Suburbs_Netball_Association__c, Norths_Touch_Football__c, Poker__c, ' +
            'Last_Updated_from_Priava_Alcott__c, Last_Updated_from_Priava_Greens__c, Last_Updated_from_Priava_Seagulls__c, Co_Working_Network__c, ' +
            'Pennant_Hills_Cherrybrook_Stags__c, Northern_Suburbs_Rugby_Football_Club__c, Beecroft_Netball_Club__c, Lane_Cove_Tigers__c, ' +
            'Other_Occupation_if_applicable__c , ID_Number__c, Ivvy_Member_Id__c, Molly_s_Pavilion_Cheltenham_Modified_Dat__c , ' +
            'Norths_Cammeray_Modified_Date__c, Norths_Collective_Modified_Date__c, Norths_Fitness_Modified_Date__c, Revolution_Health_Fitness_ModifiedDate__c, ' +
            'Seagulls_Tweed_Heads_Modified_Date__c, The_Alcott_Lane_Cove_Modified_Date__c, The_Glasshouse_Artarmon_Modified_Date__c, ' +
            'The_Greens_North_Sydney_Modified_Date__c, The_Verandah_Beecroft_Modified_Date__c, Gym_Status__c, ' +
            'Bangalow_Bluedogs_Soccer__c, Byron_Shire_Rebels_Rugby__c, Bangalow_Netball__c, Bangalow_Cricket_Club__c, Bangalow_Fishing_Club__c, ' +
            'Bangalow_Ladies_Bowlers__c, Bangalow_Men_s_Bowlers__c, Beecroft_Teachers__c, OtherPostalCode, ' +
            'Norths_Collective2__c , Norths_Fitness2__c, Revolution_Fitness_at_Seagulls2__c, Seagulls_Club2__c, ' + 
            'The_Alcott_Lane_Cove2__c, Glasshouse2__c, The_Greens_North_Sydney2__c, The_Verandah_Beecroft2__c, ' +
            'Gym_Name__c, Sum_of_Functions_Bookings_last_12mo__c, Sum_of_Functions_Bookings_lifetime__c, ' +
            'Sum_of_Reservations_last_12mo__c, Sum_of_Reservations_lifetime__c ' + 
            'FROM Contact ' +
            'WHERE Membership_Expiry__c < 2020-01-01 ' +
            //'AND Id = \'0039h00000LZ39KAAT\'' +
            'AND Is_Deletion_Flagged__c = false ';
        
        if(runType != 'ebet'){
            query += 'AND (PerfectGymMember_ID__c != null OR Sevenrooms_Contact_Id__c != null OR Ivvy_Member_Id__c != null) ';
        } else {
            query += 'AND eBet_Ref_Id__c != null ';
        }
        
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<Contact> scope) {
        List<Lead> leadsToInsert  = new List<Lead>();
        List<Lead> leadsToUpdate = new List<Lead>();
        Map<Id, Lead> contactToLeadMap = new Map<Id, Lead>();
        system.debug('start');
        
        system.debug('scope' + scope);        
        // Iterate over the contacts
        for (Contact con : scope) {
            // Check if there is a matching lead record 
            
            List<Lead> existingLeads = new List<Lead>();
            if(runType != 'ebet'){
                existingLeads = [SELECT Id, FirstName, LastName, company, Email, Status, Phone, MobilePhone, Residential_Postcode__c, Gender__c,
                                 OwnerId, Club__c, LeadSource, Member_Type__c, Employee_Registration_ID__c, Birthdate__c, HasOptedOutOfEmail,
                                 Occupation__c, Residential_Street__c, Residential_Suburb__c, Residential_State__c, Residential_Country__c,
                                 Badge_No__c, Norths__c, Organisation__c, Organisation_s_Industry__c, Last_Updated_from_Priava__c, Last_Updated_from_Ivvy__c,
                                 Fitness_Prospect__c, Fitness_Prospect_LocationName__c, Northbridge_Soccer__c, Northern_Suburbs_Netball__c,
                                 Northbridge_Football_Club__c, Northern_Suburbs_Netball_Association__c, Norths_Touch_Football__c, Poker__c, 
                                 Last_Updated_from_Priava_Alcott__c, Last_Updated_from_Priava_Greens__c, Last_Updated_from_Priava_Seagulls__c,
                                 Co_Working_Network__c, Pennant_Hills_Cherrybrook_Stags__c, Northern_Suburbs_Rugby_Football_Club__c,
                                 Beecroft_Netball_Club__c, Lane_Cove_Tigers__c, Other_Occupation_if_required__c, ID_Number__c, Ivvy_Member_Id__c,
                                 Sevenrooms_Contact_Id__c, Molly_s_Pavilion_Cheltenham_ModifiedDate__c, Norths_Cammeray_Modified_Date__c,
                                 Norths_Collective_Modified_Date__c, Norths_Fitness_Modified_Date__c, Revolution_Health_Fitness_ModifiedDate__c,
                                 Seagulls_Tweed_Heads_Modified_Date__c, The_Alcott_Lane_Cove_Modified_Date__c, The_Glasshouse_Artarmon_Modified_Date__c,
                                 The_Greens_North_Sydney_Modified_Date__c, The_Verandah_Beecroft_Modified_Date__c, Gym_Status__c, PerfectGymMember_ID__c,
                                 Bangalow_Bluedogs_Soccer__c, Byron_Shire_Rebels_Rugby__c, Bangalow_Netball__c, Bangalow_Cricket_Club__c, Bangalow_Fishing_Club__c,
                                 Bangalow_Ladies_Bowlers__c, Bangalow_Men_s_Bowlers__c, Beecroft_Teachers__c FROM Lead WHERE 
                                 (PerfectGymMember_ID__c = :con.PerfectGymMember_ID__c AND PerfectGymMember_ID__c != null) OR
                                 (Sevenrooms_Contact_Id__c = :con.Sevenrooms_Contact_Id__c AND Sevenrooms_Contact_Id__c != null) OR
                                 (Ivvy_Member_Id__c = :con.Ivvy_Member_Id__c AND Ivvy_Member_Id__c != null) LIMIT 1];
            } else {
                existingLeads = [SELECT Id, FirstName, LastName, Company, Email, Phone, MobilePhone, Residential_Postcode__c, Gender__c
                        FROM Lead WHERE FirstName =: con.FirstName AND LastName =: con.LastName AND Email =: con.Email LIMIT 1];
            }
            
            if (existingLeads.isEmpty()) {
                
                Lead newLead = new Lead();
                system.debug('new lead');
                // Use utility class to copy fields
                FieldMappingUtility.copyFieldsFromContactToLeadFirstBatchPG(con, newLead, runType);
                if(newLead.Status == null){
                    newLead.Status = 'New';
                }
                leadsToInsert.add(newLead);
                contactToLeadMap.put(con.Id, newLead);
            } else {
                system.debug('existing lead');  
                //contactToLeadMap.put(con.Id, existingLead);
                Lead existingLead = existingLeads[0];
                
                // Update existing lead with contact fields
                FieldMappingUtility.copyFieldsFromContactToLeadFirstBatchPG(con, existingLead, runType);
                if(existingLead.Status == null){
                    existingLead.Status = 'New';
                }
                leadsToUpdate.add(existingLead);
                contactToLeadMap.put(con.Id, existingLead);
            }
        }
        
        system.debug('contactToLeadMap '+ contactToLeadMap);
        
        system.debug('leads to insert ' + leadsToInsert.isEmpty() + ' ' + leadsToInsert.size());
        if (leadsToInsert.size() > 0) {
            insert leadsToInsert;
        }
        system.debug('leads to update ' + leadsToUpdate.isEmpty() + ' ' + leadsToUpdate.size());
        if (leadsToUpdate.size() > 0) {
            update leadsToUpdate;
        }
        
        // Reparent the related records - It takes a map of Contact Ids to Lead records
        reparentRelatedRecords(contactToLeadMap);
        
        updateContacts(scope);
    }
    
    public void finish(Database.BatchableContext BC) {
        // Add any finishing logic here- what to add??
    }
    
    /* contactToLeadMap: The map with the mapping of Contact Ids to Lead records.
    relatedObjectName: The API parameter of the related object
    contactField: The API of the field on the related object that references the Contact (lookup contact)
    leadField: The API of the field on the related object that holds the referece to new lead after reparenting (lookup lead) */
    
    private void reparentRelatedRecords(Map<Id, Lead> contactToLeadMap) {
        //need to modify the below APIs for Contact and Lead
        //reparentRelatedRecordsByObject(contactToLeadMap, 'Application__c', 'Member__c', 'Applicant__c');
        reparentRelatedRecordsByObject(contactToLeadMap, 'Function_Bookings__c', 'Related_Contact__c', 'Related_Lead__c');
        reparentRelatedRecordsByObject(contactToLeadMap, 'Reservations__c', 'Related_Contact__c', 'Related_Lead__c');
        reparentRelatedRecordsByObject(contactToLeadMap, 'Member_Gym_Subscription__c', 'Related_Contact_Member__c', 'Related_Lead_Member__c');
        reparentRelatedRecordsByObject(contactToLeadMap, 'Gym_Visit__c', 'Related_Contact_Member__c', 'Related_Lead_Member__c');
        //reparentRelatedRecordsByObject(contactToLeadMap, 'CampaignMember', 'ContactId', 'LeadId'); //example
        reparentRelatedRecordsByObject(contactToLeadMap, 'Marketing_Communications__c', 'Contact__c', 'Lead__c');
        reparentRelatedRecordsByObject(contactToLeadMap, 'Campaign', 'Contact_Name__c', 'Lead_Name__c');
        
        migrateCampaigns(contactToLeadMap);
    }
    
    private void migrateCampaigns(Map<Id, Lead> contactToLeadMap){
        List<CampaignMember> toCreate = new List<CampaignMember>();
        List<CampaignMember> cms = [SELECT id, CampaignId, LeadId, ContactId, Status, HasResponded, FirstRespondedDate, Salutation, Name, 
                                    FirstName, LastName, Title, Street, City, State, PostalCode, Country, Email, Phone, Fax, MobilePhone, 
                                    Description, DoNotCall, HasOptedOutOfEmail, HasOptedOutOfFax, LeadSource, CompanyOrAccount, Type, 
                                    Booking_Reference_Number__c, Seat_ID__c, POH__c, Zone_ID__c, Seat_Zone__c, Seats__c, Seat_Attribute__c, 
                                    Primary_Event_Interest_Code_ID__c, Primary_Event_Interest_Code__c, Transaction_Date__c, Transaction_Time__c, 
                                    Despatch_Method__c, Price_Band__c, Discount__c, Unit_Price__c, Tickets__c, Interests__c, External_Id__c, 
                                    et4ae5__Activity__c, Estimated_Booking_Price__c, UniqueShowId__c, Is_Ticket_Cancelled__c, Ticket_Cancelled_Date__c,
                                    Ticket_Cancelled_Time__c, Event_Rating__c, Survey_Submitted__c, Survey_Response__c, First_Name__c, Last_Name__c, 
                                    Email__c, Mobile__c, SR_Booking_Price__c, Transaction_Datetime__c, CNF_2023_Fitness_PRIZE__c
                                    FROM CampaignMember WHERE ContactId in: contactToLeadMap.keySet()];
        for(CampaignMember cm : cms){
            CampaignMember newCM = cm.clone(false, true, true, false);
            Lead l = contactToLeadMap.get(cm.contactId);
            newCM.LeadId = l.Id;
            newCM.ContactId = null;
            system.debug(newCM);
            toCreate.add(newCM);
        }
        
        if(toCreate.size() > 0){
            insert toCreate;
            delete cms;
        }
    }
    
    private void reparentRelatedRecordsByObject(Map<Id, Lead> contactToLeadMap, String relatedObjectName, String contactField, String leadField) {
        
        //To fetch all records of the related object where the contactField matches any Contact ID in the contactToLeadMap
        
        String keyValues = String.join(contactToLeadMap.keySet(), '\',\'');
        if(keyValues != ''){
            keyValues = '\'' + keyValues + '\'';
        }
        system.debug(keyValues);       
        String query = 'SELECT Id, ' + contactField + ', ' + leadField + ' FROM ' + relatedObjectName + ' WHERE ' + contactField + ' IN (' + keyValues +')';
        system.debug(query);
        // Execute the query and get related records
        List<SObject> relatedRecords = Database.query(query);
        
        //Iterate over the fetched related records
        for (SObject record : relatedRecords) {
            
            // Get the Contact ID from the related record's contactField
            Id contactId = (Id) record.get(contactField);
            
            // Get the corresponding Lead from the map
            Lead correspondingLead = contactToLeadMap.get(contactId);
            
            system.debug('correspondingLead: ' + correspondingLead);
            
            if (correspondingLead != null && correspondingLead.Id != null) {
                // Set the new lead reference only if correspondingLead is not null and its ID is not null
                record.put(leadField, correspondingLead.Id); 
                
                // Remove old contact reference
                record.put(contactField, null);
                
                system.debug('record' + record);
            } else {
                // Handle the case where correspondingLead is null or its ID is null 
                System.debug('Failed to find corresponding lead for contact: ' + contactId);
            }
            
        }
        if (!relatedRecords.isEmpty()) {
            Database.update(relatedRecords, false);
        }
    }
    
    private void updateContacts(List<Contact> scope) {
        for (Contact con : scope) {
            con.Is_Deletion_Flagged__c = true;
        }
        update scope;
    } 
    
}