#-------------------------------------------------------------#
#  RazooTestSuite Class
#
# Author: EBI,SDR and SID
# Date: 4-OCT-2010
# Description:  It is a Class which contains all the methods thats need to be Executed
#
# -------------------------------------------------------------#
require "test/unit"
require "rubygems"
require "selenium/client"
require "Razoo_Test_Cases_Explorer.rb"
require "win32ole"


# Variable declarations
$siteRow = 3; $normalUser1 = 5; $normalUser2 = 6;  $globalAdmin = 7;
$sharePage = 5; $other_amounts = 5; 
$visaCard = 11; $amexCard = 12; $masterCard = 13;
$createOrg = 17; $storyNames = 21; $createStory = 25;
$createTeamCamp = 29; $donateAnywere = 33;
$matchingGrant = 37; $offlineDonations = 41;


# -------------------------------------- START : GETTING TEST DATA'S FROM EXCEL ------------------------
$test_data ="D:\\EBI\\MyProjects\\Razoo\\Automation\\Selenium\\Selenium2\\ModularFramework\\Selenium Demo Scripts\\RazooTestData.xls"

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
	
	excel.Workbooks.Close

# -------------------------------------- END : GETTING TEST DATA'S FROM EXCEL ------------------------

class RazooTestSuite < Test::Unit::TestCase

	#This method helps to invoke the Razoo Site
	def test_00_setup_razoo()
		
		invokeRazooSite($test_site)	
	end
	
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 1 : AS A RAZOO ADMIN, ISBAT CREATE ORG. EDIT NPO DETAILS, DO AUDIT AND BECOME A 
#		    FAN WITHOUT DONATING TO ORG.
#
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	
	def test_01_createORG_NPOdetails_audit()
		
		puts "---------------------- START OF SCENARIO 1 ----------------------"
		login($globaladmin_emailId, $globaladmin_password)
		createOrg($admincon_url, $neworg_ein, $new_orgname, $org_city, $org_state)
		editNpoDetails($org_firstname, $org_lastname, $org_address1, $org_address2, $org_emailId, $org_phonenum)
		auditVerifyOrg("Verified this ORG")
		verifyNpoDetails()
		becomeFan()
		logout()
		puts "---------------------- END OF SCENARIO 1 --------------------------"
	end
	
# -----------------------------------------------------------------------------------------------------#
# SCENARIO 2 : AS A GUEST USER ISBAT DONATE TO ORG AND POST COMMENT.
# -----------------------------------------------------------------------------------------------------#
	
	def test_02_guestuser_donation_ORG()
		
		puts "------------------------ START OF SCENARIO 2 --------------------"
		searchOrg($org_name)
		donateUsingNewCard($donation_amount, $normal1_nameoncard, $street, $state, 
					$city, $pin_code, $visacard_number, $visa_seccode, $normal1don_emailId)
		postComments("Give and be Blessed!!")
		puts "------------------------ END OF SCENARIO 2 --------------------"
	end


# --------------------------------------------------------------------------------------------------------------------------------------#
# SCENARIO 3 : AS A NORMAL USER ISBAT CREATE FUNDRAISE PAGE, DONATE TO  FR, SHARE STORY THORUGH 
#		    EMAIL AND POST COMMENT IN DONOR AND FACEBOOK.
# --------------------------------------------------------------------------------------------------------------------------------------#
	
	def test_03_normaluser_share_donation_FR_NewCard()
		
		puts "------------------------  START OF SCENARIO 3 ----------------------- "
		createRazooAccount($normal1_firstname, $normal1_lastname, $normal1_emailId, $normal1_password)
		searchOrg($org_name)
		createStoryPage($mynpo_ein, $org_name, $fr_name, $story_summary, $page_story, 
					$youtube_url, $desig_value, $goal_amount, "link=30", "link=Donations", 
					$sug_amount, $sug_desc)
		donateUsingNewCard($amount_cent, $normal1_nameoncard, $street, $state, 
					$city, $pin_code, $visacard_number, $visa_seccode, $normal1don_emailId)
		postComments("Give and be Blessed!!")
		checkMydonation($amount_cent)
		logout()
		puts "------------------------  END OF SCENARIO 3 ----------------------- "
	end


	#This method helps to stop the browser.
	def test_04_stop_browser()
		
		stopBrowser()
		#~ login($globaladmin_emailId, $globaladmin_password)
		#~ runHackURL("/admin/reindex", "/admin/reindex_all", "/admin/memcached_flush", "/admin/regenerate_statistics")
	end

end