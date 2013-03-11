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
# -------------------------------------------------------------#
require "test/unit"
require "rubygems"
require "selenium/client"
gem "selenium-client"
require "Razoo_Test_Cases_FireFox.rb"
require "win32ole"

# Variable declarations
$siteRow = 3; $orgName = 5; $newCard = 9


# -------------------------------------- START : GETTING TEST DATA'S FROM EXCEL ------------------------
$test_data ="D:\\EBI\\MyProjects\\Razoo\\Automation\\Selenium\\Selenium2\\ModularFramework\\Excel Method\\TestData.xls"

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
	$org_name = workSheet.Cells($orgName, "C").value
	$donation_amount = workSheet.Cells($newCard, "C").value
	$name_on_card = workSheet.Cells($newCard, "D").value
	$street = workSheet.Cells($newCard, "E").value
	$city = workSheet.Cells($newCard, "F").value
	$state = workSheet.Cells($newCard, "G").value
	$pin_code = workSheet.Cells($newCard, "H").value
	$card_number = workSheet.Cells($newCard, "I").value
	$sec_code = workSheet.Cells($newCard, "J").value
	$email_id = workSheet.Cells($newCard, "k").value
	
	# Closing the Excelsheet
	excel.Workbooks.Close

# -------------------------------------- END : GETTING TEST DATA'S FROM EXCEL ------------------------

class RazooTestSuite < Test::Unit::TestCase

	#This method helps to invoke the Razoo Site
		def test_00_setup_razoo()
		
			invokeRazooSite($test_site)	
			puts "Scenario 1 is set to run now !!!" 
		end

# -----------------------------------------------------------------------------------------------------#
#SCENARIO 1 : AS A GUEST USER ISBAT DONATE TO ORG AND CREATE AN ACCOUNT.
# -----------------------------------------------------------------------------------------------------#
	
	def test_01_guestuser_donation_ORG()
		
		puts "------------------------ START OF SCENARIO 1 --------------------"
		searchOrg($org_name)
		donateUsingNewCard($donation_amount, $name_on_card, $street, $state, 
						$city, $pin_code, $card_number, $sec_code, $email_id)
		viewComments()
		#createRazooAccount("Mr", "Oct14", "oct14@firefox6.com", "123456")
		puts "------------------------ END OF SCENARIO 1 --------------------"
	end


# ----------------------------------------------------------------------------------------------------------------------------------#
#SCENARIO 2 : AS A NORMAL USER ISBAT CREATE FUNDRAISE PAGE, DONATE TO  FR AND POST COMMENT.
# ----------------------------------------------------------------------------------------------------------------------------------#
	#~ def test_02_normaluser_donation_FR_NewCard()
		
		#~ puts "------------------------  START OF SCENARIO 2 ----------------------- "
		#~ searchOrg("Harvard College")
		#~ createStoryPage("Harvard College", "FirefoxFR6 for Harvard College", "Summary Part ", "Story Part", 
				#~ "http://www.youtube.com/watch?v=HNVSI_r9SVg" , "With Designation", 
				#~ "100",  "link=31", "link=Donations", "10", "Suggested Amount")
		#~ donateUsingNewCard("10.50", "Mr Oct5", "2nd Street", "Washington DC", 
				#~ "Washington", "95008", "4111111111111111", "123", "oct14@firefox6.com")
		#~ postComments("Give and be Blessed!!", "fbuser1@rediffmail.com", "111111")
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
	#~ def test_03_orgadmin_donation_PRO_SavedCard()
		
		#~ puts "---------------------- START OF SCENARIO 3 ----------------------"
		#~ # PRE - CONDITION - START
		#~ login("ebi@srasys.co.in", "123456")
		#~ grantOrgAdminRights("/admin", "oct14@firefox6.com", "042103580")
		#~ logout()
		#~ # PRE - CONDITION - END
		#~ login("oct14@firefox6.com", "123456")
		#~ createStoryPage("Harvard College", "FirefoxPRO6 of Harvard College", "Summary Part ", "Story Part", 
				#~ "http://www.youtube.com/watch?v=HNVSI_r9SVg" , "With Designation", 
				#~ "100",  "link=31", "link=Donations", "10", "Suggested Amount")
		#~ donateUsingSavedCard("10.00",  "9.00")
		#~ puts "---------------------- END OF SCENARIO 3 --------------------------"
	#~ end

