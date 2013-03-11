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
# -------------------------------------------------------------#
require "test/unit"
require "rubygems"
require "selenium/client"
require "Razoo_Test_Cases_Chrome.rb"


class RazooTestSuite < Test::Unit::TestCase

	#This method helps to invoke the Razoo Site
	def test_00_setup_razoo()
		
		invokeRazooSite()	
	end
# -----------------------------------------------------------------------------------------------------#
#SCENARIO 1 : AS A GUEST USER ISBAT DONATE TO ORG AND CREATE AN ACCOUNT.
# -----------------------------------------------------------------------------------------------------#
	
	#~ def test_01_guestuser_donation_ORG()
		
		#~ puts "------------------------ START OF SCENARIO 1 --------------------"
		#~ searchStory("Harvard College")
		#~ donateUsingNewCard("10", "Mr Oct13", "2nd Street", "Washington DC", 
					#~ "Washington", "95008", "4111111111111111", "123", "GuestUser@aol.com")
		#~ viewComments()
		#~ createRazooAccount("Mr", "Oct13", "oct13@chrome1.com", "123456")
		#~ puts "------------------------ END OF SCENARIO 1 --------------------"
	#~ end


# ----------------------------------------------------------------------------------------------------------------------------------#
#SCENARIO 2 : AS A NORMAL USER ISBAT CREATE FUNDRAISE PAGE, DONATE TO  FR AND POST COMMENT.
# ----------------------------------------------------------------------------------------------------------------------------------#
	#~ def test_02_normaluser_donation_FR()
		
		#~ puts "------------------------  START OF SCENARIO 2 ----------------------- "
		#~ searchStory("Harvard College")
		#~ createStoryPage("Harvard College", "ChromeFR for Harvard College", "Summary Part ", "Story Part", 
				#~ "http://www.youtube.com/watch?v=HNVSI_r9SVg" , "With Designation", 
				#~ "100",  "link=31", "link=Donations", "10", "Suggested Amount")
		#~ donateUsingNewCard("10", "Mr Oct5", "2nd Street", "Washington DC", 
				#~ "Washington", "95008", "4111111111111111", "123", "oct13@chrome1.com")
		#~ postComments("Give and be Blessed!!")
		#~ logout()
		#~ puts "------------------------  END OF SCENARIO 2 ----------------------- "
	#~ end


# ------------------------------------------------------------------------------------------------------------------------------------------------------#
#SCENARIO 3 : AS AN ORG ADMIN USER ISBAT CREATE PROEJCT PAGE, DONATE TO PROJECT, WITH TIPS, 
#		    USING SUGGESTED AMOUNT AND POST COMMENT in DONOR WALL.
#
# PRE - CONDITION : 
#	Provide admin rights to the emailId which is passed in the Login Function.
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	def test_03_orgadmin_donation_PRO()
		
		puts "---------------------- START OF SCENARIO 3 ----------------------"
		# PRE - CONDITION - START
		login("ebi@srasys.co.in", "123456")
		grantOrgAdminRights("/admin", "oct13@chrome1.com", "042103580")
		logout()
		# PRE - CONDITION - END
		login("oct13@chrome1.com", "123456")
		createStoryPage("Harvard College", "ChromePRO of Harvard College", "Summary Part ", "Story Part", 
				"http://www.youtube.com/watch?v=HNVSI_r9SVg" , "With Designation", 
				"100",  "link=31", "link=Donations", "10", "Suggested Amount")
		donateUsingSavedCard("10", "label=Weekly", "9.00")
		postComments("Give and be Blessed!!")
		logout()
		puts "---------------------- END OF SCENARIO 3 --------------------------"
	end
	
	
	#This method helps to stop the browser.
	def test_04_stop_browser()
		stopBrowser()
	end
end
    
