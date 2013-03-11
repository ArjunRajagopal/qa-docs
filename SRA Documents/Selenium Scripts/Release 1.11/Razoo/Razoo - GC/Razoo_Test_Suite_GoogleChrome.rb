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
# 28-OCT-2010 - Included 9, 10 scenarios.
# 16-NOV-2010 - Update on Release 1.8.
# 25-NOV-2010 - Implementing EXCEL concept.
# 22-DEC-2010 - Update - Release 1.10.
# 14-Jan-2010 - Update - Release 1.11.
#
# -------------------------------------------------------------#

require "test/unit"
require "rubygems"
require "selenium/client"
require "Razoo_Test_Cases_GoogleChrome.rb"
require "win32ole"


# Variable declarations
$siteRow = 3; $normalUser1 = 5; $normalUser2 = 6;  $globalAdmin = 7;
$sharePage = 5; $other_amounts = 5; 
$visaCard = 11; $amexCard = 12; $masterCard = 13;
$createOrg = 17; $storyNames = 21; $createStory = 25;
$createTeamCamp = 29; $donateAnywere = 33;
$matchingGrant = 37;


# -------------------------------------- START : GETTING TEST DATA'S FROM EXCEL ------------------------
$test_data ="D:\\EBI\\MyProjects\\Razoo\\Automation\\Selenium\\Selenium2\\ModularFramework\\Release 1.11\\RazooTestData.xls"

	excel = WIN32OLE::new("excel.application")
	# Getting the Excelsheet
	workBook = excel.Workbooks.Open($test_data)
	# Opening the first worksheet
	workSheetCount = workBook.worksheets.count
	puts "Total WorkSheet count in  Excel: #{workSheetCount}"
	workSheet = workBook.worksheets(1)
	workSheet.select
	rowCount = workSheet.UsedRange.Rows.Count
	puts "Row count is : #{rowCount}"
	
	# Read the data from Excel Sheet
	$test_site = workSheet.Cells($siteRow, "A").value
	$normal1_firstname = workSheet.Cells($normalUser1, "C").value
	$normal1_lastname = workSheet.Cells($normalUser1, "D").value
	$normal1_emailId = workSheet.Cells($normalUser1, "E").value
	$normal1_password = workSheet.Cells($normalUser1, "F").value
	
	$normal2_firstname = workSheet.Cells($normalUser2, "C").value
	$normal2_lastname = workSheet.Cells($normalUser2, "D").value
	$normal2_emailId = workSheet.Cells($normalUser2, "E").value
	$normal2_password = workSheet.Cells($normalUser2, "F").value
	
	$globaladmin_firstname = workSheet.Cells($globalAdmin, "C").value
	$globaladmin_lastname = workSheet.Cells($globalAdmin, "D").value
	$globaladmin_emailId = workSheet.Cells($globalAdmin, "E").value
	$globaladmin_password = workSheet.Cells($globalAdmin, "F").value
	
	$share_emailId = workSheet.Cells($sharePage, "H").value
	$share_storyurl = workSheet.Cells($sharePage, "I").value
	
	$amount_cent = workSheet.Cells($other_amounts, "K").value
	$tip_amount = workSheet.Cells($other_amounts, "L").value
	
	$donation_amount = workSheet.Cells($visaCard, "C").value
	$normal1_nameoncard = workSheet.Cells($visaCard, "D").value
	$street = workSheet.Cells($visaCard, "E").value
	$city = workSheet.Cells($visaCard, "F").value
	$state = workSheet.Cells($visaCard, "G").value
	$pin_code = workSheet.Cells($visaCard, "H").value
	$visacard_number = workSheet.Cells($visaCard, "I").value
	$visa_seccode = workSheet.Cells($visaCard, "J").value
	$normal1don_emailId = workSheet.Cells($visaCard, "K").value
	
	$amexcard_number = workSheet.Cells($amexCard, "I").value
	$amex_seccode = workSheet.Cells($amexCard, "J").value
	
	$normal2_nameoncard = workSheet.Cells($masterCard, "D").value
	$mastercard_number = workSheet.Cells($masterCard, "I").value
	$mastercard_seccode = workSheet.Cells($masterCard, "J").value
	$normal2don_emailId = workSheet.Cells($masterCard, "K").value
	
	$neworg_ein = workSheet.Cells($createOrg, "C").value
	$new_orgname = workSheet.Cells($createOrg, "D").value
	$org_city = workSheet.Cells($createOrg, "E").value
	$org_state = workSheet.Cells($createOrg, "F").value
	$org_firstname = workSheet.Cells($createOrg, "G").value
	$org_lastname = workSheet.Cells($createOrg, "H").value
	$org_address1 = workSheet.Cells($createOrg, "I").value
	$org_address2 = workSheet.Cells($createOrg, "J").value
	$org_emailId = workSheet.Cells($createOrg, "K").value
	$org_phonenum = workSheet.Cells($createOrg, "L").value
	
	$org_name = workSheet.Cells($storyNames, "C").value
	$pro_name = workSheet.Cells($storyNames, "D").value
	$fr_name = workSheet.Cells($storyNames, "E").value
	$admincon_url = workSheet.Cells($storyNames, "F").value
	$mynpo_ein = workSheet.Cells($storyNames, "G").value
	$teamcamp_fr = workSheet.Cells($storyNames, "H").value
	
	$story_summary = workSheet.Cells($createStory, "C").value
	$page_story = workSheet.Cells($createStory, "D").value
	$youtube_url = workSheet.Cells($createStory, "E").value
	$desig_value = workSheet.Cells($createStory, "F").value
	$goal_amount = workSheet.Cells($createStory, "G").value
	$sug_amount = workSheet.Cells($createStory, "H").value
	$sug_desc = workSheet.Cells($createStory, "I").value
	
	$teamcampaign_url = workSheet.Cells($createTeamCamp, "C").value
	$camp_title = workSheet.Cells($createTeamCamp, "D").value
	$camp_story = workSheet.Cells($createTeamCamp, "E").value
	$camp_goalamount = workSheet.Cells($createTeamCamp, "F").value
	$leaderboard_order = workSheet.Cells($createTeamCamp, "G").value
	$camp_url = workSheet.Cells($createTeamCamp, "H").value
	$modified_camp_url = workSheet.Cells($createTeamCamp, "I").value
	$camp_goaldate = workSheet.Cells($createTeamCamp, "J").value
	
	$widget_emailid = workSheet.Cells($donateAnywere, "C").value
	$widget_fullname = workSheet.Cells($donateAnywere, "D").value
	$widget_street = workSheet.Cells($donateAnywere, "E").value
	$widget_city = workSheet.Cells($donateAnywere, "F").value
	$widget_state = workSheet.Cells($donateAnywere, "G").value
	$widget_pcode = workSheet.Cells($donateAnywere, "H").value
	
	$mgcreator_name = workSheet.Cells($matchingGrant, "C").value
	$mg_email = workSheet.Cells($matchingGrant, "D").value
	$mg_totalamount = workSheet.Cells($matchingGrant, "E").value
	$mg_date = workSheet.Cells($matchingGrant, "F").value
	$mg_date = workSheet.Cells($matchingGrant, "F").value
	$mg_donationamount = workSheet.Cells($matchingGrant, "G").value
	
	excel.Workbooks.Close

