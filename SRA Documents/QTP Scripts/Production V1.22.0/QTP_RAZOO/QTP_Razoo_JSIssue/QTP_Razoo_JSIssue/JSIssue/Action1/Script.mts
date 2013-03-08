RepositoriesCollection.Add ("D:\QTP_RAZOO\ObjRepJsIssue1.tsr")

'DataTable.GlobalSheet.AddParameter "Signup_User_Email"

'Detect_CloseJavaScriptError
'=========================

Public Function fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
			
							'If Browser("An inspiring place to").Window("regexpwndtitle:=Windows Internet Explorer","regexpwndclass:=Internet Explorer_TridentDlgFrame").Exist(2) Then
'                                                If Browser("An inspiring place to").Window("regexpwndtitle:=Windows Internet Explorer","regexpwndclass:=Internet Explorer_TridentDlgFrame").Page("An inspiring place to").WebButton("html tag:=BUTTON", "html id:=btnDetails").Exist Then
'                                                        Browser("An inspiring place to").Window("regexpwndtitle:=Windows Internet Explorer","regexpwndclass:=Internet Explorer_TridentDlgFrame").Page("An inspiring place to").WebButton("html tag:=BUTTON", "html id:=btnDetails").Click
'                                               End If
'                                               If Browser("An inspiring place to").Window("regexpwndtitle:=Windows Internet Explorer","regexpwndclass:=Internet Explorer_TridentDlgFrame").Page("An inspiring place to").WebButton("Show details").Exist Then
'                                                      Browser("An inspiring place to").Window("regexpwndtitle:=Windows Internet Explorer","regexpwndclass:=Internet Explorer_TridentDlgFrame").Page("An inspiring place to").WebButton(" Show details").Click
'                                               End If
											'Datatable.Value("Line_Number_of_JS_issue","Global")=strActual
											'Browser("An inspiring place to").Window("Windows Internet Explorer").Page("Windows Internet Explorer").WebButton("html tag:=BUTTON", "html id:= btnOK").Click
											'wait(5)
			   If Browser("An inspiring place to").Window("Windows Internet Explorer").Exist(2) Then
						If Browser("An inspiring place to").Window("Windows Internet Explorer").Page("Windows Internet Explorer").WebButton("Show details").Exist(2) Then
														Browser("An inspiring place to").Window("Windows Internet Explorer").Page("Windows Internet Explorer").WebButton("Show details").Click
						End If
						strActual=Browser("An inspiring place to").Window("Windows Internet Explorer").Page("Windows Internet Explorer").WebElement("innertext:=Line.*","html tag:=DIV").GetROProperty("innertext")
						msgbox strActual
						Datatable.Value("Line_Number_of_JS_issue","Global")=strActual
						Browser("An inspiring place to").Window("Windows Internet Explorer").Page("Windows Internet Explorer").WebButton("Close").Click
			   End If

End Function

'Home Page Screen
'==================
Browser("Action Controller: Exception").Navigate "http://www-qa.razoo.com/"
Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
Browser("An inspiring place to").Page("An inspiring place to").Link("Sign up").Click 
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("user[first_name]").Set "Hp"
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("user[last_name]").Set "Razoo" 
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("user[email]").Set "HpRazoo3@sra.com"
Browser("An inspiring place to").Page("An inspiring place to").WebCheckBox("user[terms_of_use]").Set "ON" 
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("user[password]").SetSecure "4d39500247e1c78f77baa294e7edeaa36c4a"
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("user[password_confirmation]").SetSecure "4d395005e7a35e3aba599d613c99e159ce4b" 
Browser("An inspiring place to").Page("An inspiring place to").WebButton("Create Account").Click

''My Account Screen
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").Link("My Profile").Click 
''Browser("An inspiring place to").Page("An inspiring place to").Link("donate > Find and support").Click
'My Profile Screen
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").Link("My Donations").Click 

'My Donations Screen
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").Link("Account Settings").Click
'
''Account Settings Screen
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'
'Browser("An inspiring place to").Page("An inspiring place to").Link("My Saved Cards").Click 


'' Save Cards Screen
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)

