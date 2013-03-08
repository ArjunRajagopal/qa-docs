'Creating Browser
'********************
		'Set WebBrowserDesc=Description.Create
		'WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
		'WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"		

'Creating Page
'******************
		'Set WebPageDesc=Description.Create
		'WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
     	'WebPageDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"		

'QARC Click Learn More_Donate Any where Screen
'===========================================
'							Browser("name:=Donate Anywhere - Razoo").WinStatusBar("msctls_statusbar32").DblClick 100,11 @@ hightlight id_;_68230_;_script infofile_;_ZIP::ssf9.xml_;_
'							
'							call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
'							
'							Public Function fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc) @@ hightlight id_;_919326_;_script infofile_;_ZIP::ssf3.xml_;_
'							
'								If Browser("name:=Donate Anywhere - Razoo").Window("regexpwndtitle:=Windows Internet Explorer","regexpwndclass:=Internet Explorer_TridentDlgFrame").Exist(2) Then
'										If Browser("name:=Donate Anywhere - Razoo").Window("regexpwndtitle:=Windows Internet Explorer","regexpwndclass:=Internet Explorer_TridentDlgFrame").Page("title:=Windows Internet Explorer").WebButton("html tag:=BUTTON", "html id:=btnDetails").Exist Then
'												Browser("name:=Donate Anywhere - Razoo").Window("regexpwndtitle:=Windows Internet Explorer","regexpwndclass:=Internet Explorer_TridentDlgFrame").Page("title:=Windows Internet Explorer").WebButton("html tag:=BUTTON", "html id:=btnDetails").Click
'										End If
'										strActual=Browser("name:=Donate Anywhere - Razoo").Window("regexpwndtitle:=Windows Internet Explorer","regexpwndclass:=Internet Explorer_TridentDlgFrame").Page("title:=Windows Internet Explorer").WebElement("innertext:=Line.*","html tag:=DIV").GetROProperty("innertext")
'										msgbox strActual
'										Datatable.Value("Line_Number_of_JS_issue","Global")=strActual
'										Browser("name:=Donate Anywhere - Razoo").Window("regexpwndtitle:=Windows Internet Explorer","regexpwndclass:=Internet Explorer_TridentDlgFrame").Page("title:=Windows Internet Explorer").WebButton("html tag:=BUTTON", "html id:= btnOK").Click
'								End If
'							
'							End Function
 @@ hightlight id_;_919326_;_script infofile_;_ZIP::ssf4.xml_;_
'QARC Click Learn More_Donate Any where Screen Ended
'=================================================

'Detect_CloseJavaScriptError
'=========================
	 @@ hightlight id_;_68230_;_script infofile_;_ZIP::ssf9.xml_;_
						    Public Function fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
							
								If Browser("An inspiring place to").Window("regexpwndtitle:=Windows Internet Explorer","regexpwndclass:=Internet Explorer_TridentDlgFrame").Exist(2) Then
										If Browser("An inspiring place to").Window("regexpwndtitle:=Windows Internet Explorer","regexpwndclass:=Internet Explorer_TridentDlgFrame").Page("An inspiring place to").WebButton("html tag:=BUTTON", "html id:=btnDetails").Exist Then
												Browser("An inspiring place to").Window("regexpwndtitle:=Windows Internet Explorer","regexpwndclass:=Internet Explorer_TridentDlgFrame").Page("An inspiring place to").WebButton("html tag:=BUTTON", "html id:=btnDetails").Click
										End If
										strActual=Browser("An inspiring place to").Window("regexpwndtitle:=Windows Internet Explorer","regexpwndclass:=Internet Explorer_TridentDlgFrame").Page("An inspiring place to").WebElement("innertext:=Line.*","html tag:=DIV").GetROProperty("innertext")
										msgbox strActual
										Datatable.Value("Line_Number_of_JS_issue","Global")=strActual
										Browser("An inspiring place to").Window("regexpwndtitle:=Windows Internet Explorer","regexpwndclass:=Internet Explorer_TridentDlgFrame").Page("An inspiring place to").WebButton("html tag:=BUTTON", "html id:= btnOK").Click
								End If
						
							End Function

