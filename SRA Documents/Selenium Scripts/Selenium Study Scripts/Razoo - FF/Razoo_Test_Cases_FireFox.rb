require "test/unit"
require "rubygems"
gem "selenium-client"
require "selenium/client"
require "win32ole"


# Variable declarations
$verification_errors = []

#------------------------------------------------------------------#
# Description:  It is a METHOD for invoking the Razoo Site
#------------------------------------------------------------------#

def invokeRedmineSite()
	
	puts "************** START : Invoke Razoo Application ****************"	
	# Create a new instance of the Selenium-Client driver.
	$browser = Selenium::Client::Driver.new \
		:host => "localhost",
		:port => 4444,
		:browser => "*firefox", 
		:url => "http://sra941",
		:timeout_in_second => 250

	# Start the browser session
	$browser.start_new_browser_session
	# Print a message in the browser-side log and status bar
	$browser.set_context("Razoo Application")
	$browser.open "/ReadCenter-Analytics/"
	    $browser.type "id=txtUserName_I", "admin"
	    $browser.type "id=txtPassword_I", "admin"
	    $browser.click "css=#btnLogin_CD > span"
	    $browser.click "name=btnLogin"
	    $browser.wait_for_page_to_load 
	    $browser.click "id=ctl00_DashboardContentPlaceHolder_kdbsSurface_db_2_Cts_wuc_dtEditFrom_B-1Img"
	    $browser.click "css=#ctl00_DashboardContentPlaceHolder_kdbsSurface_db_2_Cts_wuc_btnView_CD > span"
	    $browser.click "name=ctl00$DashboardContentPlaceHolder$kdbsSurface$db$2_Cts$wuc$btnView"
	    $browser.click "id=ext-gen48"
	    $browser.click "id=ext-gen28"
	    $browser.click "link=Network Analysis"
	    $browser.wait_for_page_to_load 
	    sleep 5
	    begin
		assert $browser.is_element_present("id=ctl00_TailContentPlaceHolder_rndpnlSearch_tabPage_AT1T")
		$browser.click "id=ctl00_TailContentPlaceHolder_rndpnlSearch_tabPage_AT1T"
		puts "inside At1t"
		sleep 25
	    rescue Test::Unit::AssertionFailedError
		puts "inside t0t"
		$browser.click "id=ctl00_TailContentPlaceHolder_rndpnlSearch_tabPage_T0T"
	    end
		sleep 5
	    $browser.click "id=PanZoomBar_zoomin_innerImage"
	    sleep 25
	    $browser.click "id=PanZoomBar_zoomout_innerImage"
	    sleep 25
	    $browser.click "id=OL_Icon_310_innerImage"
	    begin
		assert $browser.is_text_present("96499386")
		puts "pass"
	    rescue Test::Unit::AssertionFailedError
		
	    end
	    $browser.click "id=12176_close"
	    $browser.click "id=ctl00_TailContentPlaceHolder_rndpnlSearch_tabPage_mapNetwork_chkArea_S_D"
	    $browser.click "id=ctl00_TailContentPlaceHolder_rndpnlSearch_tabPage_cpMapCallback_grdGateway_DXFREditorcol4_I"
	    $browser.click "id=ctl00_TailContentPlaceHolder_rndpnlSearch_tabPage_cpMapCallback_grdGateway_DXFREditorcol4_I"
	    $browser.type "id=ctl00_TailContentPlaceHolder_rndpnlSearch_tabPage_cpMapCallback_grdGateway_DXFREditorcol4_I", "12345678"
	    $browser.click "//img[@onclick=\"aspxGVFilterRowMenu('ctl00_TailContentPlaceHolder_rndpnlSearch_tabPage_cpMapCallback_grdGateway',4,this)\"]"
	    $browser.click "id=ctl00_TailContentPlaceHolder_rndpnlSearch_tabPage_cpMapCallback_grdGateway_cell0_1_btnEdit"
	    $browser.click "id=ctl00_TailContentPlaceHolder_popupAssetGridData_cpPopup_ucAssetInformation_cmbState_I"
	    $browser.click "css=#ctl00_TailContentPlaceHolder_popupAssetGridData_cpPopup_ucAssetInformation_btnSave_CD > span"
	    $browser.click "id=ctl00_TailContentPlaceHolder_popupAssetGridData_cpPopup_ucAssetInformation_dtInstallDate_B-1Img"
	    $browser.click "id=ctl00_TailContentPlaceHolder_popupAssetGridData_cpPopup_ucAssetInformation_dtInstallDate_DDD_C_BT"
	    $browser.click "css=#ctl00_TailContentPlaceHolder_popupAssetGridData_cpPopup_ucAssetInformation_btnCancel_CD > span"
	    $browser.click "id=ctl00_lnkSignout"
	    $browser.wait_for_page_to_load "30000"
	puts "************** END : Invoke Razoo Application ****************"
	
end


# ------------------------------------------------------------------------------#
# Description:  This method allows the user to login to Razoo application.
# ------------------------------------------------------------------------------#
def login(email_id, pass_word)
	
	puts "************** START : Login to Redmine ****************"	
	
	$browser.click "link=Sign in"
	$browser.wait_for_page_to_load 
	$browser.type "username", email_id
	$browser.type "password", pass_word
	$browser.click "login"
	$browser.wait_for_page_to_load 

	puts "************** END : Login to Redmine ****************"	
end