'Browser("An inspiring place to").Page("An inspiring place to").Link("donate > Find and support").Click
'
'
''Search Screen
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("kw").Set "ORG FOR HP15"
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("kw").Submit
'Browser("An inspiring place to").Page("An inspiring place to").Link("ORG FOR HP15").Click
'
''Story Page Screen
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("donation[amount]").Set "30"
'Browser("An inspiring place to").Page("An inspiring place to").WebButton("Donate").Click

'Donation Transaction Screen

'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("donation[amount]").Set "30.00"
'Browser("An inspiring place to").Page("An inspiring place to").WebRadioGroup("tip_amount").Select "3.00" 
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("order_user_order[credit_card_a_2").Set "Hp Razoo"
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("order_user_order[credit_card_a").Set "Wood RidgeDrive" 
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("order_user_order[credit_card_a_3").Set "Washington DC"
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("order_user_order[credit_card_a_4").Set "Washington "
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("order_user_order[credit_card_a_5").Set "20001"
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("order_user_order[credit_card_a_6").Set "5555555555554444"
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("order_user_order[credit_card_a_7").Set "123" 
'Browser("An inspiring place to").Page("An inspiring place to").WebButton("Donate Now").Click
'
''Thank You Screen
''=================
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").Link("continue without commenting").Click
'
''Share Page1
''============
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 38,8
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").Link("Skip this step").Click
'
''Recommendation page
''====================
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").Link("Go back to ORG FOR HP15").Click
'                               
''Story pages
''==========
'
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").Link("fundraise > Start raising").Click

'==================
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").Link("Start a fundraiser").Click
'wait(10)

'Fundraiser Page Creation 
'======================

'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("org_picker_kw").Set "Org"
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("org_picker_kw").Set "ORG FOR HP15"
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("story[title]").Set "Fr page"
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("story[blurb]").Set "Fr page"
'Browser("An inspiring place to").Page("An inspiring place to").WebElement("HTML").Click
'Browser("HTML Source Editor").Page("HTML Source Editor").WebEdit("htmlSource").Set "Story for FR Page"
'Browser("HTML Source Editor").Page("HTML Source Editor").WebButton("Update").Click
'Browser("An inspiring place to").Page("An inspiring place to").WebFile("story[story_image]").Set "C:\Documents and Settings\All Users\Documents\My Pictures\Sample Pictures\Chrysanthemum.jpg"
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("story[designation]").Set "Health"
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("level_amount[0]").Set "10"
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("level_description[0]").Set "Food"
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("story[goal]").Set "200"
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("story[end_date]").Set "April 28, 2011"
'Browser("An inspiring place to").Page("An inspiring place to").WebButton("Create Fundraising Page").Click
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("org_picker_kw").Submit
'
''Promote Page
''============
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").Link("see my fundraiser").Click
'
''Story page
''==========
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").Link("Edit Page").Click

'Edit Page
'=========
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").WebButton("Update Information").Click

'My Saved Cards
'==============
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("Fr page - Razoo").Link("My account").Click @@ hightlight id_;_Browser("An inspiring place to").Page("Fr page - Razoo").Link("My account")_;_script infofile_;_ZIP::ssf69.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to_11").Link("My Saved Cards").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 11").Link("My Saved Cards")_;_script infofile_;_ZIP::ssf70.xml_;_
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to_11").Link("My Profile").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 11").Link("My Profile")_;_script infofile_;_ZIP::ssf72.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to_11").Link("Fr page").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 11").Link("Fr page")_;_script infofile_;_ZIP::ssf73.xml_;_
'
'ThumbNail
'==========
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("Fr page - Razoo").Link("Thumbnail").Click
'
'Matching Grants
'===============
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").Link("Matching Grants").Click

'promote page
'============
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").Link("Promote").Click
'
''Donate Any where Page
''=====================
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").Link("DonateAnywhere").Click
'
''Donation report Page
''===================
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").Link("Donations").Click
'
''Log out
''=======
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").Link("Log out").Click

