require "test/unit"
require "rubygems"
require "selenium/client"
require "Razoo_Test_Cases_FireFox.rb"
require "win32ole"


# Variable declarations
$siteRow = 3; 


# -------------------------------------- START : GETTING TEST DATA'S FROM EXCEL ------------------------
$test_data ="D:\\EBI\\MyProjects\\Razoo\\Automation\\Selenium\\Selenium2\\ModularFramework\\AutoAccountCreation and FRCreation\\Razoo_Firefox_TestData.xls"
	
	$excel = WIN32OLE::new("excel.application")
	$workBook = $excel.Workbooks.Open($test_data)
	workSheetCount = $workBook.worksheets.count
	puts "Total WorkSheet count in Excel: #{workSheetCount}"
	$workSheet = $workBook.worksheets(1)
	$workSheet.select
	$rowCount = $workSheet.UsedRange.Rows.Count
	puts "Row count is : #{$rowCount}"
	
	$test_site = $workSheet.Cells($siteRow, "A").value
	

# -------------------------------------- END : GETTING TEST DATA'S FROM EXCEL ------------------------

class RazooTestSuite < Test::Unit::TestCase

	#This method helps to invoke the Razoo Site
	def test_00_setup_razoo()
		
		invokeRazooSite($test_site)	
		
	end
	
	def test_01_accountcreation_frcreation()
		
		puts "------------------------ START OF SCENARIO 1 --------------------"
		
		for rowvalue in 5...$rowCount+1
			
			$normal_firstname = $workSheet.Cells(rowvalue, "C").value
			print rowvalue, "th row value in C : ", $normal_firstname , "\n";
			$normal_lastname = $workSheet.Cells(rowvalue, "D").value
			print rowvalue, "th row value in D : ", $normal_lastname , "\n";
			$normal_emailId = $workSheet.Cells(rowvalue, "E").value
			print rowvalue, "th row value in E : ", $normal_emailId , "\n";
			$normal_password = $workSheet.Cells(rowvalue, "F").value
			print rowvalue, "th row value in F : ", $normal_password , "\n";
			$org_url = $workSheet.Cells(rowvalue, "H").value
			print rowvalue, "th row value in H : ", $org_url , "\n";
			$org_ein = $workSheet.Cells(rowvalue, "I").value
			print rowvalue, "th row value in I : ", $org_ein , "\n";
			$fr_name = $workSheet.Cells(rowvalue, "J").value
			print rowvalue, "th row value in J : ", $fr_name , "\n";
			$story_summary = $workSheet.Cells(rowvalue, "K").value
			print rowvalue, "th row value in K : ", $story_summary , "\n";
			$page_story = $workSheet.Cells(rowvalue, "L").value
			print rowvalue, "th row value in L : ", $page_story , "\n";
			$desig_value = $workSheet.Cells(rowvalue, "M").value
			print rowvalue, "th row value in M : ", $desig_value , "\n";
			$goal_amount = $workSheet.Cells(rowvalue, "N").value
			print rowvalue, "th row value in N : ", $goal_amount , "\n";
			$sug_amount = $workSheet.Cells(rowvalue, "O").value
			print rowvalue, "th row value in O : ", $sug_amount , "\n";
			$sug_desc = $workSheet.Cells(rowvalue, "P").value
			print rowvalue, "th row value in P : ", $sug_desc , "\n";

			createRazooAccount($normal_firstname, $normal_lastname, $normal_emailId, $normal_password)
			createStoryPage($org_url, $org_ein, $fr_name, $story_summary, $page_story, 
							$desig_value, $goal_amount,  "link=30",  
								$sug_amount, $sug_desc)
			logout()
		end
		puts "------------------------ START OF SCENARIO 1 --------------------"
		
	end

	def test_02_stopbrowser()
		
		$workBook.Save
		$workBook.Close
		$excel.Quit
		stopBrowser()
		
	end
	
end
    
