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
# 14-OCT-2010 - Added scenario 4. 5, 6 and 7. # 15-OCT-2010 - Included Facebook pop up code. # 21-OCT-2010 - Included Share page code. # 28-OCT-2010 - Included 9, 10 scenarios. 
# 16-NOV-2010 - Update on Release 1.8. # 25-NOV-2010 - Implementing EXCEL concept. # 22-DEC-2010 - Update - Release 1.10. # 14-Jan-2010 - Update - Release 1.11.
# 7-Feb-2011 - Update - Release 1.11.1.  # 25-Feb-2011 - Update - Release 1.12. # 28-Mar-2011 - Update - Release 1.13. # 28-Apr-2011 - Update - Release 1.14.
# 19-May-2011 - Update - Release 1.16. # 3-June-2011 - Update - Release 1.17. # 15-June-2011 - Update - Release 1.18. # 30-June-2011 - Update - Release 1.19.
# 14-July-2011 - Update - Release 1.20. # 23-July-2011 - Update - Release 1.22. # 23-Sep-2011 - Update - Release 1.23&1.24.  # 06-Oct-2011 - Update - Release 1.25
# 18-Oct-2011 - Update - Release 1.25.3 # 2-Nov-2011 - Update - Release 1.26 # 24-Nov-2011 - Update - Release 2.1
# 27-Feb-2012 -Scripts updated with scenario by scenario execution method with time.
# -------------------------------------------------------------# 
require "test/unit"
require "rubygems"
require "selenium/client"
require "Razoo_Test_Cases_GoogleChrome.rb"
require "win32ole"


# Variable declarations
$staticValue = 1; $todayDate = 2; $siteRow = 3; $normalUser1 = 5; $normalUser2 = 6;  $personuser = 7; $causeuser = 8
$globalAdmin = 9; $other_amounts = 5; 
$visaCard = 13; $amexCard = 14; $masterCard = 15;
$createOrg = 19; $storyNames = 23; $createStory = 27;
$createTeamForSingleCause = 31; $createTeamForMultipleCause = 31; $donateAnywere = 35;
$matchingGrant = 39; $offlineDonations = 43; $myMeetup = 47
$givingCard = 51