''Login Page
''==========
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").Link("Log in").Click
'Browser("An inspiring place to").Page("An inspiring place to_13").WebEdit("user_session[email]").Set "brian@razoo.com" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 13").WebEdit("user session[email]")_;_script infofile_;_ZIP::ssf78.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to_13").WebEdit("user_session[password]").SetSecure "4d3d4053e45d51781c4373b151e5953c7e00" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 13").WebEdit("user session[password]")_;_script infofile_;_ZIP::ssf79.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to_13").WebButton("Log in").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 13").WebButton("Log in")_;_script infofile_;_ZIP::ssf80.xml_;_
'Browser("An inspiring place to").Dialog("AutoComplete Passwords").WinButton("Yes").Click

'Login Page
'==========
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Navigate("http://www-qa.razoo.com/admin")
'
''Admin Page
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").Link("Homepage Marquees").Click
'
''Marquees page
''=============
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").Link("New Marquee").Click
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").Link("Cancel").Click
'Browser("An inspiring place to").Navigate "http://www-qa.razoo.com/admin"
'
''search for a user page
''===================
'Browser("An inspiring place to").Page("An inspiring place to").Link("Search for a user").Click
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Navigate "http://www-qa.razoo.com/admin"
'
''Manage Org Admin
''===============
'Browser("An inspiring place to").Page("An inspiring place to").Link("Manage Org Admins").Click
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("email").Set "HPRazoo3@sra.com"
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("ein").Set "123456789"
'Browser("An inspiring place to").Page("An inspiring place to").WebButton("Create Admin").Click
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)

'Manage orders page(refunds)
'Browser("An inspiring place to").Page("An inspiring place to").Link("Manage Orders").Click
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("number").Set "14" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 14").WebEdit("number")_;_script infofile_;_ZIP::ssf81.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to").WebButton("Find Order").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 14").WebButton("Find Order")_;_script infofile_;_ZIP::ssf82.xml_;_
'
''Disbursement  page
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").Link("Resend Receipt").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 15").Link("Resend Receipt")_;_script infofile_;_ZIP::ssf83.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to").WebButton("Send Receipt").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 15").WebButton("Send Receipt")_;_script infofile_;_ZIP::ssf84.xml_;_
''Browser("An inspiring place to").Page("An inspiring place to").Link("Refund Order").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 16").Link("Refund Order")_;_script infofile_;_ZIP::ssf85.xml_;_
''Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Navigate "http://www-qa.razoo.com/admin"

'Manage Disbursements
'====================
'Browser("An inspiring place to").Page("An inspiring place to").Link("Manage Disbursements").Click
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)

'New Disbursements Page
'Browser("An inspiring place to").Page("An inspiring place to").Link("New Disbursements for").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 21").Link("New Disbursements for")_;_script infofile_;_ZIP::ssf118.xml_;_
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").Link("Go Back").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 23").Link("Go Back")_;_script infofile_;_ZIP::ssf102.xml_;_
'Browser("An inspiring place to").Navigate "http://www-qa.razoo.com/admin/disbursements"

'Disbursement Adjustment Type
'Browser("An inspiring place to").Page("An inspiring place to").Link("Manage Disbursement Adjustment").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 21").Link("Manage Disbursement Adjustment")_;_script infofile_;_ZIP::ssf108.xml_;_
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'
''Disbursement Adjustments type Add Page
'Browser("An inspiring place to").Page("An inspiring place to").Link("+ Add a new type").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 24").Link("+ Add a new type")_;_script infofile_;_ZIP::ssf115.xml_;_
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").Link("Cancel").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 25").Link("Cancel")_;_script infofile_;_ZIP::ssf116.xml_;_
'Browser("An inspiring place to").Navigate "http://www-qa.razoo.com/admin/disbursements" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 24").Link("<< Back to Admin Page")_;_script infofile_;_ZIP::ssf117.xml_;_

''Export Disbursements page
''========================
'Browser("An inspiring place to").Page("An inspiring place to").Link("Export Disbursements").Click
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Navigate "http://www-qa.razoo.com/admin"

