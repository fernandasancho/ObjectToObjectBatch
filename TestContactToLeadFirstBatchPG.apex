@isTest
public class TestContactToLeadFirstBatchPG {
    
    @testSetup
    static void setup() {
        
        List<User> owners = [SELECT id FROM user WHERE name = 'Boomi Integration User'];
        String boomiUserId = '';
        for(User u : owners){
            boomiUserId = u.id;
            break;
        }
       
        Contact c1 = new Contact(
            LastName = 'Dardis',
            FirstName = 'Stephanie',
            Email = 'stephaniedartest@aapt.net.au.invalid',
            Sevenrooms_Contact_Id__c = 'xxxzfnNldmVucm9vbXMtc2VjdXJlcicLEhpuaWdodGxvb3BfVmVudWVHcm91cENsaWVudBiAgKS-hJaiCgw',
            Status__c = 'Active',
            Gender__c = 'Female',
            Club__c = 'Greens',
            OwnerId = boomiUserId,
            LeadSource = '1 year member',
            Employee_Registration_ID__c = '912412',
            HasOptedOutOfEmail = false,
            eBet_Ref_Id__c = null
        );
        
        Contact c2 = new Contact(
            LastName = 'Hitch',
            FirstName = 'Jason',
            Email = 'jasontesth@cliffordchance.com.invalid',
            Sevenrooms_Contact_Id__c = 'xxxzfnNldmVucm9vbXMtc2VjdXJlcicLEhpuaWdodGxvb3BfVmVudWVHcm91cENsaWVudBiAgKTe-tKzCQw',
            Status__c = 'Active',
            Phone = '02 8922 8000',
            Gender__c = 'Female',
            Club__c = 'Greens',
            OwnerId = boomiUserId,
            LeadSource = '1 year member',
            Employee_Registration_ID__c = '921825',
            HasOptedOutOfEmail = false,
            eBet_Ref_Id__c = null
        );
        
        Contact c3 = new Contact(
            LastName = 'Williams',
            FirstName = 'Ben',
            Email = 'ben88williamstest@gmail.com.invalid',
            Sevenrooms_Contact_Id__c = 'xxxzfnNldmVucm9vbXMtc2VjdXJlcicLEhpuaWdodGxvb3BfVmVudWVHcm91cENsaWVudBiAgKT-9c_YCQw',
            Status__c = 'Active',
            Phone = '56726698',
            Gender__c = 'Female',
            OwnerId = boomiUserId,
            Club__c = 'Greens',
            LeadSource = '1 year member',
            Employee_Registration_ID__c = '919908',
            HasOptedOutOfEmail = false,
            eBet_Ref_Id__c = 'xyz987'
        );
        
        Contact c4 = new Contact(
            LastName = 'Green',
            FirstName = 'Tom',
            Email = 'tomgreen@gmail.com.invalid',
            Sevenrooms_Contact_Id__c = null,
            Status__c = 'Active',
            Phone = '52644698',
            Gender__c = 'Male',
            OwnerId = boomiUserId,
            Club__c = 'Greens',
            LeadSource = '1 year member',
            Employee_Registration_ID__c = '919908',
            HasOptedOutOfEmail = false,
            eBet_Ref_Id__c = 'abc123'
        );
        insert c1;
        insert c2; 
        insert c3;
        insert c4;
        
        Lead l3 = new Lead(
            LastName = 'Williams',
            FirstName = 'Ben',
            Email = 'ben88williamstest@gmail.com.invalid',
            Sevenrooms_Contact_Id__c = 'xxxzfnNldmVucm9vbXMtc2VjdXJlcicLEhpuaWdodGxvb3BfVmVudWVHcm91cENsaWVudBiAgKT-9c_YCQw',
            Company = 'Ben Williams Admin'
        );
        
        insert L3;
        
        Date appDate = Date.valueOf('2018-05-22');
        Date startDate = Date.valueOf('2018-06-22');
        Date endDate = Date.valueOf('2018-07-22');
        
        Application__c a1 = new Application__c(
        	Status__c = 'Handled',
            Application_Date__c	= appDate,
            Total_Fees__c = 20,
            Club__c = 'Seagulls',
            Member__c = c1.id
        );
        
        Application__c a2 = new Application__c(
        	Status__c = 'Handled',
            Application_Date__c	= appDate,
            Total_Fees__c = 20,
            Club__c = 'Seagulls',
            Member__c = c2.id
        );
        
        Application__c a3 = new Application__c(
        	Status__c = 'Handled',
            Application_Date__c	= appDate,
            Total_Fees__c = 20,
            Club__c = 'Seagulls',
            Member__c = c3.id
        );
        
        Application__c a4 = new Application__c(
        	Status__c = 'Handled',
            Application_Date__c	= appDate,
            Total_Fees__c = 20,
            Club__c = 'Seagulls',
            Member__c = c4.id
        );
        
        insert a1;
        insert a2; 
        insert a3;
        insert a4;
        
        Membership__c m1 = new Membership__c(
        	Start_Date__c = startDate,
            End_Date__c = endDate,
            Total_Fees__c = 10,
            Club_Fees__c = 10,
            Member__c = c1.id,
            Application__c = a1.id
        );
        
        Membership__c m2 = new Membership__c(
        	Start_Date__c = startDate,
            End_Date__c = endDate,
            Total_Fees__c = 10,
            Club_Fees__c = 10,
            Member__c = c2.id,
            Application__c = a2.id
        );
        
        Membership__c m3 = new Membership__c(
        	Start_Date__c = startDate,
            End_Date__c = endDate,
            Total_Fees__c = 10,
            Club_Fees__c = 10,
            Member__c = c3.id,
            Application__c = a3.id
        );
        
        Membership__c m4 = new Membership__c(
        	Start_Date__c = startDate,
            End_Date__c = endDate,
            Total_Fees__c = 10,
            Club_Fees__c = 10,
            Member__c = c4.id,
            Application__c = a4.id
        );
        
        insert m1;
        insert m2; 
        insert m3;
        insert m4;
        
        Campaign campaign1 = new Campaign(name = 'test campaign');
        
        insert campaign1; 
        
        CampaignMember cm = new CampaignMember(ContactId = c1.id, CampaignId = campaign1.Id, status = 'Responded');
        
        insert cm;
        
    }
    