# -------------------------------------- START : GETTING TEST DATA'S FROM EXCEL ------------------------
$test_data ="D:\\EBI\\MyProjects\\Razoo\\Automation\\Selenium\\Selenium2\\ModularFramework\\Arjun\\Release 2.4\\Razoo\\Razoo - GC\\Razoo_GoogleChrome_TestData.xls"
	
	$start = Time.now
	puts "Started at: #{$start} seconds"
	
	$excel = WIN32OLE::new("excel.application")
	$workBook = $excel.Workbooks.Open($test_data)
	workSheetCount = $workBook.worksheets.count
	puts "Total WorkSheet count in Excel: #{workSheetCount}"
	$workSheet = $workBook.worksheets(1)
	$workSheet.select
	rowCount = $workSheet.UsedRange.Rows.Count
	puts "Row count is : #{rowCount}"
	
	$test_site = $workSheet.Cells($siteRow, "A").value
	#----------------- Set today's date in Excel - Start -----------#
	$my_time = Time.new
	$today_date = $my_time.day     
	puts "Today's date : #{$today_date}"
	$workSheet.Cells($todayDate, "AZ").value = $today_date
	$workBook.Save
	#----------------- Set today's date in Excel - End -----------#
	#----------------- Changing the static value in Excel - Start -----------#
	$old_staticvalue = $workSheet.Cells($staticValue, "AZ").value
	puts "Old Static Value in Excel: #{$old_staticvalue}"
	
	#---------------------------------------------------------------------------#
	#-----------------------STATIC VALUES--------------------------------#
	
	$new_staticvalue = $old_staticvalue.to_i()+1 # Increase Static Value
	#~ $new_staticvalue = $old_staticvalue #keep Old static value
	
	
	puts "New Static Value in Excel: #{$new_staticvalue}"
	$workSheet.Cells($staticValue, "AZ").value = $new_staticvalue
	$workBook.Save
	#----------------- Changing the static value in Excel - End -----------#
	$normal1_firstname = $workSheet.Cells($normalUser1, "C").value
	$normal1_lastname = $workSheet.Cells($normalUser1, "D").value
	$normal1_emailId = $workSheet.Cells($normalUser1, "E").value
	$normal1_password = $workSheet.Cells($normalUser1, "F").value
	$gmail_emailId = $workSheet.Cells($normalUser1, "G").value
	$gmail_password = $workSheet.Cells($normalUser1, "H").value
	
	$normal2_firstname = $workSheet.Cells($normalUser2, "C").value
	$normal2_lastname = $workSheet.Cells($normalUser2, "D").value
	$normal2_emailId = $workSheet.Cells($normalUser2, "E").value
	$normal2_password = $workSheet.Cells($normalUser2, "F").value
	$fb_emailId = $workSheet.Cells($normalUser2, "G").value
	$fb_password = $workSheet.Cells($normalUser2, "H").value
	
	$personuser_firstname = $workSheet.Cells($personuser, "C").value
	$personuser_lastname = $workSheet.Cells($personuser, "D").value
	$personuser_emailId = $workSheet.Cells($personuser, "E").value
	$personuser_password = $workSheet.Cells($personuser, "F").value
	
	$causeuser_firstname = $workSheet.Cells($causeuser, "C").value
	$causeuser_lastname = $workSheet.Cells($causeuser, "D").value
	$causeuser_emailId = $workSheet.Cells($causeuser, "E").value
	$causeuser_password = $workSheet.Cells($causeuser, "F").value
	
	$globaladmin_firstname = $workSheet.Cells($globalAdmin, "C").value
	$globaladmin_lastname = $workSheet.Cells($globalAdmin, "D").value
	$globaladmin_emailId = $workSheet.Cells($globalAdmin, "E").value
	$globaladmin_password = $workSheet.Cells($globalAdmin, "F").value
	
	$share_emailId = $workSheet.Cells($sharePage, "H").value
	$share_storyurl = $workSheet.Cells($sharePage, "I").value
	
	$amount_cent = $workSheet.Cells($other_amounts, "K").value
	$tip_amount = $workSheet.Cells($other_amounts, "L").value
	
	$donation_amount = $workSheet.Cells($visaCard, "C").value
	$normal1_nameoncard = $workSheet.Cells($visaCard, "D").value
	$street = $workSheet.Cells($visaCard, "E").value
	$city = $workSheet.Cells($visaCard, "F").value
	$state = $workSheet.Cells($visaCard, "G").value
	$pin_code = $workSheet.Cells($visaCard, "H").value
	$visacard_number = $workSheet.Cells($visaCard, "I").value
	$visa_seccode = $workSheet.Cells($visaCard, "J").value
	$normal1don_emailId = $workSheet.Cells($visaCard, "K").value
	
	$amexcard_number = $workSheet.Cells($amexCard, "I").value
	$amex_seccode = $workSheet.Cells($amexCard, "J").value
	
	$normal2_nameoncard = $workSheet.Cells($masterCard, "D").value
	$mastercard_number = $workSheet.Cells($masterCard, "I").value
	$mastercard_seccode = $workSheet.Cells($masterCard, "J").value
	$normal2don_emailId = $workSheet.Cells($masterCard, "K").value
	
	#----------------- Changing the EIN value in Excel - Start -----------#
	$neworg_ein = $workSheet.Cells($createOrg, "C").value
	$neworg_ein_afterincr = $neworg_ein.to_i()+1
	$workSheet.Cells($createOrg, "C").value = $neworg_ein_afterincr
	$workBook.Save
	$neworg_ein = $neworg_ein_afterincr
	puts "New EIN in Excel: #{$neworg_ein}"
	#----------------- Changing the EIN value in Excel - End -----------#
	$new_orgname = $workSheet.Cells($createOrg, "D").value
	$org_city = $workSheet.Cells($createOrg, "E").value
	$org_state = $workSheet.Cells($createOrg, "F").value
	$org_firstname = $workSheet.Cells($createOrg, "G").value
	$org_lastname = $workSheet.Cells($createOrg, "H").value
	$org_address1 = $workSheet.Cells($createOrg, "I").value
	$org_address2 = $workSheet.Cells($createOrg, "J").value
	$org_emailId = $workSheet.Cells($createOrg, "K").value
	$org_phonenum = $workSheet.Cells($createOrg, "L").value
	$org_url = $workSheet.Cells($createOrg, "M").value
	$new_einlessorgname = $workSheet.Cells($createOrg, "N").value
	$einlessorg_url = $workSheet.Cells($createOrg, "O").value
	$new_orgname2 = $workSheet.Cells($createOrg, "P").value
	$new_orgname3 = $workSheet.Cells($createOrg, "R").value
	$org2_url = $workSheet.Cells($createOrg, "Q").value
	$org3_url = $workSheet.Cells($createOrg, "S").value
	
	$org_name = $workSheet.Cells($storyNames, "C").value
	$pro_name = $workSheet.Cells($storyNames, "D").value
	$fr_name = $workSheet.Cells($storyNames, "E").value
	$admincon_url = $workSheet.Cells($storyNames, "F").value
	$mynpo_ein = $workSheet.Cells($storyNames, "G").value
	$teamcamp1_fr = $workSheet.Cells($storyNames, "H").value
	$teamcamp2_fr = $workSheet.Cells($storyNames, "I").value
	$themedfr_url = $workSheet.Cells($storyNames, "J").value
	
	$story_summary = $workSheet.Cells($createStory, "C").value
	$page_story = $workSheet.Cells($createStory, "D").value
	$youtube_url = $workSheet.Cells($createStory, "E").value
	$desig_value = $workSheet.Cells($createStory, "F").value
	$goal_amount = $workSheet.Cells($createStory, "G").value
	$sug_amount = $workSheet.Cells($createStory, "H").value
	$sug_desc = $workSheet.Cells($createStory, "I").value
	
	$teamcampaign_url = $workSheet.Cells($createTeamForSingleCause, "C").value
	$camp_title = $workSheet.Cells($createTeamForSingleCause, "D").value
	$camp_story = $workSheet.Cells($createTeamForSingleCause, "E").value
	$camp_goalamount = $workSheet.Cells($createTeamForSingleCause, "F").value
	$leaderboard_order = $workSheet.Cells($createTeamForSingleCause, "G").value
	$camp_url = $workSheet.Cells($createTeamForSingleCause, "H").value
	$modified_camp_url = $workSheet.Cells($createTeamForSingleCause, "I").value
	$camp_goaldate = $workSheet.Cells($createTeamForSingleCause, "J").value
	
	$camp2_title = $workSheet.Cells($createTeamForMultipleCause, "K").value
	$camp2_url = $workSheet.Cells($createTeamForMultipleCause, "L").value
	$modified_camp2_url = $workSheet.Cells($createTeamForMultipleCause, "M").value
	
	$widget_emailid = $workSheet.Cells($donateAnywere, "C").value
	$widget_fullname = $workSheet.Cells($donateAnywere, "D").value
	$widget_street = $workSheet.Cells($donateAnywere, "E").value
	$widget_city = $workSheet.Cells($donateAnywere, "F").value
	$widget_state = $workSheet.Cells($donateAnywere, "G").value
	$widget_pcode = $workSheet.Cells($donateAnywere, "H").value
	
	$mgcreator_name = $workSheet.Cells($matchingGrant, "C").value
	$mg_email = $workSheet.Cells($matchingGrant, "D").value
	$mg_totalamount = $workSheet.Cells($matchingGrant, "E").value
	$mg_date = $workSheet.Cells($matchingGrant, "F").value
	$mg_date = $workSheet.Cells($matchingGrant, "F").value
	$mg_donationamount = $workSheet.Cells($matchingGrant, "G").value
	
	$offline_donorname = $workSheet.Cells($offlineDonations, "C").value
	$offline_donoremail = $workSheet.Cells($offlineDonations, "D").value
	$offline_donoramount = $workSheet.Cells($offlineDonations, "E").value
	
	$meetup_title = $workSheet.Cells($myMeetup, "C").value
	$meetup_date = $workSheet.Cells($myMeetup, "D").value
	$meetup_location = $workSheet.Cells($myMeetup, "E").value
	$meetup_updatedlocation = $workSheet.Cells($myMeetup, "F").value

	$recipient_name = $workSheet.Cells($givingCard, "C").value
	$recipient_emailid = $workSheet.Cells($givingCard, "D").value
	$recipient_deliverydate = $workSheet.Cells($givingCard, "E").value
	$givingcard_amount = $workSheet.Cells($givingCard, "F").value
	$givingcard_url = $workSheet.Cells($givingCard, "G").value

