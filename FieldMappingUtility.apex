public class FieldMappingUtility {
    public static void copyFieldsFromContactToLeadFirstBatchPG(Contact contact, Lead lead, String runType) {
        
        if(runType != 'ebet'){
            lead.LastName = contact.LastName;
           // lead.FirstName = contact.Name;
            lead.FirstName = contact.FirstName;
            lead.Email = contact.Email;
            lead.Status = contact.Status__c;
            lead.Phone = contact.Phone;
            lead.MobilePhone = contact.MobilePhone;
            lead.Residential_Postcode__c = contact.Residential_Postcode__c;
            lead.PostalCode = contact.OtherPostalCode;
            lead.Gender__c = contact.Gender__c;
            lead.OwnerId = contact.OwnerId;
            //lead.Club__c = contact.Club__c;
            lead.LeadSource = contact.LeadSource;
            //lead.Member_Type__c = contact.Member_Type__c;
            lead.Employee_Registration_ID__c = contact.Employee_Registration_ID__c;
            lead.Birthdate__c = contact.BirthDate; 
            lead.HasOptedOutOfEmail = contact.HasOptedOutOfEmail;
            
            lead.Company = (contact.Company_Name__c == null?contact.FirstName + ' ' + contact.LastName: contact.Company_Name__c);
        
           // return;
            
            //lead.Occupation__c = contact.Occupation__c;
            //lead.Club__c = contact.Club__c;
            //lead.Member_Type__c = contact.Member_Type__c;
            //lead.Residential_Street__c = contact.Residential_Street__c;
            //lead.Residential_Suburb__c = contact.Residential_Suburb__c;
            lead.Residential_Postcode__c = contact.Residential_Postcode__c;
            //lead.Residential_State__c = contact.Residential_State__c;
            //lead.Residential_Country__c = contact.Residential_Country__c;
            //lead.Badge_No__c = contact.Badge_No__c;
            lead.Norths__c = contact.Norths__c;
            lead.Organisation__c = contact.Organisation__c;
            lead.Organisation_s_Industry__c = contact.Organisation_s_Industry__c;
            
            lead.Last_Updated_from_Priava__c = contact.Last_Updated_from_Priava__c;
            lead.Last_Updated_from_Ivvy__c = contact.Last_Updated_from_Ivvy__c;
            lead.Gender__c = contact.Gender__c;
            lead.Fitness_Prospect__c = contact.Fitness_Prospect__c;
            lead.Fitness_Prospect_LocationName__c = contact.Fitness_Prospect_LocationName__c;
            lead.Northbridge_Soccer__c = contact.Northbridge_Soccer__c;
            lead.Northern_Suburbs_Netball__c = contact.Northern_Suburbs_Netball__c;
            lead.Northbridge_Football_Club__c = contact.Northbridge_Football_Club__c;
            lead.Northern_Suburbs_Netball_Association__c = contact.Northern_Suburbs_Netball_Association__c;
            lead.Norths_Touch_Football__c = contact.Norths_Touch_Football__c;
            lead.Poker__c = contact.Poker__c;
            lead.Last_Updated_from_Priava_Alcott__c = contact.Last_Updated_from_Priava_Alcott__c;
            lead.Last_Updated_from_Priava_Greens__c = contact.Last_Updated_from_Priava_Greens__c;
            lead.Last_Updated_from_Priava_Seagulls__c = contact.Last_Updated_from_Priava_Seagulls__c;
            lead.Co_Working_Network__c = contact.Co_Working_Network__c;
            lead.Pennant_Hills_Cherrybrook_Stags__c = contact.Pennant_Hills_Cherrybrook_Stags__c;
            lead.Northern_Suburbs_Rugby_Football_Club__c = contact.Northern_Suburbs_Rugby_Football_Club__c;
            lead.Beecroft_Netball_Club__c = contact.Beecroft_Netball_Club__c;
            lead.Lane_Cove_Tigers__c = contact.Lane_Cove_Tigers__c;
            lead.Employee_Registration_ID__c = contact.Employee_Registration_ID__c;
            
            // below is a # api
            lead.Other_Occupation_if_required__c = contact.Other_Occupation_if_applicable__c;
            lead.ID_Number__c = contact.ID_Number__c;
            lead.Ivvy_Member_Id__c = contact.Ivvy_Member_Id__c;
            lead.Sevenrooms_Contact_Id__c = contact.Sevenrooms_Contact_Id__c;
            // below is # api
            lead.Molly_s_Pavilion_Cheltenham_ModifiedDate__c = contact.Molly_s_Pavilion_Cheltenham_Modified_Dat__c;
            lead.Norths_Cammeray_Modified_Date__c = contact.Norths_Cammeray_Modified_Date__c;
            lead.Norths_Collective__c = contact.Norths_Collective2__c;
            lead.Norths_Collective_Modified_Date__c = contact.Norths_Collective_Modified_Date__c;
            lead.Norths_Fitness__c = contact.Norths_Fitness2__c;
            lead.Norths_Fitness_Modified_Date__c = contact.Norths_Fitness_Modified_Date__c;
            lead.Revolution_Fitness_at_Seagulls__c = contact.Revolution_Fitness_at_Seagulls2__c;
            lead.Revolution_Health_Fitness_ModifiedDate__c = contact.Revolution_Health_Fitness_ModifiedDate__c;
            lead.Seagulls_Club__c = contact.Seagulls_Club2__c;
            lead.Seagulls_Tweed_Heads_Modified_Date__c = contact.Seagulls_Tweed_Heads_Modified_Date__c;
            lead.The_Alcott_Lane_Cove__c = contact.The_Alcott_Lane_Cove2__c;
            lead.The_Alcott_Lane_Cove_Modified_Date__c = contact.The_Alcott_Lane_Cove_Modified_Date__c;
            lead.Glasshouse__c = contact.Glasshouse2__c;
            lead.The_Glasshouse_Artarmon_Modified_Date__c = contact.The_Glasshouse_Artarmon_Modified_Date__c;
            lead.The_Greens_North_Sydney__c = contact.The_Greens_North_Sydney2__c;
            lead.The_Greens_North_Sydney_Modified_Date__c = contact.The_Greens_North_Sydney_Modified_Date__c;
            lead.D_The_Verandah_Beecroft__c = contact.The_Verandah_Beecroft2__c;
            lead.The_Verandah_Beecroft_Modified_Date__c = contact.The_Verandah_Beecroft_Modified_Date__c;
            
//          HasOptedOutOfMobile__c
//      PreMerge_PerfectGymMember_ID__c
//      LastSyncDate__c
//      SyncResponse__c
    
      lead.Fitness_Prospect_LocationName__c = contact.Gym_Name__c;

      lead.Sum_of_Functions_Bookings_last_12mo__c = contact.Sum_of_Functions_Bookings_last_12mo__c;
            lead.Sum_of_Functions_Bookings_lifetime__c = contact.Sum_of_Functions_Bookings_lifetime__c;
            lead.Sum_of_Reservations_last_12mo__c = contact.Sum_of_Reservations_last_12mo__c;
            lead.Sum_of_Reservations_lifetime__c = contact.Sum_of_Reservations_lifetime__c;
            
            lead.Gym_Status__c = contact.Gym_Status__c;
            lead.PerfectGymMember_ID__c = contact.PerfectGymMember_ID__c;
            lead.Bangalow_Bluedogs_Soccer__c = contact.Bangalow_Bluedogs_Soccer__c;
            lead.Byron_Shire_Rebels_Rugby__c = contact.Byron_Shire_Rebels_Rugby__c;
            lead.Bangalow_Netball__c = contact.Bangalow_Netball__c;
            lead.Bangalow_Cricket_Club__c = contact.Bangalow_Cricket_Club__c;
            lead.Bangalow_Fishing_Club__c = contact.Bangalow_Fishing_Club__c;
            lead.Bangalow_Ladies_Bowlers__c = contact.Bangalow_Ladies_Bowlers__c;
            lead.Bangalow_Men_s_Bowlers__c = contact.Bangalow_Men_s_Bowlers__c;
            lead.Beecroft_Teachers__c = contact.Beecroft_Teachers__c;
        } else {
            lead.LastName = contact.LastName;
            lead.FirstName = contact.FirstName;
            lead.Email = contact.Email;
            lead.Status = contact.Status__c;
            lead.Phone = contact.Phone;
            lead.MobilePhone = contact.MobilePhone;
            lead.Residential_Postcode__c = contact.Residential_Postcode__c;
            lead.Gender__c = contact.Gender__c;
            lead.Company = (contact.Company_Name__c == null?contact.FirstName + ' ' + contact.LastName: contact.Company_Name__c);
        }

    }
    
    public static void copyFieldsFromContactToLeadSecBatchEbet(Contact contact, Lead lead) {
      copyFieldsFromContactToLeadFirstBatchPG(contact, lead, 'ebet');    
  }
}