    @isTest
    static void testContactToLeadFirstBatchPG() {

        // Start the batch process
        Test.startTest();
        ContactToLeadBatch batch = new ContactToLeadBatch();
        Database.executeBatch(batch);
        Test.stopTest();

        // Verify the results
        List<Lead> leads = [SELECT Id, LastName, FirstName, Email, Status, Phone, MobilePhone, Gender__c, OwnerId, Club__c, LeadSource,
                            Member_Type__c, Employee_Registration_ID__c, Birthdate__c, HasOptedOutOfEmail, Occupation__c, Residential_Street__c,
                            Residential_Suburb__c, Residential_Postcode__c, Residential_State__c, Residential_Country__c, Badge_No__c, Norths__c,
                            Organisation__c, Organisation_s_Industry__c, Last_Updated_from_Priava__c, Last_Updated_from_Ivvy__c, Fitness_Prospect__c,
                            Fitness_Prospect_LocationName__c, Northbridge_Soccer__c, Northern_Suburbs_Netball__c, Northbridge_Football_Club__c,
                            Northern_Suburbs_Netball_Association__c, Norths_Touch_Football__c, Poker__c, Last_Updated_from_Priava_Alcott__c,
                            Last_Updated_from_Priava_Greens__c, Last_Updated_from_Priava_Seagulls__c, Co_Working_Network__c,
                            Pennant_Hills_Cherrybrook_Stags__c, Northern_Suburbs_Rugby_Football_Club__c, Beecroft_Netball_Club__c,
                            Lane_Cove_Tigers__c, Other_Occupation_if_required__c, ID_Number__c, Ivvy_Member_Id__c,
                            Molly_s_Pavilion_Cheltenham_ModifiedDate__c, Norths_Cammeray_Modified_Date__c, Norths_Collective_Modified_Date__c,
                            Norths_Fitness_Modified_Date__c, Revolution_Health_Fitness_ModifiedDate__c, Seagulls_Tweed_Heads_Modified_Date__c,
                            The_Alcott_Lane_Cove_Modified_Date__c, The_Glasshouse_Artarmon_Modified_Date__c, The_Greens_North_Sydney_Modified_Date__c,
                            The_Verandah_Beecroft_Modified_Date__c, Gym_Status__c, Bangalow_Bluedogs_Soccer__c, Byron_Shire_Rebels_Rugby__c,
                            Bangalow_Netball__c, Bangalow_Cricket_Club__c, Bangalow_Fishing_Club__c, Bangalow_Ladies_Bowlers__c,
                            Bangalow_Men_s_Bowlers__c, Beecroft_Teachers__c
                            FROM Lead];
        System.assertEquals(3, leads.size(), 'wrong number of leads');
        
    }
    
    @isTest
    static void testContactToLeadEbet() {

        // Start the batch process
        Test.startTest();
        ContactToLeadBatch batch = new ContactToLeadBatch('ebet');
        Database.executeBatch(batch);
        Test.stopTest();

        // Verify the results
        List<Lead> leads = [SELECT Id, LastName, FirstName, Email, Status, Phone, MobilePhone, Gender__c FROM Lead];
        System.assertEquals(2, leads.size(), 'wrong number of leads');
        
    }
}