# -------------------------------------- END : GETTING TEST DATA'S FROM EXCEL ------------------------

class RazooTestSuite < Test::Unit::TestCase
	
	#This method helps to invoke the Razoo Site
	def test_00_setup_razoo()
		
		invokeRazooSite($test_site)	
		
	end
	
# ------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 5 : AS A GUEST USER ISBAT DONATE TO ORG, POST COMMENT AND STORE MY CARD
#								AND VERIFY THE CARD IN PROFILE SCREEN.				
# ------------------------------------------------------------------------------------------------------------------------#
	
	def scenario5()
		
		puts "------------------------ START OF SCENARIO 5 --------------------"
		searchOrg($org_name,$org_url)
		donateUsingNewCard($donation_amount, $normal1_nameoncard, $street, $state, 
					$city, $pin_code, $visacard_number, $visa_seccode, $normal1_emailId)
		postComments("Give and be Blessed!!")
		checkMydonation($donation_amount, $org_name)
		verifyGuestUserSavedCard()
		changeMyPassword($normal1_password)
		logout()
		puts "------------------------ END OF SCENARIO 5 --------------------"
		puts"Duration: #{Time.now - $start} seconds"
	end


# --------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 6 : AS A NORMAL USER ISBAT CREATE FUNDRAISE PAGE, DONATE TO  FR,  AND POST COMMENT 
#										IN THANK YOU SCREEN.
# --------------------------------------------------------------------------------------------------------------------------------------#
	
	def scenario6()
		
		puts "------------------------  START OF SCENARIO 6 ----------------------- "
		login($normal1_emailId, $normal1_password)
		searchOrg($org_name,$org_url)
		createStoryPage($mynpo_ein, $org_name, $fr_name, $story_summary, $page_story, 
					$youtube_url, $desig_value, $goal_amount, $camp_goaldate, "link=Donations", 
					$sug_amount, $sug_desc)
		donateUsingNewCard($amount_cent, $normal1_nameoncard, $street, $state, 
					$city, $pin_code, $visacard_number, $visa_seccode, $normal1don_emailId)
		postComments("Give and be Blessed!!")
		logout()
		puts "------------------------  END OF SCENARIO 6 ----------------------- "
		puts"Duration: #{Time.now - $start} seconds"
	end


# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 7 : AS AN ORG ADMIN USER ISBAT CREATE PROEJCT PAGE, DONATE TO PROJECT, WITH TIPS, 
#		    USING SUGGESTED AMOUNT AND POST COMMENT IN THANK YOU SCREEN.
#
# PRE - CONDITION : 
#	Provide admin rights to the emailId which is passed in the Login Function.
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	
	def scenario7()
		
		puts "---------------------- START OF SCENARIO 7 ----------------------"
		# PRE - CONDITION - START
		login($globaladmin_emailId, $globaladmin_password)
		grantOrgAdminRights($admincon_url, $normal1_emailId, $mynpo_ein)
		logout()
		# PRE - CONDITION - END
		login($normal1_emailId, $normal1_password)
		createStoryPage($mynpo_ein, $org_name, $pro_name, $story_summary, $page_story, 
					$youtube_url, $desig_value, $goal_amount,  $camp_goaldate, "link=Donations", 
					$sug_amount, $sug_desc)
		donateUsingSavedCard($donation_amount,  $tip_amount)
		logout()
		puts "---------------------- END OF SCENARIO 7 --------------------------"
		puts"Duration: #{Time.now - $start} seconds"
	end

# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 8 : AS AN ORG ADMIN, ISBAT TO MAKE AN ANONYMOUS  RECURRING DONATION TO FR WITH DEDICATION
#		     AND POST COMMENT IN DONOR WALL, DELETE THE COMMENT AND REMOVE THE STORY FROM 
#		    THE "Causes I'm a Fan of" LIST.
#
#~ # ------------------------------------------------------------------------------------------------------------------------------------------------------#
	
	def scenario8()
		
		puts "---------------------- START OF SCENARIO 8 ----------------------"
		login($normal1_emailId, $normal1_password)
		searchOrg($org_name,$org_url)
		donateUsingAddCreditCard($donation_amount, $street, $state, $city, $pin_code,
						  $amexcard_number, $amex_seccode, "label=Weekly")
		deleteComments("Delete this comment")
		#removeFan($fr_name)
		logout()
		
		puts "---------------------- END OF SCENARIO 8 --------------------------"
		puts"Duration: #{Time.now - $start} seconds"
	end

# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 9 : AS AN ORG ADMIN, ISBAT TO CANCEL THE RECURRING DONATION AND DELETE THE STORED CARD.
#
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	
	def scenario9()
		
		puts "------- START OF SCENARIO 9 ----------"
		login($normal1_emailId, $normal1_password)
		cancelRecurringDonation()
		deleteStoredCard()
		logout()
		puts "------- END OF SCENARIO 9 ------------"
		puts"Duration: #{Time.now - $start} seconds"
	end


# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 10 : AS ANY USER, ISBAT RESEST MY PASSWORD IN MY USER PROFILE SCREEN.
#
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	
	def scenario10()
		
		puts "---------------------- START OF SCENARIO 10 ----------------------"
		login($normal1_emailId, $normal1_password)
		changeMyPassword($normal2_password)
		logout()
		login($normal1_emailId, $normal2_password)
		logout()
		puts "---------------------- END OF SCENARIO 10 --------------------------"
		puts"Duration: #{Time.now - $start} seconds"
	end

# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 1 : AS A RAZOO ADMIN, ISBAT CREATE ORG. EDIT NPO DETAILS, DO AUDIT AND BECOME A 
#		    FAN WITHOUT DONATING TO ORG.
#
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	
	def scenario1()
		
		puts "---------------------- START OF SCENARIO 1 ----------------------"
		login($globaladmin_emailId, $globaladmin_password)
		createOrg($admincon_url, $neworg_ein, $new_orgname, $org_city, $org_state)
		editNpoDetails($org_url, $org_firstname, $org_lastname, $org_address1, $org_address2, $org_emailId, $org_phonenum)
		auditVerifyOrg("Verified this ORG", $org_url)
		verifyNpoDetails()
		becomeFan()
		logout()
		puts "---------------------- END OF SCENARIO 1 --------------------------"
		puts"Duration: #{Time.now - $start} seconds"
	end


# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 2 : AS A RAZOO ADMIN, ISBAT CREATE EIN-LESS ORG. EDIT NPO DETAILS, DO AUDIT AND BECOME A 
#		    FAN WITHOUT DONATING TO ORG.
#
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	
	def scenario2()
		
		puts "---------------------- START OF SCENARIO 2 ----------------------"
		login($globaladmin_emailId, $globaladmin_password)
		createEinLessOrg($admincon_url, $new_einlessorgname, $org_city, $org_state)
		editNpoDetails($einlessorg_url, $org_firstname, $org_lastname, $org_address1, $org_address2, $org_emailId, $org_phonenum)
		auditVerifyOrg("Verified this ORG", $einlessorg_url)
		verifyNpoDetails()
		becomeFan()
		logout()
		puts "---------------------- END OF SCENARIO 2 --------------------------"
		puts"Duration: #{Time.now - $start} seconds"
	end
	
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 3 : AS A RAZOO ADMIN, ISBAT CREATE ORG. EDIT NPO DETAILS AND DO AUDIT.
#
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	
	def scenario3()
		
		puts "---------------------- START OF SCENARIO 3 ----------------------"
		login($globaladmin_emailId, $globaladmin_password)
		$neworg_ein = $workSheet.Cells($createOrg, "C").value
		$neworg_ein_afterincr = $neworg_ein.to_i()+1
		$workSheet.Cells($createOrg, "C").value = $neworg_ein_afterincr
		$workBook.Save
		$neworg2_ein = $neworg_ein_afterincr
		createOrg($admincon_url, $neworg2_ein, $new_orgname2, $org_city, $org_state)
		editNpoDetails($org2_url, $org_firstname, $org_lastname, $org_address1, $org_address2, $org_emailId, $org_phonenum)
		auditVerifyOrg("Verified this ORG", $org2_url)
		logout()
		puts "---------------------- END OF SCENARIO 3 --------------------------"
		puts"Duration: #{Time.now - $start} seconds"
	end

# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 4 : AS A RAZOO ADMIN, ISBAT CREATE ORG. EDIT NPO DETAILS AND DO AUDIT.
#
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	
	def scenario4()
		
		puts "---------------------- START OF SCENARIO 4 ----------------------"
		login($globaladmin_emailId, $globaladmin_password)
		$neworg_ein = $workSheet.Cells($createOrg, "C").value
		$neworg_ein_afterincr = $neworg_ein.to_i()+1
		$workSheet.Cells($createOrg, "C").value = $neworg_ein_afterincr
		$workBook.Save
		$neworg3_ein = $neworg_ein_afterincr
		createOrg($admincon_url, $neworg3_ein, $new_orgname3, $org_city, $org_state)
		$new_orgname2 = $workSheet.Cells($createOrg, "P").value
		editNpoDetails($org3_url, $org_firstname, $org_lastname, $org_address1, $org_address2, $org_emailId, $org_phonenum)
		auditVerifyOrg("Verified this ORG", $org3_url)
		logout()
		puts "---------------------- END OF SCENARIO 4 --------------------------"
		puts"Duration: #{Time.now - $start} seconds"
	end

# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 11 : AS A GUEST USER, ISBAT CREATE AN ACCOUNT WHILE DONATING TO NEWLY CREATED ORG & SHARE PAGE 
#								AND VERIFY NPO CATEGORY ICONS IN THE PROFILE SCREEN.
#
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	
	def scenario11()
		
		puts "---------------------- START OF SCENARIO 11 ----------------------"
		#~ #---------------- Run HACK URL - Start ------------------------------------#
		login($globaladmin_emailId, $globaladmin_password)
		runHackURL("/admin/reindex", "/admin/reindex_all", "/admin/memcached_flush", "/admin/regenerate_statistics")
		logout()
		#~ #---------------- Run HACK URL - End ------------------------------------#
		sleep 180
		searchOrg($new_orgname,$org_url)
		gotoDonFormClickSignup($donation_amount)
		createRazooAccount($normal2_firstname, $normal2_lastname, $normal2_emailId, $normal2_password)
		donateUsingNewCard($donation_amount, $normal2_nameoncard, $street, $state,  
					 $city, $pin_code, $mastercard_number, $mastercard_seccode, $normal2don_emailId)
		postComments("Give and be Blessed!!")
		checkMydonation($donation_amount, $new_orgname)
		logout()
		puts "---------------------- END OF SCENARIO 11 --------------------------"
		puts"Duration: #{Time.now - $start} seconds"
	end
	
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 12 : AS A NORMAL USER, ISBAT LOGIN TO RAZOO WHILE DONATING TO NEWLY ORG AND VERIFY NPO 
#											CATEGORY ICONS IN THE PROFILE SCREEN.
#		   
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	
	def scenario12()
		
		puts "---------------------- START OF SCENARIO 12 ----------------------"
		searchOrg($new_orgname,$org_url)
		gotoDonFormClickLogin($donation_amount, $normal2_emailId, $normal2_password)
		donateUsingNewCard($donation_amount, $normal2_nameoncard, $street, $state, 
					 $city, $pin_code, $mastercard_number, $mastercard_seccode, $normal2don_emailId)
		postComments("Give and be Blessed!!")
		checkMydonation($donation_amount, $new_orgname)
		logout()
		puts "---------------------- END OF SCENARIO 12 --------------------------"
		puts"Duration: #{Time.now - $start} seconds"
	end
	