# -------------------------------------- END : GETTING TEST DATA'S FROM EXCEL ------------------------

class RazooTestSuite < Test::Unit::TestCase

	#This method helps to invoke the Razoo Site
	def test_00_setup_razoo()
		
		invokeRazooSite($test_site)	
	end
	
# --------------------------------------------------------------------------------------------------------------------#
# SCENARIO 1 : AS A GUEST USER ISBAT DONATE AND SHARE THE STORY PAGE THROUGH EMAIL
# --------------------------------------------------------------------------------------------------------------------#
	
	def test_02_guestuser_share_story()
		
		puts "------------------------ START OF SCENARIO 1 --------------------"
		searchOrg($org_name)
		donateUsingNewCard($donation_amount, $normal1_nameoncard, $street, $state, 
						$city, $pin_code, $visacard_number, $visa_seccode, $normal1don_emailId)
		guestUserSharePage($share_emailId)
		puts "------------------------ END OF SCENARIO 1 --------------------"
	end	

# -----------------------------------------------------------------------------------------------------#
# SCENARIO 2 : AS A GUEST USER ISBAT DONATE TO ORG AND CREATE AN ACCOUNT.
# -----------------------------------------------------------------------------------------------------#
	
	def test_03_guestuser_donation_ORG()
		
		puts "------------------------ START OF SCENARIO 2 --------------------"
		searchOrg($org_name)
		donateUsingNewCard($donation_amount, $normal1_nameoncard, $street, $state, 
					$city, $pin_code, $visacard_number, $visa_seccode, $normal1don_emailId)
		createRazooAccount($normal1_firstname, $normal1_lastname, $normal1_emailId, $normal1_password)
		checkMydonation($donation_amount)
		puts "------------------------ END OF SCENARIO 2 --------------------"
	end