'Reports @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to_37")_;_script infofile_;_ZIP::ssf158.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to").Link("Reports").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 26").Link("Reports")_;_script infofile_;_ZIP::ssf159.xml_;_
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").WebList("report_type").Select "Audits Report" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 38").WebList("report type")_;_script infofile_;_ZIP::ssf160.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to").WebButton("Run Report").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 38").WebButton("Run Report")_;_script infofile_;_ZIP::ssf161.xml_;_
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").Link("<< Back to Admin Page").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 38").Link("<< Back to Admin Page")_;_script infofile_;_ZIP::ssf435.xml_;_
'
''IRS Master Import 
'Browser("An inspiring place to").Page("An inspiring place to").Link("Irs Master Import").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 26").Link("Irs Master Import")_;_script infofile_;_ZIP::ssf436.xml_;_
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Navigate "http://www-qa.razoo.com/admin"
'
''Content Management System
'Browser("An inspiring place to").Page("An inspiring place to").Link("Content Management System").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 26").Link("Content Management System")_;_script infofile_;_ZIP::ssf441.xml_;_
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Navigate "http://www-qa.razoo.com/admin"

'Create New ORG
'===============
'Browser("An inspiring place to").Page("An inspiring place to").Link("Create New Org").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 26").Link("Create New Org")_;_script infofile_;_ZIP::ssf127.xml_;_
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("org[ein]").Set "123451235"
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("org[name]").Set "ORG FOR JS1" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 28").WebEdit("org[name]")_;_script infofile_;_ZIP::ssf120.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("org[city]").Set "Washington DC" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 28").WebEdit("org[city]")_;_script infofile_;_ZIP::ssf122.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to").WebList("org[state]").Select "Washington" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 28").WebList("org[state]")_;_script infofile_;_ZIP::ssf123.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to").WebButton("Create").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 28").WebButton("Create")_;_script infofile_;_ZIP::ssf124.xml_;_

''NPODetails Page
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)

''Data Sources Page
'Browser("An inspiring place to").Page("An inspiring place to").Link("Data Sources").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 30").Link("Data Sources")_;_script infofile_;_ZIP::ssf128.xml_;_
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'
''Audits Page
'Browser("An inspiring place to").Page("An inspiring place to").Link("Audits").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 31").Link("Audits")_;_script infofile_;_ZIP::ssf129.xml_;_
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Navigate "http://www-qa.razoo.com/admin"
'
''Verify Audits Page
'Browser("An inspiring place to").Page("An inspiring place to").Link("Verify").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 32").Link("Verify")_;_script infofile_;_ZIP::ssf130.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("audit[details]").Set "Test" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 33").WebEdit("audit[details]")_;_script infofile_;_ZIP::ssf133.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to").WebButton("Create").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 33").WebButton("Create")_;_script infofile_;_ZIP::ssf134.xml_;_
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Navigate "http://www-qa.razoo.com/admin"

''Authorise.net Log
'Browser("An inspiring place to").Page("An inspiring place to").Link("Verify Authorize.net log").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 26").Link("Verify Authorize.net log")_;_script infofile_;_ZIP::ssf442.xml_;_
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Navigate "http://www-qa.razoo.com/admin"

''Assign Guest Orders to
'Browser("An inspiring place to").Page("An inspiring place to").Link("Assign Guest Orders to").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 26").Link("Assign Guest Orders to")_;_script infofile_;_ZIP::ssf444.xml_;_
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Navigate "http://www-qa.razoo.com/admin"
'
''See Order Black List Rules
'Browser("An inspiring place to").Page("An inspiring place to").Link("See Order Blacklist Rules").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 26").Link("See Order Blacklist Rules")_;_script infofile_;_ZIP::ssf447.xml_;_
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Navigate "http://www-qa.razoo.com/admin"
'
''View Bingo Dash Board
'Browser("An inspiring place to").Page("An inspiring place to").Link("View Abingo Dashboard").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 26").Link("View Abingo Dashboard")_;_script infofile_;_ZIP::ssf448.xml_;_
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)