# -----------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 13 : AS A TEAM CAPTAIN, ISBAT CREATE A CAMPAIGN PAGE FOR SPECIFIC CAUSE, EDIT THE SAME, CREATE FUNDRAISER
#		TEMPLATE FOR THE CAMP AND MAKE OFFLINE AND ONLINE DONATION, VERIFY THE LEADERBOARD OF TEAM CAMPAIGN PAGE.
#		   
# -----------------------------------------------------------------------------------------------------------------------------------------------------------------------#

	def scenario13()
		
		puts "---------------------- START OF SCENARIO 13 ----------------------"
		login($normal2_emailId, $normal2_password)
		createTeamCampaignSpecificCause($teamcampaign_url, $org_name, $camp_title, $camp_story, $camp_goalamount, $camp_goaldate)
		editTeamCampaign($leaderboard_order, $camp_url)
		createTeamFundraiserTemplate($story_summary, $camp_goalamount)
		donateUsingSavedCard($donation_amount, $tip_amount)
		createTeamOfflineDonation($modified_camp_url, $normal2_firstname, $normal2_lastname, $camp_title, $offline_donorname, $offline_donoremail, $offline_donoramount)
		verifySingleCauseLeaderboard($modified_camp_url)
		logout()
		puts "---------------------- END OF SCENARIO 13 -----------------------"
		puts"Duration: #{Time.now - $start} seconds"
		
	end
	
# -----------------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 14 : AS A TEAM CAPTAIN, ISBAT CREATE A CAMPAIGN PAGE FOR MULTIPLE CAUSE,  POST COMMENT, CREATE FUNDRAISER
#					FOR THE CAMP AND MAKE DONATION, VERIFY THE LEADERBOARD OF TEAM CAMPAIGN PAGE.
#		   
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------#

	def scenario14()
		
		puts "---------------------- START OF SCENARIO 14 ----------------------"
		login($normal2_emailId, $normal2_password)
		createTeamCampaignMultipleCause($teamcampaign_url, $camp2_title, $camp_story, $camp_goalamount, $camp_goaldate)
		postTeamComments("Comment from Team Captain!!")
		editTeamCampaign($leaderboard_order, $camp2_url)
		createTeamCampFundraiser($teamcamp2_fr, $story_summary, $page_story, $youtube_url, $sug_amount, $sug_desc, $camp_goalamount)
		donateUsingSavedCard($donation_amount, $tip_amount)
		verifyMulitpleCauseLeaderboard($modified_camp2_url, $sug_amount, $teamcamp2_fr)
		logout()
		puts "---------------------- END OF SCENARIO 14 ----------------------"
		puts"Duration: #{Time.now - $start} seconds"
	end
	 
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 15 : AS A  TEAM CAPTAIN, ISBAT UNLINK A FUNDRAISER FROM MY TEAM.
#		   
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------#

	def scenario15()
		
		puts "---------------------- START OF SCENARIO 15 ----------------------"
		login($normal2_emailId, $normal2_password)
		sleep 10
		removeFundraiserFromTeam($modified_camp2_url,$teamcamp2_fr)
		logout()
		puts "---------------------- END OF SCENARIO 15 ----------------------"
		puts"Duration: #{Time.now - $start} seconds"
		
	end
	
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 16 : AS A STORYADMIN, ISBAT MAKE A DONATION THROUGH DONATION WIDGET OPTION IN THE STORY PAGE.
#		   
# ------------------------------------------------------------------------------------------------------------------------------------------------------#

	def scenario16()
		
		puts "---------------------- START OF SCENARIO 16 ----------------------"
		login($normal1_emailId, $normal2_password)
		searchProject($pro_name)
		donationWidget($donation_amount, $widget_emailid, $widget_fullname, $widget_street, $widget_city, $widget_state, $widget_pcode, $visacard_number, $visa_seccode, $tip_amount)
		logout()
		puts "---------------------- END OF SCENARIO 16 ----------------------"
		puts"Duration: #{Time.now - $start} seconds"
		
	end
	
# -------------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 17 : AS A STORYADMIN, ISBAT CREATE A MATCHING GRANT, MAKE A DONATION AND CLOSE THE ,MATCHING GRANT.
#		   
# -------------------------------------------------------------------------------------------------------------------------------------------------------------#

	def scenario17()
		
		puts "---------------------- START OF SCENARIO 17 ----------------------"
		login($normal1_emailId, $normal2_password)
		searchProject($pro_name)
		createMatchingGrant($mgcreator_name, $mg_email, $mg_totalamount, $mg_date)
		donateUsingNewCard($mg_donationamount, $normal1_nameoncard, $street, $state, 
					$city, $pin_code, $visacard_number, $visa_seccode, $normal1don_emailId)
		closeMatchingGrant($mg_donationamount)
		logout()
		puts "---------------------- END OF SCENARIO 17 ----------------------"
		puts"Duration: #{Time.now - $start} seconds"
	
	end