# --------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 3 : AS A NORMAL USER ISBAT CREATE FUNDRAISE PAGE, DONATE TO  FR, SHARE STORY THORUGH 
#		    EMAIL AND POST COMMENT IN DONOR AND FACEBOOK.
# --------------------------------------------------------------------------------------------------------------------------------------#
	
	def test_04_normaluser_share_donation_FR_NewCard()
		
		puts "------------------------  START OF SCENARIO 3 ----------------------- "
		searchOrg($org_name)
		createStoryPage($org_name, $fr_name, $story_summary, $page_story, 
					$youtube_url, $desig_value, $goal_amount, "link=30", "link=Donations", 
					$sug_amount, $sug_desc)
		donateUsingNewCard($amount_cent, $normal1_nameoncard, $street, $state, 
					$city, $pin_code, $visacard_number, $visa_seccode, $normal1don_emailId)
		postComments("Give and be Blessed!!", $share_emailId, $share_storyurl)
		logout()
		puts "------------------------  END OF SCENARIO 3 ----------------------- "
	end


# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 4 : AS AN ORG ADMIN USER ISBAT CREATE PROEJCT PAGE, DONATE TO PROJECT, WITH TIPS, 
#		    USING SUGGESTED AMOUNT AND POST COMMENT in DONOR WALL.
#
# PRE - CONDITION : 
#	Provide admin rights to the emailId which is passed in the Login Function.
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	
	def test_05_orgadmin_donation_PRO_SavedCard()
		
		puts "---------------------- START OF SCENARIO 4 ----------------------"
		# PRE - CONDITION - START
		login($globaladmin_emailId, $globaladmin_password)
		grantOrgAdminRights($admincon_url, $normal1_emailId, $mynpo_ein)
		logout()
		# PRE - CONDITION - END
		login($normal1_emailId, $normal1_password)
		createStoryPage($org_name, $pro_name, $story_summary, $page_story, 
					$youtube_url, $desig_value, $goal_amount,  "link=30", "link=Donations", 
					$sug_amount, $sug_desc)
		donateUsingSavedCard($donation_amount,  $tip_amount)
		puts "---------------------- END OF SCENARIO 4 --------------------------"
	end

# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 5 : AS AN ORG ADMIN, ISBAT TO MAKE AN ANONYMOUS  RECURRING DONATION TO FR WITH DEDICATION
#		     AND POST COMMENT IN DONOR WALL, DELETE THE COMMENT AND REMOVE THE STORY FROM 
#		    THE "Causes I'm a Fan of" LIST.
#
#~ # ------------------------------------------------------------------------------------------------------------------------------------------------------#
	
	def test_06_AddNewCard_deletecomment_removefan()
		
		puts "---------------------- START OF SCENARIO 5 ----------------------"
		searchOrg($org_name)
		donateUsingAddCreditCard($donation_amount, $street, $state, $city, $pin_code,
						  $amexcard_number, $amex_seccode, "label=Weekly")
		deleteComments("Delete this comment", $share_storyurl)
		removeFan($fr_name)
		puts "---------------------- END OF SCENARIO 5 --------------------------"
	end

# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 6 : AS AN ORG ADMIN, ISBAT TO MAKE AN ANONYMOUS DONATION TO FR AND POST COMMENT IN DONOR WALL 
#		    AND FACEBOOK, DELETE THE COMMENT AND REMOVE THE STORY FROM THE "Causes I'm a Fan of" LIST.
#
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	
	def test_07_cancelrecurringdonation_deletecard()
		
		puts "------- START OF SCENARIO 6 ----------"
		cancelRecurringDonation()
		deleteStoredCard()
		logout()
		puts "------- END OF SCENARIO 6 ------------"
	end


# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 7 : AS ANY USER, ISBAT RESEST MY PASSWORD IN MY USER PROFILE SCREEN.
#
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	
	def test_08_change_mypassword()
		
		puts "---------------------- START OF SCENARIO 7 ----------------------"
		login($normal1_emailId, $normal1_password)
		changeMyPassword($normal2_password)
		logout()
		login($normal1_emailId, $normal2_password)
		logout()
		puts "---------------------- END OF SCENARIO 7 --------------------------"
	end

# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 8 : AS A RAZOO ADMIN, ISBAT CREATE ORG. EDIT NPO DETAILS, DO AUDIT AND BECOME A 
#		    FAN WITHOUT DONATING TO ORG.
#
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	
	def test_01_createORG_NPOdetails_audit()
		
		puts "---------------------- START OF SCENARIO 8 ----------------------"
		login($globaladmin_emailId, $globaladmin_password)
		createOrg($admincon_url, $neworg_ein, $new_orgname, $org_city, $org_state)
		editNpoDetails($org_firstname, $org_lastname, $org_address1, $org_address2, $org_emailId, $org_phonenum)
		auditVerifyOrg("Verified this ORG")
		verifyNpoDetails()
		becomeFan()
		logout()
		puts "---------------------- END OF SCENARIO 8 --------------------------"
	end


# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 9 : AS A GUEST USER, ISBAT CREATE AN ACCOUNT WHILE DONATING TO NEWLY CREATED ORG, 
#		    SHARE PAGE. 
#
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	
	def test_09_createaccount_while_donating()
		
		puts "---------------------- START OF SCENARIO 9----------------------"
		sleep 5
		searchOrg($new_orgname)
		gotoDonFormClickSignup($donation_amount)
		createRazooAccount($normal2_firstname, $normal2_lastname, $normal2_emailId, $normal2_password)
		donateUsingNewCard($donation_amount, $normal2_nameoncard, $street, $state,  
					 $city, $pin_code, $mastercard_number, $mastercard_seccode, $normal2don_emailId)
		postComments("Give and be Blessed!!", $share_emailId, $share_storyurl)
		checkMydonation($donation_amount)
		logout()
		puts "---------------------- END OF SCENARIO 9 --------------------------"
	end
	
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 10 : AS A NORMAL USER, ISBAT LOGIN TO RAZOO WHILE DONATING TO NEWLY ORG. 
#		   
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	
	def test_10_login_while_donating()
		
		puts "---------------------- START OF SCENARIO 10 ----------------------"
		searchOrg($new_orgname)
		gotoDonFormClickLogin($donation_amount, $normal2_emailId, $normal2_password)
		donateUsingNewCard($donation_amount, $normal2_nameoncard, $street, $state, 
					 $city, $pin_code, $mastercard_number, $mastercard_seccode, $normal2don_emailId)
		postComments("Give and be Blessed!!", $share_emailId, $share_storyurl)
		checkMydonation($donation_amount)
		logout()
		puts "---------------------- END OF SCENARIO 10 --------------------------"
	end
	
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 11 : AS A NORMAL USER, ISBAT CREATE A CAMPAIGN PAGE, EDIT THE SAME, CREATE FUNDRAISER FOR THE CAMP AND
#						MAKE DONATION, VERIFY THE LEADERBOARD OF TEAM CAMPAIGN PAGE.
#		   
# ------------------------------------------------------------------------------------------------------------------------------------------------------#

	def test_11_createcamp_fundraiser_donation()
		
		puts "---------------------- START OF SCENARIO 11 ----------------------"
		login($normal2_emailId, $normal2_password)
		createTeamCampaign($teamcampaign_url, $org_name, $camp_title, $camp_story, $camp_goalamount, $camp_goaldate)
		editTeamCampaign($leaderboard_order, $camp_url)
		createTeamCampFundraiser($teamcamp_fr, $story_summary, $page_story, $youtube_url, $sug_amount, $sug_desc, $camp_goalamount)
		donateUsingSavedCard($donation_amount, $tip_amount)
		verifyLeaderboard($modified_camp_url, $sug_amount, $teamcamp_fr)
		logout()
		puts "---------------------- END OF SCENARIO 11 ----------------------"
		
	end
	
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 12 : AS A STORYADMIN, ISBAT MAKE A DONATION THROUGH DONATEANYWERE OPTION IN THE STORY PAGE.
#		   
# ------------------------------------------------------------------------------------------------------------------------------------------------------#

	def test_12_makedonation_donateanywere
		
		puts "---------------------- START OF SCENARIO 12 ----------------------"
		login($normal1_emailId, $normal2_password)
		searchProject($pro_name)
		donateUsingDonateAnywhere($donation_amount, $widget_emailid, $widget_fullname, $widget_street, $widget_city, $widget_state, $widget_pcode, $visacard_number, $visa_seccode, $tip_amount)
		logout()
		puts "---------------------- END OF SCENARIO 12 ----------------------"
	
	end
	
# -------------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 13 : AS A STORYADMIN, ISBAT CREATE A MATCHING GRANT, MAKE A DONATION AND CLOSE THE ,MATCHING GRANT.
#		   
# -------------------------------------------------------------------------------------------------------------------------------------------------------------#


	def test_13_createandclose_matchinggrant
		
		puts "---------------------- START OF SCENARIO 13 ----------------------"
		login($normal1_emailId, $normal2_password)
		searchProject($pro_name)
		createMatchingGrant($mgcreator_name, $mg_email, $mg_totalamount, $mg_date)
		donateUsingNewCard($mg_donationamount, $normal1_nameoncard, $street, $state, 
					$city, $pin_code, $visacard_number, $visa_seccode, $normal1don_emailId)
		searchProject($pro_name)
		closeMatchingGrant($mg_donationamount)
		puts "---------------------- END OF SCENARIO 13 ----------------------"
	
	end


	#This method helps to stop the browser.
	def test_14_stop_browser()
		stopBrowser()
		#~ login($globaladmin_emailId, $globaladmin_password)
		#~ runHackURL("/admin/reindex", "/admin/reindex_all", "/admin/memcached_flush", "/admin/regenerate_statistics")
	end

	
end
    