def getOpenStatusCount(complete_url)
	
	@qadashboard_excel ="D:\\EBI\\MyProjects\\Razoo\\Automation\\Selenium\\Selenium2\\ModularFramework\\QA Dashboard.xls"

	$excel = WIN32OLE::new("excel.application")
	# Getting the Excelsheet
	$workBook = $excel.Workbooks.Open(@qadashboard_excel)
	# Opening the first worksheet
	workSheetCount = $workBook.worksheets.count
	puts "Total WorkSheet count in  Excel: #{workSheetCount}"
	$workSheet = $workBook.worksheets(1)
	$workSheet.select
	@rowCount = $workSheet.UsedRange.Rows.Count
	puts "Row count is : #{@rowCount}"
	
	$browser.open complete_url
	puts "Inside Open status method"
	
	begin
		assert $browser.is_text_present("No data to display")
		puts "There is not record in this Filter right now. :("
	
	rescue

		for @tableNumberInt in 1..25
			@rowCount = $workSheet.UsedRange.Rows.Count
			puts "Row count is : #{@rowCount}"
			
			@tableNumberFloat = @tableNumberInt.to_f 
			begin
			@tableValue =  $browser.get_table("//div[@id='content']/form[2]/div[2]/table.#{@tableNumberFloat}")
			if @tableValue !=""
				puts "Table value is #{@tableValue}"
				@tableValueStr = @tableValue.to_s() 
				@developerCntFirstPart = @tableValueStr.split(" (")
				@developerCntSecPart = @developerCntFirstPart[1].split(")")
				puts"#{@developerCntFirstPart[0]} count is #{@developerCntSecPart[0]}"
				
				while @developerCntFirstPart[0] !=  $workSheet.Cells(@rowCount, "C").value 
					@excelValue = $workSheet.Cells(@rowCount, "C").value 
					puts "Excel Value is #{@excelValue}"
					@rowCount = @rowCount-1
				end
			$workSheet.Cells(@rowCount, "D").value = @developerCntSecPart[0]
			end
			rescue
			puts "OOOOOOOOpppppssssss....Cannot access row no.#{@tableNumberFloat} - table has less than #{@tableNumberFloat} rows :("
			end
		end
	end
	
end

def getPendingStatusCount(complete_url)
	
	$browser.open complete_url
	puts "Inside Pending Approval status method"
	
	begin
		assert $browser.is_text_present("No data to display")
		puts "There is not record in this Filter right now. :("
	
	rescue
	
		for @tableNumberInt in 1..25
			@rowCount = $workSheet.UsedRange.Rows.Count
			puts "Row count is : #{@rowCount}"
			
			@tableNumberFloat = @tableNumberInt.to_f 
			begin
			@tableValue =  $browser.get_table("//div[@id='content']/form[2]/div[2]/table.#{@tableNumberFloat}")
			if @tableValue !=""
				puts "Table value is #{@tableValue}"
				@tableValueStr = @tableValue.to_s() 
				@developerCntFirstPart = @tableValueStr.split(" (")
				@developerCntSecPart = @developerCntFirstPart[1].split(")")
				puts"#{@developerCntFirstPart[0]} count is #{@developerCntSecPart[0]}"
				
				while @developerCntFirstPart[0] !=  $workSheet.Cells(@rowCount, "C").value 
					@excelValue = $workSheet.Cells(@rowCount, "C").value 
					puts "Excel Value is #{@excelValue}"
					@rowCount = @rowCount-1
				end
			$workSheet.Cells(@rowCount, "E").value = @developerCntSecPart[0]
			end
			rescue
			puts "OOOOOOOOpppppssssss....Cannot access row no.#{@tableNumberFloat} - table has less than #{@tableNumberFloat} rows :("
			end
		end
	end
	#$excel.Workbooks.Close	
end


def getCompleteStatusCount(complete_url)
	
	$browser.open complete_url
	puts "Inside Complete status method"
	
	begin
		assert $browser.is_text_present("No data to display")
		puts "There is not record in this Filter right now. :("
	
	rescue
	
		for @tableNumberInt in 1..25
			@rowCount = $workSheet.UsedRange.Rows.Count
			puts "Row count is : #{@rowCount}"
			
			@tableNumberFloat = @tableNumberInt.to_f 
			begin
			@tableValue =  $browser.get_table("//div[@id='content']/form[2]/div[2]/table.#{@tableNumberFloat}")
			if @tableValue !=""
				puts "Table value is #{@tableValue}"
				@tableValueStr = @tableValue.to_s() 
				@developerCntFirstPart = @tableValueStr.split(" (")
				@developerCntSecPart = @developerCntFirstPart[1].split(")")
				puts"#{@developerCntFirstPart[0]} count is #{@developerCntSecPart[0]}"
				
				while @developerCntFirstPart[0] !=  $workSheet.Cells(@rowCount, "C").value 
					@excelValue = $workSheet.Cells(@rowCount, "C").value 
					puts "Excel Value is #{@excelValue}"
					@rowCount = @rowCount-1
				end
			$workSheet.Cells(@rowCount, "F").value = @developerCntSecPart[0]
			end
			rescue
			puts "OOOOOOOOpppppssssss....Cannot access row no.#{@tableNumberFloat} - table has less than #{@tableNumberFloat} rows :("
			end
		end
	end
	#Get system time
	@sys_time = Time.now.to_i
	puts "Current System Minute is #{@sys_time}"
	# Save the workbook
	$save_excel ="D:\\EBI\\MyProjects\\Razoo\\Automation\\Selenium\\Selenium2\\ModularFramework\\QA Dashboard_#{@sys_time} .xls"
	$workBook.SaveAs($save_excel)
	# Close the workbook
	$workBook.Close
	# Quit Excel
	$excel.Quit
	
	$excel.visible = true
	$excel.workbooks.open($save_excel)
	
end


# --------------------------------------------------------------------------------------#
# Description:  This method will stop the running browser.
# --------------------------------------------------------------------------------------#
def stopBrowser()
	
	$browser.stop
	
end