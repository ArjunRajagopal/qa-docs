require "test/unit"
require "rubygems"
require "selenium/client"
require "Razoo_Test_Cases_FireFox.rb"
require "win32ole"


# Variable declarations
$siteRow = 3;  $globalAdmin = 3


# -------------------------------------- START : GETTING TEST DATA'S FROM EXCEL ------------------------
$test_data ="D:\\EBI\\MyProjects\\Razoo\\Automation\\Selenium\\Selenium2\\ModularFramework\\Deletion of FR and Project\\Razoo_Firefox_TestData.xls"
	
	$excel = WIN32OLE::new("excel.application")
	$workBook = $excel.Workbooks.Open($test_data)
	workSheetCount = $workBook.worksheets.count
	puts "Total WorkSheet count in Excel: #{workSheetCount}"
	$workSheet = $workBook.worksheets(1)
	$workSheet.select
	$rowCount = $workSheet.UsedRange.Rows.Count
	puts "Row count is : #{$rowCount}"
	$test_site = $workSheet.Cells($siteRow, "A").value
	# Getting Razoo Admin credentials
	$globaladmin_emailId = $workSheet.Cells($globalAdmin, "C").value
	$globaladmin_password = $workSheet.Cells($globalAdmin, "D").value
	

# -------------------------------------- END : GETTING TEST DATA'S FROM EXCEL ------------------------

class RazooTestSuite < Test::Unit::TestCase

	#This method helps to invoke the Razoo Site
	def test_00_setup_razoo()
		
		invokeRazooSite($test_site)	
		
	end
	
	def test_01_razooadmin_login()
		
		puts "------------------------ START OF SCNEARIO 1 ------------------------"
		login($globaladmin_emailId, $globaladmin_password)
		puts "------------------------ END OF SCNEARIO 1 ------------------------"
	end
	
	def test_02_fundraiserdeletion()
		
		puts "------------------------ START OF SCENARIO 2 --------------------"
		for rowvalue in 3...$rowCount+1
			# Getting Story URN
			$story_urn = $workSheet.Cells(rowvalue, "E").value
			print rowvalue, "th row value in Story URN column : ", $story_urn , "\n";
			deleteFundraiser($story_urn)
		end
		logout()
		puts "------------------------ START OF SCENARIO 2 --------------------"
	end

	def test_03_stopbrowser()
		
		$workBook.Save
		$workBook.Close
		$excel.Quit
		stopBrowser()
		
	end
	
end
    
