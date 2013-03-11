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
require "Razoo_Test_Cases_FireFox.rb"
require "win32ole"


# Variable declarations
$siteRow = 3; $normalUser1 = 5; 

# -------------------------------------- START : GETTING TEST DATA'S FROM EXCEL ------------------------
	$test_data ="D:\\EBI\\MyProjects\\Razoo\\Automation\\Selenium\\Selenium2\\ModularFramework\\Scripts used for presentation\\Razoo_Firefox_TestData.xls"
	
	$excel = WIN32OLE::new("excel.application")
	$workBook = $excel.Workbooks.Open($test_data)
	workSheetCount = $workBook.worksheets.count
	puts "Total WorkSheet count in Excel: #{workSheetCount}"
	workSheet = $workBook.worksheets(1)
	workSheet.select
	rowCount = workSheet.UsedRange.Rows.Count
	puts "Row count is : #{rowCount}"
	
	$test_site = workSheet.Cells($siteRow, "A").value

	#----------------- Changing the static value in Excel - End -----------#
	$normal1_firstname = workSheet.Cells($normalUser1, "G").value
	$normal1_lastname = workSheet.Cells($normalUser1, "H").value
	$normal1_emailId = workSheet.Cells($normalUser1, "I").value
	$normal1_password = workSheet.Cells($normalUser1, "J").value
	

# -------------------------------------- END : GETTING TEST DATA'S FROM EXCEL ------------------------

class RazooTestSuite < Test::Unit::TestCase

	#This method helps to invoke the Razoo Site
	def setup()
		puts "START : Inside Setup method"
		#invokeRazooSite("http://www-qatrunk.razoo.com/")	
		invokeRazooSite($test_site)	
		puts "END : Inside Setup method"
	end

	def test_01_createaccount()
		puts "START : Inside Create Account method"
		createRazooAccount($normal1_firstname, $normal1_lastname, $normal1_emailId, $normal1_password)
		#createRazooAccount("First Name", "Last Name", "user6@aol.com", "123456")
		logout()
		puts "END : Inside Create Account method"
	end
	
	def test_02_login()
		puts "START : Inside Login method"
		login($normal1_emailId, $normal1_password)
		#login("user5@aol.com", "123456")
		logout()
		puts "END : Inside Login method"
	end

	#~ def teardown()
		#~ puts "START : Inside Tear down method"
		#~ $workBook.Save
		#~ $workBook.Close
		#~ $excel.Quit
		#~ stopBrowser()
		#~ puts "END : Inside Tear down method"
	#~ end
	
end
    