' Champaign Creation Page
'Browser("An inspiring place to").Navigate "https://www-qa.razoo.com/team/new"
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("org_picker_kw").Set "Alliance Community Fund" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 42").WebEdit("org picker kw")_;_script infofile_;_ZIP::ssf464.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("campaign[title]").Set "Champ Alli" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 42").WebEdit("campaign[title]")_;_script infofile_;_ZIP::ssf449.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("campaign[intro]").Set "Champ Alli  a team fundraiser to help the Alliance Community Fund" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 42").WebEdit("campaign[intro]")_;_script infofile_;_ZIP::ssf450.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to").WebElement("HTML").Click
'Browser("HTML Source Editor").Page("HTML Source Editor").WebEdit("htmlSource").Set "Story for FR Page"
'Browser("HTML Source Editor").Page("HTML Source Editor").WebButton("Update").Click
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("campaign[goal_amount]").Set "1000" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 42").WebEdit("campaign[goal amount]")_;_script infofile_;_ZIP::ssf451.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("campaign[start_at]").Set "Jan 25, 2011"
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("campaign[end_at]").Set "April 28, 2011"
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("campaign[designation]").Set "Renovation" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 42").WebEdit("campaign[designation]")_;_script infofile_;_ZIP::ssf458.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to").WebFile("campaign[logo_image]").Set "C:\Documents and Settings\All Users\Documents\My Pictures\Sample Pictures\Helianthus_divaricatus_flowers.jpg" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 42").WebFile("campaign[logo image]")_;_script infofile_;_ZIP::ssf459.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("campaign[cached_urn]").Set "champ-alli" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 42").WebEdit("campaign[cached urn]")_;_script infofile_;_ZIP::ssf460.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to").WebButton("Create Campaign").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 42").WebButton("Create Campaign")_;_script infofile_;_ZIP::ssf461.xml_;_
'
'Champaign Story Page
'Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
'call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'Browser("An inspiring place to").Page("An inspiring place to").Link("Create a Page").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 43").Link("Create a Page")_;_script infofile_;_ZIP::ssf462.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("story[title]").Set "FR Alliance Champ Page2" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 44").WebEdit("story[title]")_;_script infofile_;_ZIP::ssf463.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("story[blurb]").Set "Summary for FR Alliance Champ Page1" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 34").WebEdit("story[blurb]")_;_script infofile_;_ZIP::ssf141.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to").WebElement("HTML").Click
'Browser("HTML Source Editor").Page("HTML Source Editor").WebEdit("htmlSource").Set "Story for FR Page"
'Browser("HTML Source Editor").Page("HTML Source Editor").WebButton("Update").Click
'Browser("An inspiring place to").Page("An inspiring place to").WebFile("story[story_image]").Set "C:\Documents and Settings\All Users\Documents\My Pictures\Sample Pictures\Chrysanthemum.jpg" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 34").WebFile("story[story image]")_;_script infofile_;_ZIP::ssf142.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("story[designation]").Set "Renovation" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 34").WebEdit("story[designation]")_;_script infofile_;_ZIP::ssf146.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("level_amount[0]").Set "10" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 34").WebEdit("level amount[0]")_;_script infofile_;_ZIP::ssf144.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("level_description[0]").Set "Bricks" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 34").WebEdit("level description[0]")_;_script infofile_;_ZIP::ssf147.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("story[goal]").Set "1000" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 34").WebEdit("story[goal]")_;_script infofile_;_ZIP::ssf148.xml_;_
'' - different user
''Browser("An inspiring place to").Page("An inspiring place to").WebEdit("campaign_urn").Set "FrAll" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 34").WebEdit("campaign urn")_;_script infofile_;_ZIP::ssf151.xml_;_
'Browser("An inspiring place to").Page("An inspiring place to").WebButton("Create Project").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 34").WebButton("Create Fundraising Page")_;_script infofile_;_ZIP::ssf152.xml_;_

' SharePage for Champaign
Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
Browser("An inspiring place to").Page("An inspiring place to").Link("see my project").Click

'Champaign Story Page 
Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
Browser("An inspiring place to").Page("FR Alliance Champ Page1").Link("Edit Page").Click @@ hightlight id_;_Browser("An inspiring place to").Page("FR Alliance Champ Page1").Link("Edit Page")_;_script infofile_;_ZIP::ssf154.xml_;_

'Champaign Edit Page
Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
''- different user @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 36").WebEdit("campaign urn")_;_script infofile_;_ZIP::ssf155.xml_;_
''Browser("An inspiring place to").Page("An inspiring place to").WebEdit("campaign_urn").Set "FrAll"  
Browser("An inspiring place to").Page("An inspiring place to").WebButton("Update Information").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 36").WebButton("Update Information")_;_script infofile_;_ZIP::ssf156.xml_;_
 @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 36").WebEdit("campaign urn")_;_script infofile_;_ZIP::ssf157.xml_;_