'Home Page Screen
'==================
'Browser("Action Controller: Exception").Navigate "http://www-qa.razoo.com/"
Browser("name:=An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
Browser("An inspiring place to").Page("An inspiring place to").Link("Sign up").Click 
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("user[first_name]").Set "Hp" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 2").WebEdit("user[first name]")_;_script infofile_;_ZIP::ssf32.xml_;_
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("user[last_name]").Set "Razoo" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 2").WebEdit("user[last name]")_;_script infofile_;_ZIP::ssf33.xml_;_
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("user[email]").Set "HpRazoo1@sra.com" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 2").WebEdit("user[email]")_;_script infofile_;_ZIP::ssf34.xml_;_
Browser("An inspiring place to").Page("An inspiring place to").WebCheckBox("user[terms_of_use]").Set "ON" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 2").WebCheckBox("user[terms of use]")_;_script infofile_;_ZIP::ssf35.xml_;_
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("user[password]").SetSecure "4d39500247e1c78f77baa294e7edeaa36c4a" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 2").WebEdit("user[password]")_;_script infofile_;_ZIP::ssf36.xml_;_
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("user[password_confirmation]").SetSecure "4d395005e7a35e3aba599d613c99e159ce4b" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 2").WebEdit("user[password confirmation]")_;_script infofile_;_ZIP::ssf37.xml_;_
Browser("An inspiring place to").Page("An inspiring place to").WebButton("Create Account").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 2").WebButton("Create Account")_;_script infofile_;_ZIP::ssf38.xml_;_

'My Account Screen
Browser("name:=An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
Browser("An inspiring place to").Page("An inspiring place to").Link("My Profile").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 3").Link("My account")_;_script infofile_;_ZIP::ssf39.xml_;_
 @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 4").Link("donate > Find and support")_;_script infofile_;_ZIP::ssf40.xml_;_
'My Profile Screen
Browser("name:=An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
Browser("An inspiring place to").Page("An inspiring place to").Link("My Donations").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 5").Link("My Donations")_;_script infofile_;_ZIP::ssf44.xml_;_

'My Donations Screen
Browser("name:=An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
Browser("An inspiring place to").Page("An inspiring place to").Link("Account Settings").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 6").Link("Account Settings")_;_script infofile_;_ZIP::ssf45.xml_;_

'Account Settings Screen
Browser("name:=An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
Browser("An inspiring place to").Page("An inspiring place to").Link("My Saved Cards").Click @@ script infofile_;_ZIP::ssf48.xml_;_

' Save Cards Screen
Browser("name:=An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
Browser("An inspiring place to").Page("An inspiring place to").Link("donate > Find and support").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 8").Link("donate > Find and support")_;_script infofile_;_ZIP::ssf49.xml_;_

'Search Screen
Browser("name:=An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("kw").Set "ORG FOR HP15" @@ hightlight id_;_Browser("An inspiring place to").Page("Learn about nonprofits").WebEdit("kw")_;_script infofile_;_ZIP::ssf50.xml_;_
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("kw").Submit @@ hightlight id_;_Browser("An inspiring place to").Page("Learn about nonprofits").WebEdit("kw")_;_script infofile_;_ZIP::ssf51.xml_;_
Browser("An inspiring place to").Page("An inspiring place to").Link("ORG FOR HP15").Click @@ hightlight id_;_Browser("An inspiring place to").Page("Learn about nonprofits 2").Link("ORG FOR HP15")_;_script infofile_;_ZIP::ssf52.xml_;_

'Story Page Screen
Browser("name:=An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
Browser("An inspiring place to").Page("An inspiring place to").WebButton("Donate").Click @@ hightlight id_;_Browser("An inspiring place to").Page("ORG FOR HP15 - Razoo").WebButton("Donate")_;_script infofile_;_ZIP::ssf54.xml_;_
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("donation[amount]").Set "30" @@ hightlight id_;_Browser("An inspiring place to").Page("ORG FOR HP15 - Razoo").WebEdit("donation[amount]")_;_script infofile_;_ZIP::ssf53.xml_;_

'Donation Transaction Screen
Browser("name:=An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("donation[amount]").FireEvent "onchange" @@ hightlight id_;_Browser("An inspiring place to").Page("ORG FOR HP15 - Razoo").WebEdit("donation[amount]")_;_script infofile_;_ZIP::ssf55.xml_;_
Browser("An inspiring place to").Page("An inspiring place to").WebRadioGroup("tip_amount").Select "3.00" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 9").WebRadioGroup("tip amount")_;_script infofile_;_ZIP::ssf56.xml_;_
Browser("An inspiring place to").Page("An inspiring place to_9").WebEdit("order_user_order[credit_card_a_2").Set "Hp Razoo" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 9").WebEdit("order user order[credit card a 2")_;_script infofile_;_ZIP::ssf61.xml_;_
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("order_user_order[credit_card_a").Set "Wood RidgeDrive" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 9").WebEdit("order user order[credit card a")_;_script infofile_;_ZIP::ssf59.xml_;_
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("order_user_order[credit_card_a_3").Set "Washington DC" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 9").WebEdit("order user order[credit card a 3")_;_script infofile_;_ZIP::ssf62.xml_;_
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("order_user_order[credit_card_a_4").Set "Washington " @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 9").WebEdit("order user order[credit card a 4")_;_script infofile_;_ZIP::ssf63.xml_;_
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("order_user_order[credit_card_a_5").Set "20001" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 9").WebEdit("order user order[credit card a 5")_;_script infofile_;_ZIP::ssf64.xml_;_
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("order_user_order[credit_card_a_6").Set "5555555555554444" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 9").WebEdit("order user order[credit card a 6")_;_script infofile_;_ZIP::ssf65.xml_;_
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("order_user_order[credit_card_a_7").Set "123" @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 9").WebEdit("order user order[credit card a 7")_;_script infofile_;_ZIP::ssf66.xml_;_
Browser("An inspiring place to").Page("An inspiring place to").WebButton("Donate Now").Click @@ hightlight id_;_Browser("An inspiring place to").Page("An inspiring place to 9").WebButton("Donate Now")_;_script infofile_;_ZIP::ssf67.xml_;_

'Thank You Screen
'=================
Browser("name:=An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
Browser("An inspiring place to").Page("An inspiring place to").Link("continue without commenting").Click

'Share Page1
'============
Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 38,8
call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
Browser("An inspiring place to").Page("An inspiring place to").Link("Skip this step").Click

'Recommendation page
'====================
Browser("name:=An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
Browser("An inspiring place to").Page("An inspiring place to").Link("Go back to ORG FOR HP15").Click
		
'Story page
'==========

Browser("name:=An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
Browser("An inspiring place to").Page("An inspiring place to").Link("fundraise > Start raising").Click

'CMSPage
'=========
Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
Browser("An inspiring place to").Page("An inspiring place tor").Link("Start a fundraiser").Click

'Fundraiser Page Creation 
'======================

Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("org_picker_kw").Set "Org"
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("org_picker_kw").Set "ORG FOR HP15"
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("story[title]").Set "Fr page"
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("story[blurb]").Set "Fr page"
Browser("An inspiring place to").Page("An inspiring place to").WebFile("story[story_image]").Set "C:\fakepath\Chrysanthemum.jpg"
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("story[goal]").Set "200"
Browser("An inspiring place to").Page("An inspiring place to").Link("28").Click
Browser("An inspiring place to").Page("An inspiring place to").WebButton("Create Fundraising Page").Click
Browser("An inspiring place to").Page("An inspiring place to").WebEdit("org_picker_kw").Submit

'Share Page2
'============
Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
Browser("An inspiring place to").Page("An inspiring place to").Link("see my fundraiser").Click

'Story page
'==========
Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
Browser("An inspiring place to").Page("An inspiring place to").Link("Edit Page").Click

'Edit Page
'=========
Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)
Browser("An inspiring place to").Page("An inspiring place to").WebButton("Update Information").Click
Browser("An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
call fnDetect_CloseJavaScriptError(WebBrowserDesc,WebPageDesc)













'Screen
Browser("name:=An inspiring place to").WinStatusBar("msctls_statusbar32").DblClick 100,11