# -------------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 18 : AS A STORYADMIN, ISBAT CREATE A  CHALLENGE GRANT, MAKE A DONATION AND CLOSE THE ,CHALLENGE GRANT.
#		   
# -------------------------------------------------------------------------------------------------------------------------------------------------------------#

	def scenario18()
		
		puts "---------------------- START OF SCENARIO 18 ----------------------"
		login($normal1_emailId, $normal2_password)
		searchProject($pro_name)
		createChallengeGrant($mgcreator_name, $mg_email, $mg_totalamount, $mg_date)
		donateUsingSavedCard($donation_amount, $tip_amount)
		closeChallengeGrant($mg_donationamount)
		logout()
		puts "---------------------- END OF SCENARIO 18 ----------------------"
		puts"Duration: #{Time.now - $start} seconds"
	
	end
# -------------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 19 : AS A STORYADMIN, ISBAT CREATE A NEW OFFLINE DONATIONS AND VERIFY IN  THE THERMOMETER.																						
# -------------------------------------------------------------------------------------------------------------------------------------------------------------#

	def scenario19()
	
		puts "---------------------- START OF SCENARIO 19 ----------------------"
		login($normal1_emailId, $normal2_password)
		searchProject($pro_name)
		createOfflineDonation($offline_donorname, $offline_donoremail, $offline_donoramount)
		logout()
		puts "---------------------- END OF SCENARIO 19 ----------------------"
		puts"Duration: #{Time.now - $start} seconds"
	
	end

# ------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 20 : AS A STORYADMIN, ISBAT ADD/UPDATE/CLEAR MY MEETUP AND VERIFY PROJECT SETUP AFTER 100% COMPLETION.																				
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------#

	def scenario20()
		
		puts "---------------------- START OF SCENARIO 20 ----------------------"
		login($normal1_emailId, $normal2_password)
		searchProject($pro_name)
		addMeetup($meetup_title, $meetup_date, $meetup_location, $meetup_updatedlocation)
		clearMeetup()
		logout()
		puts "---------------------- END OF SCENARIO 20 ----------------------"
		puts"Duration: #{Time.now - $start} seconds"
	end

# ----------------------------------------------------------------------------------------------------------------------#
# SCENARIO 21 : AS A STORY ADMIN,  ISBAT PURCHASE A GIVING CARD OF 10 DOLLAR WORTH.																		
# ----------------------------------------------------------------------------------------------------------------------#

	def scenario21()
		
		puts "---------------------- START OF SCENARIO 21 ----------------------"
		login($normal1_emailId, $normal2_password)
		purchaseGivingCard($recipient_name, $recipient_emailid, $recipient_deliverydate, $givingcard_amount, $givingcard_url)
		logout()
		puts "---------------------- END OF SCENARIO 21 ----------------------"
		puts"Duration: #{Time.now - $start} seconds"
	
	end

# -------------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 22 : AS A STORY ADMIN, ISBAT CREATE A THEMED FUNDRAISER FROM A TEMPLATE.																			
# -------------------------------------------------------------------------------------------------------------------------------------------------------------#

	def scenario22()
		
		puts "---------------------- START OF SCENARIO 22 ----------------------"
		login($normal1_emailId, $normal2_password)
		searchOrg($org_name, $org_url)
		createThemedFundraiser($normal1_firstname, $normal1_lastname, $story_summary, $page_story, $sug_desc, $donation_amount)
		logout()
		puts "---------------------- END OF SCENARIO 22 ----------------------"
		puts"Duration: #{Time.now - $start} seconds"
	
	end


# -------------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 23 : AS A RAZOO GLOBAL ADMIN, ISBAT REMOVE ORG ADMINS FROM THE ORG PAGE.
#
# -------------------------------------------------------------------------------------------------------------------------------------------------------------#

	def scenario23()
		
		puts "---------------------- START OF SCENARIO 23 ----------------------"
		login($globaladmin_emailId, $globaladmin_password)
		searchOrg($new_orgname, $org_url)
		removeOrgAdminRights($org_url, $normal2_emailId)
		logout()	
		puts "---------------------- END OF SCENARIO 23 ----------------------"
		puts"Duration: #{Time.now - $start} seconds"
	
	end

# -------------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 24 : AS A NORMAL USER, ISBAT VERIFY PERSON AND ORG UNDER 'PERSON I MAY KNOW' & 'CAUSES I MAY LIKE'
#										SECTION IN THE USER PROFILE SCREEN.
#
# -------------------------------------------------------------------------------------------------------------------------------------------------------------#

	def scenario24()
		
		puts "---------------------- START OF SCENARIO 24 ----------------------"
		sleep 2
		causesAndPersonIlike($org2_url, $org3_url, $new_orgname3, $personuser_firstname, $personuser_lastname, 
						$personuser_emailId, $causeuser_firstname, $causeuser_emailId, $personuser_password)
		logout()				
		puts "---------------------- END OF SCENARIO 24 ----------------------"
		puts"Duration: #{Time.now - $start} seconds"
	
	end

# -------------------------------------------------------------------------------------------------#
# SCENARIO 25 : AS A STORY ADMIN, DELETE MY STORY PAGE FROM RAZOO.
#
# -------------------------------------------------------------------------------------------------#

	def scenario25()
		
		puts "---------------------- START OF SCENARIO 25 ----------------------"
		login($normal1_emailId, $normal2_password)
		wishlist($pro_name)
		deleteMyStoryPage($pro_name)
		logout()
		puts "---------------------- END OF SCENARIO 25 ----------------------"
		puts"Duration: #{Time.now - $start} seconds"
	end
	
