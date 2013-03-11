require "test/unit"
require "rubygems"
require "selenium/client"
require "Razoo_Test_Cases_FireFox.rb"



class RazooTestSuite < Test::Unit::TestCase

	#This method helps to invoke the Razoo Site
	def test_00_setup_razoo()
		
		invokeRedmineSite()	
		
	end
	
	#~ def test_01()
		#~ login("ebi", "123456")
		#~ getOpenStatusCount("/projects/razoo-issue-tracker/issues?query_id=151")
		#~ getPendingStatusCount("/projects/razoo-issue-tracker/issues?query_id=152")
		#~ getCompleteStatusCount("/projects/razoo-issue-tracker/issues?query_id=153")
		#~ stopBrowser()
	#~ end
	#--------------------- Normal User1 emailId increment - Start------------------------------------#
	#~ $normal1_emailId = workSheet.Cells($normalUser1, "E").value
	#~ puts "normal1_emailId in Excel before increment is : #{$normal1_emailId}"
	#~ $normal1_emailId_str = $normal1_emailId.to_s() 
	#~ $normal1_emailId_firstpart = $normal1_emailId_str.split("FF")
	#~ puts"normal1_emailId in Excel 1st part is :#{$normal1_emailId_firstpart[1]}"
	#~ $normal1_emailId_secpart = $normal1_emailId_firstpart[1].split(".")
	#~ puts"normal1_emailId in Excel 2nd part is :#{$normal1_emailId_secpart[0]}"
	#~ $normal1_emailId = $normal1_emailId_secpart[0].to_i()+1
	#~ puts "normal1_emailId in Excel after increment is : #{$normal1_emailId}"
	#~ workSheet.Cells($normalUser1, "E").value = $normal1_emailId
	#--------------------- Normal User1 emailId increment - End------------------------------------#
end
    
