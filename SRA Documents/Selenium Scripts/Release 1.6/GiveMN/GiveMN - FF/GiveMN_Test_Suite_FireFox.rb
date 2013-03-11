#-------------------------------------------------------------#
#  GiveMNTestSuite Class
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
# -------------------------------------------------------------#
require "test/unit"
require "rubygems"
require "selenium/client"
require "GiveMN_Test_Cases_FireFox.rb"


class RazooTestSuite < Test::Unit::TestCase

	#This method helps to invoke the Razoo Site
	def test_00_setup_razoo()
		
		invokeRazooSite()	
	end
# -----------------------------------------------------------------------------------------------------#
#SCENARIO 1 : AS A GUEST USER ISBAT DONATE TO ORG AND CREATE AN ACCOUNT.
# -----------------------------------------------------------------------------------------------------#
	
	def test_01_guestuser_donation_ORG()
		
		puts "------------------------ START OF SCENARIO 1 --------------------"
		searchOrg("Minnesota Community Foundation")
		donateUsingNewCard("10.00", "Sample User3", "2nd Street", "Washington DC", 
					"Washington", "95008", "4111111111111111", "123", "sampleuser3@aol.com")
		viewComments()
		createRazooAccount("Sample", "User3", "sampleuser3@firefox.com", "123456")
		puts "------------------------ END OF SCENARIO 1 --------------------"
	end


# ----------------------------------------------------------------------------------------------------------------------------------#
#SCENARIO 2 : AS A NORMAL USER ISBAT CREATE FUNDRAISE PAGE, DONATE TO  FR AND POST COMMENT.
# ----------------------------------------------------------------------------------------------------------------------------------#
	def test_02_normaluser_donation_FR_NewCard()
		
		puts "------------------------  START OF SCENARIO 2 ----------------------- "
		searchOrg("Minnesota Community Foundation")
		createStoryPage("Minnesota Community Foundation", "FirefoxFR3 for Minnesota Community Foundation", "Summary Part ", "Story Part", 
				"http://www.youtube.com/watch?v=HNVSI_r9SVg" , "With Designation", 
				"100",  "link=31", "link=Donations", "10", "Suggested Amount")
		donateUsingNewCard("10.50", "Sample User3", "2nd Street", "Washington DC", 
				"Washington", "95008", "4111111111111111", "123", "sampleuser3@firefox.com")
		postComments("Give and be Blessed!!", "fbuser1@rediffmail.com", "111111")
		logout()
		puts "------------------------  END OF SCENARIO 2 ----------------------- "
	end


# ------------------------------------------------------------------------------------------------------------------------------------------------------#
#SCENARIO 3 : AS AN ORG ADMIN USER ISBAT CREATE PROEJCT PAGE, DONATE TO PROJECT, WITH TIPS, 
#		    USING SUGGESTED AMOUNT AND POST COMMENT in DONOR WALL.
#
# PRE - CONDITION : 
#	Provide admin rights to the emailId which is passed in the Login Function.
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	def test_03_orgadmin_donation_PRO_SavedCard()
		
		puts "---------------------- START OF SCENARIO 3 ----------------------"
		# PRE - CONDITION - START
		login("srajkumar.here@gmail.com", "razoo1")
		grantOrgAdminRights("/admin", "sampleuser3@firefox.com", "410832480")
		logout()
		# PRE - CONDITION - END
		login("sampleuser3@firefox.com", "123456")
		createStoryPage("Minnesota Community Foundation", "FirefoxPRO3 of Minnesota Community Foundation", "Summary Part ", "Story Part", 
				"http://www.youtube.com/watch?v=HNVSI_r9SVg" , "With Designation", 
				"100",  "link=31", "link=Donations", "10", "Suggested Amount")
		donateUsingSavedCard("10.00",  "9.00")
		puts "---------------------- END OF SCENARIO 3 --------------------------"
	end

# ------------------------------------------------------------------------------------------------------------------------------------------------------#
#SCENARIO 4 : AS AN ORG ADMIN, ISBAT TO MAKE AN ANONYMOUS  RECURRING DONATION TO FR AND POST COMMENT
#		    IN DONOR WALL AND FACEBOOK, DELETE THE COMMENT AND REMOVE THE STORY FROM THE "Causes I'm a Fan of" LIST.
#
#~ # ------------------------------------------------------------------------------------------------------------------------------------------------------#
	def test_04_AddNewCard_deletecomment_removefan()
		
		puts "---------------------- START OF SCENARIO 4 ----------------------"
		searchOrg("Minnesota Community Foundation")
		donateUsingAddCreditCard("10.00", "Mr Oct5", "2nd Street", "Washington DC",  "Washington", "95008",
						  "378282246310005", "1234", "label=Weekly")
		deleteComments("Delete this comment")
		removeFan("FirefoxFR3 for Minnesota Community Foundation")
		puts "---------------------- END OF SCENARIO 4 --------------------------"
	end

# ------------------------------------------------------------------------------------------------------------------------------------------------------#
#SCENARIO 5 : AS AN ORG ADMIN, ISBAT TO MAKE AN ANONYMOUS DONATION TO FR AND POST COMMENT IN DONOR WALL 
#		    AND FACEBOOK, DELETE THE COMMENT AND REMOVE THE STORY FROM THE "Causes I'm a Fan of" LIST.
#
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	def test_05_cancelrecurringdonation_deletecard()
		
		puts "------- START OF SCENARIO 5 ----------"
		cancelRecurringDonation()
		deleteStoredCard()
		logout()
		puts "------- END OF SCENARIO 5 ------------"
	end


# ------------------------------------------------------------------------------------------------------------------------------------------------------#
#SCENARIO 6 : AS ANY USER, ISBAT RESEST MY PASSWORD IN MY USER PROFILE SCREEN.
#
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	def test_06_change_mypassword()
		
		puts "---------------------- START OF SCENARIO 6 ----------------------"
		login("sampleuser3@firefox.com", "123456")
		changeMyPassword("1234567")
		logout()
		login("sampleuser3@firefox.com", "1234567")
		logout()
		puts "---------------------- END OF SCENARIO 6 --------------------------"
	end

# ------------------------------------------------------------------------------------------------------------------------------------------------------#
#SCENARIO 7 : AS A RAZOO ADMIN, ISBAT CREATE ORG. EDIT NPO DETAILS, DO AUDIT AND BECOME A 
#		    FAN WITHOUT DONATING TO ORG.
#
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	def test_07_createORG_NPOdetails_audit()
		
		puts "---------------------- START OF SCENARIO 7 ----------------------"
		login("srajkumar.here@gmail.com", "razoo1")
		createOrg("/admin", "111111120", "FF ORG3", "Firefox City", "Firefox State")
		editNpoDetails("First Name", "Last Name", "Addres 1", "Addres 2", "razoo@firefox.com", "123456789")
		auditVerifyOrg("Verified this ORG")
		verifyNpoDetails()
		becomeFan()
		logout()
		puts "---------------------- END OF SCENARIO 7 --------------------------"
	end
	
	
	#This method helps to stop the browser.
	def test_08_stop_browser()
		stopBrowser()
	end

	
end
    
