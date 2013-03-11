#-------------------------------------------------------------#
#  RazooTestSuite Class
#
# Author: EBI,SDR and SID
# Date: 4-OCT-2010
# Description:  It is a Class which contains all the methods thats need to be Executed
#
# Change history:
# 5-OCT-2010  - Added createFundraise scenarios.
# 13-OCT-2010 - Fine tuned few codes and added grantOrgAdminRights() method
# 14-OCT-2010 - Added scenario 4. 5, 6 and 7.
# 15-OCT-2010 - Included Facebook pop up code.
# 21-OCT-2010 - Included Share page code.
# -------------------------------------------------------------#
require "test/unit"
require "rubygems"
require "selenium/client"
require "Razoo_Test_Cases_Explorer.rb"


class RazooTestSuite < Test::Unit::TestCase

	#This method helps to invoke the Razoo Site
	def test_00_setup_razoo()
		
		invokeRazooSite()	
	end
	
# --------------------------------------------------------------------------------------------------------------------#
#SCENARIO 1 : AS A GUEST USER ISBAT DONATE AND SHARE THE STORY PAGE THROUGH EMAIL
# --------------------------------------------------------------------------------------------------------------------#
	
	def test_01_guestuser_share_story()
		
		puts "------------------------ START OF SCENARIO 1 --------------------"
		searchOrg("Harvard College")
		donateUsingNewCard("10.00", "Sample UserIE2", "2nd Street", "Washington DC", 
					"Washington", "95008", "4111111111111111", "123", "sampleuserie@aol.com")
		guestUserSharePage("sharepage@aol.com")
		puts "------------------------ END OF SCENARIO 1 --------------------"
	end	

# -----------------------------------------------------------------------------------------------------#
#SCENARIO 2 : AS A GUEST USER ISBAT DONATE TO ORG AND CREATE AN ACCOUNT.
# -----------------------------------------------------------------------------------------------------#
	
	def test_02_guestuser_donation_ORG()
		
		puts "------------------------ START OF SCENARIO 2 --------------------"
		searchOrg("Harvard College")
		donateUsingNewCard("10.00", "Sample UserIE2", "2nd Street", "Washington DC", 
					"Washington", "95008", "4111111111111111", "123", "sampleuserie@aol.com")
		createRazooAccount("Sample", "UserIE", "normaltrunk@razooiExplorer7.com", "123456")
		puts "------------------------ END OF SCENARIO 2 --------------------"
	end


# --------------------------------------------------------------------------------------------------------------------------------------#
#SCENARIO 3 : AS A NORMAL USER ISBAT CREATE FUNDRAISE PAGE, DONATE TO  FR, SHARE STORY THORUGH 
#		    EMAIL AND POST COMMENT IN DONOR AND FACEBOOK.
# --------------------------------------------------------------------------------------------------------------------------------------#
	def test_03_normaluser_share_donation_FR_NewCard()
		
		puts "------------------------  START OF SCENARIO 3 ----------------------- "
		searchOrg("Harvard College")
		createStoryPage("Harvard College", "RazooTrunkiExplorerFR2 for Harvard College", "Summary Part ", "Story Part", 
				"http://www.youtube.com/watch?v=HNVSI_r9SVg" , "With Designation", 
				"100",  "link=31", "link=Donations", "10", "Suggested Amount")
		donateUsingNewCard("10.50", "Sample UserIE", "2nd Street", "Washington DC", 
				"Washington", "95008", "4111111111111111", "123", "normal@razooiExplorer7.com")
		normalUserSharePage("sharepage@aol.com")
		postComments("Give and be Blessed!!", "fbuser1@rediffmail.com", "111111")
		
		puts "------------------------  END OF SCENARIO 3 ----------------------- "
	end


