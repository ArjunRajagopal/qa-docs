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
		login("ebi@srasys.co.in", "123456")
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
		verifyHeaderLinks()
		verifyFooterLinks()
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
		verifyHeaderLinks()
		verifyFooterLinks()
		verifyMyAccountLinks()
		verifyNPOAdminLinks("Harvard College")
		#~ searchProject("RazooTrunkFirefoxPRO20 of Harvard College")
		#~ verifyStoryAdminLinks()
		logout()
		puts "---------------------- END OF SCENARIO 02 --------------------------"
	end

# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 3 : AS A RAZOO GLOBAL ADMIN, ISBAT CLICK ON ALL THE LINKS IN RAZOO APPLICATION. 
#		   
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	def test_04_razooglobaladmin_clickall_links()
		
		puts "---------------------- START OF SCENARIO 03 ----------------------"
		login("ebi@srasys.co.in", "123456")
		verifyNPOAdminLinks("Harvard College")
		logout()
		puts "---------------------- END OF SCENARIO 03 --------------------------"
	end


	#This method helps to stop the browser.
	def test_05_stop_browser()
		stopBrowser()
	end

	
end
    
