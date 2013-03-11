#-------------------------------------------------------------#
#  RazooTestSuite Class
#
# Author: EBI,SDR and SID
# Date: 17-NOV-2010
# Description:  It is a Class which contains all the methods thats need to be Executed
#
# Change history:
#
# -------------------------------------------------------------#
require "test/unit"
require "rubygems"
require "selenium/client"
require "Razoo_Sanity_Test_Cases_FireFox.rb"


class RazooTestSuite < Test::Unit::TestCase

	#This method helps to invoke the Razoo Site
	def test_00_setup_razoo()
		
		invokeRazooSite()	
	end
	
# ---------------- PRE - CONDITION FOR SANITY ------------
	
	def test_01_precondition_for_sanity()
		
		puts "---------------------- START OF SANITY PRE-CONDITION ----------------------"
		createRazooAccount("Normal", "User", "normaluser@aol.com", "123456")
		logout()	
		createRazooAccount("OrgAdmin", "User", "orgadmin@aol.com", "123456")
		logout()
		login("raj@razoo.com", "razoo1")
		grantOrgAdminRights("/admin", "orgadmin@aol.com", "042103580")
		logout()
		puts "---------------------- END OF SANITY PRE-CONDITION ----------------------"
	end
	
# ---------------- PRE - CONDITION FOR SANITY ------------

# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 1 : AS A NORMAL USER, ISBAT CLICK ON ALL THE LINKS IN RAZOO APPLICATION. 
#		   
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	def test_02_normaluser_clickall_links()
		
		puts "---------------------- START OF SCENARIO 01 ----------------------"
		verifySignupLoginLinks()
		login("normaluser@aol.com", "123456")
		#~ verifyHeaderLinks()
		#~ verifyFooterLinks()
		verifyMyAccountLinks()
		logout()
		puts "---------------------- END OF SCENARIO 01 --------------------------"
	end

# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 2 : AS A STORY ADMIN, ISBAT CLICK ON ALL THE LINKS IN RAZOO APPLICATION. 
#		   
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	def test_03_storyadmin_clickall_links()
		
		puts "---------------------- START OF SCENARIO 02 ----------------------"
		login("orgadmin@aol.com", "123456")
		#~ verifyHeaderLinks()
		#verifyFooterLinks()
		verifyMyAccountLinks()
		verifyNPOAdminLinks("Harvard College")
		createStoryPage("042103580", "Harvard College","Project89 of Harvard College", "Summary", "Story", "http://www.youtube.com/watch?v=giIWXZbyT1o", "Desig", "101",  "link=30", "10", "sug desc")
		donateUsingNewCard("10.00", "OrgAdmin user", "street", "city", "Alabama", "95008", "4111111111111111", "123", "orgadmin@aol.com")
		purchaseGivingCard("Recipient Name", "recipientemailFF@aol.com", "link=30", "$10", "/gift_cards/orders/new")
		logout()
		puts "---------------------- END OF SCENARIO 02 --------------------------"
	end

# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 3 : AS A RAZOO GLOBAL ADMIN, ISBAT CLICK ON ALL THE LINKS IN RAZOO APPLICATION. 
#		   
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	def test_04_razooglobaladmin_clickall_links()
		
		puts "---------------------- START OF SCENARIO 03 ----------------------"
		login("raj@razoo.com", "razoo1")
		
		
		
		
		verifyNPOAdminLinks("Harvard College")
		verifyStoryAdminLinks()
		puts "---------------------- END OF SCENARIO 03 --------------------------"
	end

# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 4 : AS A RAZOO GLOBAL ADMIN, ISBAT CREATE A TEAM.
#		   
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	def test_05_createteam()
		
		puts "---------------------- START OF SCENARIO 04 ----------------------"
		createTeamCampaignSpecificCause("/team/new", "Harvard College", "Team89 for Harvard College", "Team story", "101", "link=30")
		searchProject("Project89 of Harvard College")
		logout()
		puts "---------------------- END OF SCENARIO 04 --------------------------"
	end

	#This method helps to stop the browser.
	#~ def test_05_stop_browser()
		#~ stopBrowser()
	#~ end

	
end
    