# ------------------------------------------------------------------------------------------------------------------------------------------------------#
#SCENARIO 4 : AS AN ORG ADMIN USER ISBAT CREATE PROEJCT PAGE, DONATE TO PROJECT, WITH TIPS, 
#		    USING SUGGESTED AMOUNT AND POST COMMENT in DONOR WALL.
#
# PRE - CONDITION : 
#	Provide admin rights to the emailId which is passed in the Login Function.
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	def test_03_orgadmin_donation_PRO_SavedCard()
		
		puts "---------------------- START OF SCENARIO 4 ----------------------"
		# PRE - CONDITION - START
		logout()
		login("ebi@srasys.co.in", "123456")
		grantOrgAdminRights("/admin", "normaltrunk@razooiExplorer7.com", "042103580")
		logout()
		# PRE - CONDITION - END
		login("normaltrunk@razooiExplorer7.com", "123456")
		createStoryPage("Harvard College", "RazooTrunkiExplorerPRO2 of Minnesota Community Foundation", "Summary Part ", "Story Part", 
				"http://www.youtube.com/watch?v=HNVSI_r9SVg" , "With Designation", 
				"100",  "link=31", "link=Donations", "10", "Suggested Amount")
		donateUsingSavedCard("10.00",  "9.00")
		puts "---------------------- END OF SCENARIO 4 --------------------------"
	end

# ------------------------------------------------------------------------------------------------------------------------------------------------------#
#SCENARIO 4 : AS AN ORG ADMIN, ISBAT TO MAKE AN ANONYMOUS  RECURRING DONATION TO FR AND POST COMMENT
#		    IN DONOR WALL AND FACEBOOK, DELETE THE COMMENT AND REMOVE THE STORY FROM THE "Causes I'm a Fan of" LIST.
#
#~ # ------------------------------------------------------------------------------------------------------------------------------------------------------#
	def test_05_AddNewCard_deletecomment_removefan()
		
		puts "---------------------- START OF SCENARIO 5 ----------------------"
		searchOrg("Harvard College")
		donateUsingAddCreditCard("10.00", "Mr Oct5", "2nd Street", "Washington DC",  "Washington", "95008",
						  "378282246310005", "1234", "label=Weekly")
		normalUserSharePage("sharepage@aol.com")
		deleteComments("Delete this comment")
		removeFan("RazooiTrunkExplorerFR2 for Harvard College")
		puts "---------------------- END OF SCENARIO 5 --------------------------"
	end

# ------------------------------------------------------------------------------------------------------------------------------------------------------#
#SCENARIO 6 : AS AN ORG ADMIN, ISBAT TO MAKE AN ANONYMOUS DONATION TO FR AND POST COMMENT IN DONOR WALL 
#		    AND FACEBOOK, DELETE THE COMMENT AND REMOVE THE STORY FROM THE "Causes I'm a Fan of" LIST.
#
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	def test_06_cancelrecurringdonation_deletecard()
		
		puts "------- START OF SCENARIO 6 ----------"
		cancelRecurringDonation()
		deleteStoredCard()
		logout()
		puts "------- END OF SCENARIO 6 ------------"
	end


# ------------------------------------------------------------------------------------------------------------------------------------------------------#
#SCENARIO 6 : AS ANY USER, ISBAT RESEST MY PASSWORD IN MY USER PROFILE SCREEN.
#
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	def test_07_change_mypassword()
		
		puts "---------------------- START OF SCENARIO 7 ----------------------"
		login("normaltrunk@razooiExplorer7.com", "123456")
		changeMyPassword("1234567")
		logout()
		login("normaltrunk@razooiExplorer7.com", "1234567")
		logout()
		puts "---------------------- END OF SCENARIO 7 --------------------------"
	end

# ------------------------------------------------------------------------------------------------------------------------------------------------------#
#SCENARIO 8 : AS A RAZOO ADMIN, ISBAT CREATE ORG. EDIT NPO DETAILS, DO AUDIT AND BECOME A 
#		    FAN WITHOUT DONATING TO ORG.
#
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	def test_08_createORG_NPOdetails_audit()
		
		puts "---------------------- START OF SCENARIO 8 ----------------------"
		login("ebi@srasys.co.in", "123456")
		createOrg("/admin", "411111117", "RazooTrunkiExplorer ORG2", "iExplorer City", "iExplorer State")
		editNpoDetails("First Name", "Last Name", "Addres 1", "Addres 2", "razoo@iExplorer.com", "123456789")
		auditVerifyOrg("Verified this ORG")
		verifyNpoDetails()
		becomeFan()
		logout()
		puts "---------------------- END OF SCENARIO 8 --------------------------"
	end
	
	
	#This method helps to stop the browser.
	def test_08_stop_browser()
		stopBrowser()
	end

	
end
    