# ------------------------------------------------------------------------------------------------------------------------------------------------------#
#SCENARIO 4 : AS AN ORG ADMIN, ISBAT TO MAKE AN ANONYMOUS  RECURRING DONATION TO FR AND POST COMMENT
#		    IN DONOR WALL AND FACEBOOK, DELETE THE COMMENT AND REMOVE THE STORY FROM THE "Causes I'm a Fan of" LIST.
#
#~ # ------------------------------------------------------------------------------------------------------------------------------------------------------#
	#~ def test_04_AddNewCard_deletecomment_removefan()
		
		#~ puts "---------------------- START OF SCENARIO 4 ----------------------"
		#~ searchFR("FirefoxFR6 for Harvard College")
		#~ donateUsingAddCreditCard("10.00", "Mr Oct5", "2nd Street", "Washington DC",  "Washington", "95008",
						  #~ " 378282246310005", "1234", "label=Weekly")
		#~ deleteComments("Delete this comment")
		#~ removeFan("FirefoxFR6 for Harvard College")
		#~ puts "---------------------- END OF SCENARIO 4 --------------------------"
	#~ end

# ------------------------------------------------------------------------------------------------------------------------------------------------------#
#SCENARIO 5 : AS AN ORG ADMIN, ISBAT TO MAKE AN ANONYMOUS DONATION TO FR AND POST COMMENT IN DONOR WALL 
#		    AND FACEBOOK, DELETE THE COMMENT AND REMOVE THE STORY FROM THE "Causes I'm a Fan of" LIST.
#
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	#~ def test_05_cancelrecurringdonation_deletecard()
		
		#~ puts "------- START OF SCENARIO 5 ----------"
		#~ cancelRecurringDonation()
		#~ deleteStoredCard()
		#~ logout()
		#~ puts "------- END OF SCENARIO 5 ------------"
	#~ end


# ------------------------------------------------------------------------------------------------------------------------------------------------------#
#SCENARIO 6 : AS ANY USER, ISBAT RESEST MY PASSWORD IN MY USER PROFILE SCREEN.
#
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	#~ def test_06_change_mypassword()
		
		#~ puts "---------------------- START OF SCENARIO 6 ----------------------"
		#~ login("oct14@firefox6.com", "123456")
		#~ changeMyPassword("1234567")
		#~ logout()
		#~ login("oct14@firefox6.com", "1234567")
		#~ logout()
		#~ puts "---------------------- END OF SCENARIO 6 --------------------------"
	#~ end

# ------------------------------------------------------------------------------------------------------------------------------------------------------#
#SCENARIO 7 : AS A RAZOO ADMIN, ISBAT CREATE ORG. EDIT NPO DETAILS, DO AUDIT AND BECOME A 
#		    FAN WITHOUT DONATING TO ORG.
#
# ------------------------------------------------------------------------------------------------------------------------------------------------------#
	#~ def test_07_createORG_NPOdetails_audit()
		
		#~ puts "---------------------- START OF SCENARIO 7 ----------------------"
		#~ login("ebi@srasys.co.in", "123456")
		#~ createOrg("/admin", "111111115", "Firefox ORG6", "Firefox City", "Firefox State")
		#~ editNpoDetails("First Name", "Last Name", "Addres 1", "Addres 2", "sra@firefox.com", "123456789")
		#~ auditVerifyOrg("Verified this ORG")
		#~ verifyNpoDetails()
		#~ becomeFan()
		#~ logout()
		#~ puts "---------------------- END OF SCENARIO 7 --------------------------"
	#~ end
	
	
	#This method helps to stop the browser.
	def test_08_stop_browser()
		stopBrowser()
	end

	
end
    