# -------------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 26 : AS A RAZOO GLOBAL ADMIN, ISBAT CREATE 'CAN IMPERSONATE' PERMISSION.
#
# -------------------------------------------------------------------------------------------------------------------------------------------------------------#

	def scenario26()
		
		puts "---------------------- START OF SCENARIO 26 ----------------------"
		login($globaladmin_emailId, $globaladmin_password)
		impersonatePermission($admincon_url, $normal2_emailId, $normal2_firstname, $normal2_lastname)
		logout()
		puts "---------------------- END OF SCENARIO 26 ----------------------"
		puts"Duration: #{Time.now - $start} seconds"
	
	end

# -------------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 28 : AS AN USER ISBAT LINK MY GMAIL/FACEBOOK ACCOUNT WITH THE RAZOO APPLICATION.
#
# -------------------------------------------------------------------------------------------------------------------------------------------------------------#

	def scenario28()
		
		puts "---------------------- START OF SCENARIO 28 ----------------------"
		loginViaGmail($gmail_emailId, $gmail_password)
		logout()
		loginViaFacebook($fb_emailId, $fb_password)
		logout()
		puts "---------------------- END OF SCENARIO 28 ----------------------"
		puts"Duration: #{Time.now - $start} seconds"
	
	end

	#This method helps to stop the Current browser
	def scenario29()
		
		$workBook.Save
		$workBook.Close
		$excel.Quit
		stopBrowser()
		
		
	end
	
# -------------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 27 : AS RAZOO ADMIN ISBAT ADD & VERIFY STORY URN IN 'CAUSES BY AMOUNT' SECTION#
# -------------------------------------------------------------------------------------------------------------------------------------------------------------#
	def scenario27()
		puts "---------------------- START OF SCENARIO 27 ----------------------"
		login($globaladmin_emailId, $globaladmin_password)
		addCausesByAmount()
		removeCausesByAmount()
		logout()
		puts "---------------------- START OF SCENARIO 27 ----------------------"
		puts"Duration: #{Time.now - $start} seconds"
	end
	
	
	
	
	#-------------------Stating Scenarios----------------------#
	def test_01_Razoo()
		
		scenario1()  # As RazAdmin ISBAT create an EIN-ORG and become as non donated - fan.		
		
		scenario2()  # As RazAdmin ISBAT create an EINLESS-ORG and become as non donated - fan.		
		
   		scenario3()  # As RazAdmin ISBAT create ORG & do audit.		
		
		scenario4()  #As RazAdmin ISBAT create ORG & do audit.		
		
		scenario5()  #As Guest user ISBAT Donate to ORG & create account.	
		
		scenario6()  #As Normal user ISBAT create FR & donate to FR & post Comment in thank you screen.
		
		scenario7()  #As Admin user ISBAT create PRO & donate to PRO by sugeested amounts & post Comment in thank you screen.
		
		scenario8()  # As ORG admin ISBAT make recurring donation anonoymously with dedication & post Comments in Donor wall.
		
		scenario9()  # As ORG admin ISBAT cancel Recurring donation and Delete card.
		
		scenario10() # Reset my Password.
		
		scenario11() # As Guest user Create account while donating to ORG & verify catogory icon in profile.
		
		scenario12() # As Normal user Login in donation form & make a donation & verify catogory icon in profile.
	
		scenario13() # As TeamCaptain Create Specific cause team and Create FR and verify Team LB.
		
		scenario14() #As TeamCaptain Create Multiple cause team and Create FR and verify Team LB.
	
		scenario15() #As Team Captain ISBAT remove FR from Team LB.
		
		scenario16() #As Story admin ISBAT donate through Donation Widget.
		
		scenario17() #As Story admin ISBAT create MG & verify it & Close it.
		
		##~ scenario18()  #Challenge Grant Functionality - Removed from Release 2.4
		
		scenario19() #As Story admin ISBAT add offline donation and verify it.		
		
		scenario20() #As Story admin ISBAT add/update/delete Meet up.	
		
		scenario21() #As Story admin ISBAT purchase Giving Card.	
		
		##scenario22() #Themed Fundraiser functionality - Removed from Release 2.1.	
		
		scenario23() #As Global Admin ISBAT remove ORG admin rights.
		
		scenario24() # Verify 'Person I may Know' & 'Causes I may like' section.										
		
		scenario25() # As Story admin Delete PRO/FR page.
		
		scenario26() #As RazAdmin ISBAT impersonate.
		
		scenario27() #As RazAdmin ISBAT add/Verify Story in 'Causes By Amount Section'. 
		
		scenario28() #As User link my FB/TWITTER account to Razoo.
		
		scenario29() #This method helps to stop the Current browser
		
	end
	#-------------------Ending Scenarios----------------------#
	
	
end