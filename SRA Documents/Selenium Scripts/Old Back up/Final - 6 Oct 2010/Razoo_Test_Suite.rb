#-------------------------------------------------------------#
#  RazooTestSuite Class
#
# Author: EBI,SDR and SID
# Date: 4-OCT-2010
# Description:  It is a Class which contains all the methods thats need to be Executed
#
# Change history:
# 5-OCT-2010 - Added createFundraise scenarios.
# -------------------------------------------------------------#
require "test/unit"
require "rubygems"
require "selenium/client"
require "Razoo_Test_Cases.rb"


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
		searchStory("Harvard College")
		donateUsingNewCard("10", "Mr Oct5", "2nd Street", "Washington DC", 
					"Washington", "95008", "4111111111111111", "123", "GuestUser@aol.com")
		viewComments()
		createRazooAccount("Mr", "Oct", "oct7@yeahh.com", "123456")
		puts "------------------------ END OF SCENARIO 1 --------------------"
	end


# ----------------------------------------------------------------------------------------------------------------------------------#
#SCENARIO 2 : AS A NORMAL USER ISBAT CREATE FUNDRAISE PAGE, DONATE TO  FR AND POST COMMENT.
# ----------------------------------------------------------------------------------------------------------------------------------#
	def test_02_normaluser_donation_FR()
		
		puts "------------------------  START OF SCENARIO 2 ----------------------- "
		searchStory("Harvard College")
		createStoryPage("Harvard College", "FR13 for Harvard College", "Summary Part ", "Story Part", 
				"http://www.youtube.com/watch?v=HNVSI_r9SVg" , "With Designation", 
				"100",  "link=31", "link=Donations", "10", "Suggested Amount")
		donateUsingNewCard("10", "Mr Oct5", "2nd Street", "Washington DC", 
				"Washington", "95008", "4111111111111111", "123", "GuestUser@aol.com")
		postComments("Give and be Blessed!!")
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
	def test_03_orgadmin_donation_PRO()
		
		puts "---------------------- START OF SCENARIO 3 ----------------------"
		login("ebi@srasys.co.in", "razoo1")
		createStoryPage("Harvard College", "PRO12 of Harvard College", "Summary Part ", "Story Part", 
				"http://www.youtube.com/watch?v=HNVSI_r9SVg" , "With Designation", 
				"100",  "link=31", "link=Donations", "10", "Suggested Amount")
		donateUsingSavedCard("10", "label=Weekly", "9")
		logout()
		puts "---------------------- END OF SCENARIO 3 --------------------------"
	end
	
	
	#This method helps to stop the browser.
	def test_04_stop_browser()
		stopBrowser()
	end
end
    
