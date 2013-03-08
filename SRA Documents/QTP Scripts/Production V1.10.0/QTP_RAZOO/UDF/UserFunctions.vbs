'======================================================App Map- create Run time object*================================================
Option Explicit

'Define Variables
Public WebBrowserDesc,WebPageDesc, WebEditDesc, WebButtonDesc, WebObjDesc,WinEditDesc
Public WebLinkDesc, WebImageDesc, WebCheckBoxDesc, WebListDesc, WebFileDesc,DialogDesc1
Public WebRadioGroupDesc, WebTableDesc, DialogDesc, WinButtonDesc
Public intRefNum, arrWebTab, strObjectProperty

Dim dblGetTotal, dblVerifyTotal, dblGetTotal1, dblVerifyTotal1
Dim strSugAmt, strSugAmt1, strGetDesig
Dim objLink, intLinkCount, strLinkFound, strLinkName, arrSignup,  intDonVal, intDonVal1, intDonAmt
Dim arrObjProperty,strObjProperty,strObjValue,strObjProp,strActual,strResult,intRowNum,intColNum,j,intRowCount
Dim intCountBeforeDonation,  intCountAfterDonation,intTotImages,RowCol,Row,Col,intEditbxCnt,arrParam,aVar,bVar,intButtonCnt
Dim arrWtIndex,objWebTable,l,GetTotAmt,dblGetDisbAmt,dblGetRefAmt, dblGetDisbAdjAmt,dblVerifyTotDonAmt,dblVerifyDisbTot,objWebElement
Dim dblGetPF,dblGetBF, objtotalFans, objtotalLinks,GetTot,GetTotalAmt
Dim arrLogin,arrstrParam_Don,objCheckBox
Dim intFanCount
Dim strResetUrl,strMailBody1,strMailBody2,strMailBody3,strMailSub1,strMailSub2
Dim olapp,inbox,fold,colfolders,objfolder,mail,objsubfolder,objparentfolder,colValue
Dim fso,MyFile,FileData,Check_No,Org_Name,abc,CheckNo
Dim strAmt1,strAmt2,strAmt3
Dim intBig
Dim arrstrParam,MyExcel
Dim TZDate,StrGetTimeZone,dblVerifyTime,strTime1,strTime2,strTime,ampm,strtime3,strtime4
Dim i
Dim ColCount(),n
Dim  intGetFundRaisersCount
Dim strRaised1,intGetRaised,intGetDonorCount,intVerifyRaised,intVerifyDonorCount, intVerifyFundRaisersCount, intVerifyFundRaisers

'======================================================Functions starts here==========================================================

'Creating Web Browser
'***************************

Public function fnAppMap (strBrowser,strObject,strObjectName)	

								Set WebBrowserDesc=Description.Create
								WebBrowserDesc("micClass").value="Browser"
								WebBrowserDesc("application Version").value="internet explorer 8"
								If strBrowser<>"" then 
									WebBrowserDesc("name").value=strBrowser
								end if

'Creating Page
'******************
						Set WebPageDesc=Description.Create
						WebPageDesc("title").value=strBrowser	


'Creating the runtime Object for :
'************************************

							Select Case strObject

											' WebEdit
											'***********

											Case "WebEdit"

															Set WebEditDesc=Description.Create

																	WebEditDesc("micClass").Value="WebEdit"
																	WebEditDesc("html tag").Value="INPUT"
																	arrObjProperty=Split(strObjectName,",")

															 For Each strObjProperty in arrObjProperty
																					strObjValue=Split(strObjProperty,"=")
																					strObjProp=Trim (strObjValue(0))
																					WebEditDesc(strObjProp).Value=Trim (strObjValue(1))
															  Next
									
											' WebButton
											'**************

											Case "WebButton"

															Set WebButtonDesc=Description.Create

																	WebButtonDesc("micClass").Value="WebButton"
																	WebButtonDesc("html tag").Value="INPUT"
																	arrObjProperty=split(strObjectName,",")

															For Each strObjProperty in arrObjProperty
																					strObjValue=Split(strObjProperty,"=")
																					strObjProp=Trim (strObjValue(0))
																					WebButtonDesc(strObjProp).value=trim (strObjValue(1))
															Next
											
											' WebElement
											'****************

											Case "WebElement"

															Set WebObjDesc=Description.Create

																	WebObjDesc("micClass").value="WebElement"
																	arrObjProperty=split(strObjectName,",")

															For each strObjProperty in arrObjProperty
																					strObjValue=split(strObjProperty,"=")
																					strObjProp=trim (strObjValue(0))
																					WebObjDesc(strObjProp).value=trim (strObjValue(1))
															Next 
									
											' WebList
											'***********
											
											Case "WebList"

															Set WebListDesc=Description.Create

																	arrObjProperty=split(strObjectName,",")

															For each strObjProperty in arrObjProperty
																				strObjValue=split(strObjProperty,"=")
																				strObjProp=trim (strObjValue(0))
																				WebListDesc(strObjProp).value=trim (strObjValue(1))
															Next		
											
											' WebLink
											'***********
											
											Case "WebLink"
																Set WebLinkDesc=Description.Create

																	WebLinkDesc("micClass").value="Link"
																	WebLinkDesc("html tag").value="A"
																	arrObjProperty=split(strObjectName,",")

																For each strObjProperty in arrObjProperty
																						strObjValue=split(strObjProperty,"=")
																						strObjProp=trim (strObjValue(0))
																						WebLinkDesc(strObjProp).value=trim (strObjValue(1))
																Next		
									
											' WebFile
											'***********

											Case "WebFile"
																Set WebFileDesc=Description.Create

																	arrObjProperty=split(strObjectName,",")

																For each strObjProperty in arrObjProperty
																						strObjValue=split(strObjProperty,"=")
																						strObjProp=trim (strObjValue(0))
																						WebFileDesc(strObjProp).value=trim (strObjValue(1))
																Next
									
											' WebCheckBox
											'*******************		
													
											Case "WebCheckBox"

														Set WebCheckBoxDesc=Description.Create

																WebCheckBoxDesc("html tag").value="INPUT"
																WebCheckBoxDesc("micClass").value="WebCheckBox"
																arrObjProperty=split(strObjectName,",")

														For each strObjProperty in arrObjProperty
																				strObjValue=split(strObjProperty,"=")
																				strObjProp=trim (strObjValue(0))
																				WebCheckBoxDesc(strObjProp).value=trim (strObjValue(1))
														Next
									
											'WebRadioGroup
											'*********************

											Case "WebRadioGroup"	

															Set WebRadioGroupDesc=Description.Create

																	WebRadioGroupDesc("micclass").value="WebRadioGroup"
																	WebRadioGroupDesc("html tag").value= "INPUT"  
																	arrObjProperty=split(strObjectName,",")

														For each strObjProperty in arrObjProperty
																			 strObjValue=split(strObjProperty,"=")
																			 strObjProp=trim(strObjValue(0))
																			  WebRadioGroupDesc(strObjProp).value=trim(strObjValue(1))	
														Next
									
												' WebImage
												'**************

												Case "WebImage"

															Set WebImageDesc=Description.Create

															arrObjProperty=split(strObjectName,",")

															For each strObjProperty in arrObjProperty
																					strObjValue=split(strObjProperty,"=")
																					strObjProp=trim (strObjValue(0))
																					WebImageDesc(strObjProp).value=trim (strObjValue(1))
															Next 

											Case "WinStatusbar"

												Set WinStatusbarDesc=Description.Create
																	WinStatusbarDesc("micclass").value="WinStatusbar"
																	
																	arrObjProperty=split(strObjectName,",")
																	For each strObjProperty in arrObjProperty
																					strObjValue=split(strObjProperty,"=")
																					strObjProp=trim (strObjValue(0))
																					WinStatusbarDesc(strObjProp).value=trim (strObjValue(1))
																	Next 
									
											' WebTable
											'**************

											 Case "WebTable"

															Set WebTableDesc=Description.Create

															arrObjProperty=split(strObjectName,",")

															For each strObjProperty in arrObjProperty
																					strObjValue=split(strObjProperty,"=")
																					strObjProp=trim (strObjValue(0))
																					WebTableDesc(strObjProp).value=trim (strObjValue(1))
															Next 
									
											' Dialog
											'*********

											Case "Dialog"

															Set DialogDesc=Description.Create

															arrObjProperty=split(strObjectName,",")

															For each strObjProperty in arrObjProperty
																					strObjValue=split(strObjProperty,"=")
																					strObjProp=trim (strObjValue(0))
																					DialogDesc(strObjProp).value=trim (strObjValue(1))
															Next 

												Case "Dialog1"

															Set DialogDesc1=Description.Create

															arrObjProperty=split(strObjectName,",")

															For each strObjProperty in arrObjProperty
																					strObjValue=split(strObjProperty,"=")
																					strObjProp=trim (strObjValue(0))
																					DialogDesc1(strObjProp).value=trim (strObjValue(1))
															Next 

									
											' WinButton
											'*************

											Case "WinButton"

															Set WinButtonDesc=Description.Create

															arrObjProperty=split(strObjectName,",")

															For each strObjProperty in arrObjProperty
																					strObjValue=split(strObjProperty,"=")
																					strObjProp=trim (strObjValue(0))
																					WinButtonDesc(strObjProp).value=trim (strObjValue(1))
															Next 
												'WinEdit
												 '************
															   Set WinEditDesc=Description.Create
																		 WinEditDesc("windowstyle").Value="1409286272"
																		arrObjProperty=split(strObjectName,",")
	
																For each strObjProperty in arrObjProperty
																						strObjValue=split(strObjProperty,"=")
																						strObjProp=trim (strObjValue(0))
																						WinEditDesc(strObjProp).value=trim (strObjValue(1))
																Next 

								
							End Select
End Function

'======================================================END of Function================================================================



'======================================================Event Related to Browser=========================================================

' This function involves all the Browser related actions that shall invoke another function to perform the task.


Public function fnBrowser(WebBrowserDesc,WebPageDesc,strAction,strParam,strExpected,strChkPoint)

				'Switch to the relevant Action
						Select Case strAction
						
							'Invoke IE8.0
                                    Case "Invoke"
													If Browser(WebBrowserDesc).Exist then 
														Browser(WebBrowserDesc).Close
													End if
														' SystemUtil.Run "C:\Program Files\Internet Explorer\IEXPLORE.EXE", strParam
														SystemUtil.Run "C:\Program Files (x86)\Internet Explorer\IEXPLORE.EXE", strParam
														 Call fnBrowserExists(WebBrowserDesc,WebPageDesc,strAction,strParam,strExpected,strChkPoint,"Browser")
							'Check Page loaded
									  Case "CheckPageLoaded"
													Call fnBrowserExists (WebBrowserDesc,WebPageDesc,strAction,strParam,strExpected,strChkPoint,"Browser")
						
							'Enters valid card details
										Case "Donation"
													   Call fnCardDetails(strParam)
						
							'Navigate To
										 Case "Navigate"
                                             		   Browser(WebBrowserDesc).Navigate strParam

							'Navigate Back
										 Case "Back"
													   Browser(WebBrowserDesc).Back
    						
							'Function for Logging into Application from home page
										 Case "Login"
													  Call fnLogin(WebBrowserDesc,WebPageDesc,strAction,strParam,strExpected,strChkPoint)
						
							'Open New Tab in the same Browser
										 Case "OpenNewTab"
														Browser(WebBrowserDesc).OpenNewTab
						
							'Refresh the Browser
										 Case "Refresh"
														Browser(WebBrowserDesc).Refresh
						
							'CLose the Application
										  Case "Close"
														Browser(WebBrowserDesc).Close
						
							'Function for  Signup
										Case "Signup"
													 Call fnSignUp(WebBrowserDesc,WebPageDesc,strAction,strParam,strExpected,strChkPoint)
						
							'Stops QTP from performing actions untill the controls are loaded
										 Case "Sync"
														Browser(WebBrowserDesc).Sync

                             'Navigate the Reset URL path
											Case "NavigateURL"
														  Browser(WebBrowserDesc).Navigate strResetUrl
                                                        
								 
						End Select
End Function

'======================================================END of Function================================================================



'======================================================Event Related to WebEdit========================================================
' This function involves all the EditBox  related actions that shall Set  the values into EditBox  to perform the task.

Public function fnEdit(WebBrowserDesc,WebPageDesc,WebEditDesc,strAction,strParam,strExpected,strChkPoint)
				'Switch the relevant Action	

					Select Case strAction

				'Set the value in the Edit box Field
										Case "Set"
														Browser(WebBrowserDesc).Page(WebPageDesc).WebEdit(WebEditDesc).Set strParam
														strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebEdit(WebEditDesc).GetROProperty("value")
														Call fnVerifyProperty(strParam,strActual,strChkPoint)

				'Click Edit box 
										Case "Click"
														Browser(WebBrowserDesc).Page(WebPageDesc).WebEdit(WebEditDesc).Click

				'Verify value of  Edit box
										Case "VerifyValue"
														strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebEdit(WebEditDesc).GetROProperty(strParam)
														Call fnVerifyProperty(strExpected,strActual,strChkPoint)

				'Verify EditBox Exist
									   Case "VerifyObjectExist"
													 Set strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebEdit(WebEditDesc)
													 Call fnVerifyObjectExist(strExpected,strActual,strChkPoint)

				'Verify particular property 
										Case "VerifyProperty"
													   strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebEdit(WebEditDesc).GetROProperty("default value")
													   Call fnVerifyProperty(strExpected,strActual,strChkPoint)

				'Set the value if more than one EditBox
										 Case "SetEditBox"
														Call fnSetWebEditBox (WebBrowserDesc,WebPageDesc,WebEditDesc,strAction,strParam,strExpected,strChkPoint)

				'To	  Setting the value in the Refund Order
										  Case "SetValue"
														Call fnSettingValue(WebBrowserDesc,WebPageDesc,WebEditDesc,strAction,strParam,strExpected,strChkPoint)
								
				'Getting the Processing Fee in Admin page
										   Case "GetProcessingFee"
														   dblGetPF=Browser(WebBrowserDesc).Page(WebPageDesc).WebEdit(WebEditDesc).GetROProperty(strParam)
														   DataTable.Value("Expected","SubDriver [SubDriver]")=dblGetPF
				
				'Getting the Brand Fee in Admin page
										   Case "GetBrandFee"
															dblGetBF=Browser(WebBrowserDesc).Page(WebPageDesc).WebEdit(WebEditDesc).GetROProperty(strParam)
															DataTable.Value("Expected","SubDriver [SubDriver]")=dblGetBF

                'Set the value in the HTML Editor
											Case "SetAndUpdate"

											Set WebBrowserDesc=Description.Create
													 WebBrowserDesc("name").value="HTML Source Editor"

											Set WebPageDesc=Description.Create
													WebPageDesc("title").value="HTML Source Editor"

											 Set WebEditDesc=Description.Create
													 WebEditDesc("micClass").value="WebEdit"
													 WebEditDesc("class").value="mceFocus"
													 WebEditDesc("html tag").value="TEXTAREA"
													 WebEditDesc("kind").Value="multiline"

											 Set WebButtonDesc=Description.Create
													 WebButtonDesc("name").value="WebButton"
													 WebButtonDesc("name").value="Update"
													Browser(WebBrowserDesc).Page(WebPageDesc).WebEdit(WebEditDesc).Set strParam
													Browser(WebBrowserDesc).Page(WebPageDesc).WebButton(WebButtonDesc).Click



										 Case "GetDonateAmt"
														intDonAmt =Trim(Browser(WebBrowserDesc).Page(WebPageDesc).WebEdit(WebEditDesc).GetROProperty(strParam))
														DataTable.Value("Actual","SubDriver [SubDriver]")=intDonAmt
														

						End Select
End Function

'======================================================END of Function================================================================


'======================================================Events Related to Dialog==========================================================

' This function involves Dialog(Browse the image) related actions that shall Verify  the Dialog Opened
Public Function fnDialog(WebBrowserDesc,DialogDesc,strAction,strParam,strExpected,strChkPoint)
					   Select Case strAction
										  Case"VerifyDialog"
														If Browser(WebBrowserDesc).Dialog(DialogDesc).exist(10)Then
																	strResult="Pass"
														else
																	strResult="Fail"
														End If
														DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult     

							Case "VerifyParent"
								                    If Dialog(DialogDesc).Exist then
														msgbox "Pass"
														else
														msgbox "Fail"
														End if
														     
						End Select
End Function

'======================================================END of Function================================================================


'======================================================Events Related to Dialog==========================================================

' This function involves Dialog(Browse the image) related actions that shall Verify  the Dialog Opened
Public Function fnDialog1()
			   Select Case strAction
					 Case "VerifyParent"
											If Dialog(DialogDesc).Dialog(DialogDesc1).Exist then
												msgbox "Pass"
											else
												msgbox "Fail"
											End if
				End Select
End Function


'======================================================END of Function================================================================

Public Function fnWinEdit(DialogDesc,DialogDesc1,WinEditDesc,strAction,strParam,strExpected,strChkPoint)
					   Select Case strAction
								Case "Set"
                                               Dialog(DialogDesc).Dialog(DialogDesc1).WinEdit(WinEditDesc).Set strParam

					    End Select
End Function
'====================================================================================================================================
Public Function fnWinStatusbar(WebBrowserDesc,WinStatusbarDesc,strAction,strParam,strExpected,strChkPoint)
					   Select Case strAction
								Case "DblClick"
'										Set WinStatusbarDesc=Description.Create
'										WinStatusbarDesc("micclass").value="WinStatusbar"
										'Browser("Team FR1 - Razoo").WinStatusBar("msctls_statusbar32").DblClick
										Browser(WebBrowserDesc).WinStatusBar(WinStatusbarDesc).DblClick  91,9
								

								Case "Output CheckPoint"
										Browser(WebBrowserDesc).WinStatusBar("msctls_statusbar32").Output CheckPoint("msctls_statusbar32")
										IF  Browser(WebBrowserDesc).WinStatusBar("msctls_statusbar32").GetROProperty("text")="Done" Then
													Msgbox "Pass"
										else
													Msgbox "Fail"
													JSERR="Fail"
										End If

										If  JSERR = "Fail" Then
											Browser(WebBrowserDesc).WinStatusBar("msctls_statusbar32").DblClick 76,13
											Browser(WebBrowserDesc).Window("Windows Internet Explorer").Page("Windows Internet Explorer").WebButton("Show details").Click
											Browser(WebBrowserDesc).Window("Windows Internet Explorer").Page("Windows Internet Explorer").WebElement("Syntax error").Output CheckPoint("Syntax error")
											Browser(WebBrowserDesc).Window("Windows Internet Explorer").Page("Windows Internet Explorer").WebButton("Close").Click
										End If
										
							End Select
End Function
'======================================================Event Related to WebFile========================================================

'' This function involves all the File  related actions that shall Set  the Path of the File and Click File.

Public function fnFile(WebBrowserDesc,WebPageDesc,WebFileDesc,strAction,strParam,strExpected,strChkPoint)
					   Select Case strAction
					   'Set Value
										 Case "Set"
														Browser(WebBrowserDesc).Page(WebPageDesc).WebFile(WebFileDesc).Set strParam
						'Click on File				
										 Case "Click"
														 Browser(WebBrowserDesc).Page(WebPageDesc).WebFile(WebFileDesc).Click
						End Select
End Function


'======================================================END of Function================================================================


'======================================================Event related to web Image=======================================================

 'This function involves all the Image related actions that shall  Count the Fans,Click On Image 

Public function fnImageAction(WebBrowserDesc,WebPageDesc,WebImageDesc,strAction,strParam,strExpected,strChkPoint)

						Select Case strAction
										'Click Image
										 Case "Click"
														 Browser(WebBrowserDesc).Page(WebPageDesc).Image(WebImageDesc).Click
						' To Count the fans
										 Case "FansCount"
														 wait 5
														   intCountBeforeDonation=fnFanCount (WebBrowserDesc,WebPageDesc,WebImageDesc,strParam)
														   DataTable.Value("Expected","SubDriver [SubDriver]")=intCountBeforeDonation
														   
						' Vefrify Fans count		
										 Case "VerifyFansCount"
															Wait 5
															intCountAfterDonation=fnFanCount (WebBrowserDesc,WebPageDesc,WebImageDesc,strParam)
															DataTable.Value("Actual","SubDriver [SubDriver]")=intCountAfterDonation
															DataTable.Value("Expected","SubDriver [SubDriver]")=Cint(intCountBeforeDonation)+1
															strExpected=DataTable.Value("Expected","SubDriver [SubDriver]")
															strActual=DataTable.Value("Actual","SubDriver [SubDriver]")
															Call fnVerifyProperty (strExpected,strActual,strChkPoint)

                      'Verify Fans count is not increased     
											Case "VerifyFansCountNotIncreased"
														   Wait 5
															intFanCount=fnFanCount (WebBrowserDesc,WebPageDesc,WebImageDesc,strParam)
															DataTable.Value("Actual","SubDriver [SubDriver]")=intFanCount
															DataTable.Value("Expected","SubDriver [SubDriver]")=Cint(intCountBeforeDonation)
															strExpected=DataTable.Value("Expected","SubDriver [SubDriver]")
															strActual=DataTable.Value("Actual","SubDriver [SubDriver]")
															Call fnVerifyProperty (strExpected,strActual,strChkPoint)

						'VerfiyObjectExist					
											 Case "VerifyObjectExist"
															Set strActual=Browser(WebBrowserDesc).Page(WebPageDesc).Image(WebImageDesc)
															Call fnVerifyObjectExist(strExpected,strActual,strChkPoint)

                       ' VerfiyObject not Exist	
											  Case "VerifyObjectNotExist"
															 Set strActual=Browser(WebBrowserDesc).Page(WebPageDesc).Image(WebImageDesc)
															 Call fnVerifyObjectNotExist(strExpected,strActual,strChkPoint)

                         'Verify Property of object
											   Case "VerifyProperty"
															strActual=Browser(WebBrowserDesc).page(WebPageDesc).Image(WebImageDesc).GetROProperty(strParam)
															Call fnVerifyPropertyFileName(strExpected,strActual,strChkPoint)
                                           
                         'Verify image
												Case "VerifyWebImage"
																   if Browser(WebBrowserDesc).Page(WebPageDesc).Image(WebImageDesc).exist(10) then
																				strResult="Pass"
																	else
																				strResult="Fail"	
																	End If
							'Click on image (if more than one images are available in page)
												 Case "ClickMyFrProImage"
																 Call fnClickImage(WebBrowserDesc,WebPageDesc,WebImageDesc,strAction,strParam,strExpected,strChkPoint)

                           ' Delete particular image
												  Case "DeleteImage"
																Call fnDeleteImage(WebBrowserDesc,WebPageDesc,WebImageDesc,strAction,strParam,strExpected,strChkPoint)

                             'verfiy logo front of PRO/FR
												  Case "VerifyLogo"
																strActual= fnVerifyLogo (WebBrowserDesc,WebPageDesc,WebImageDesc,strParam)
                                                                 Call fnVerifyPropertyFileName(strExpected,strActual,strChkPoint)  

					End Select
 End Function


'======================================================END of Function================================================================


'======================================================Event Related to WebButton======================================================

' This function involves all the Button related actions that shall  Clik on Button to perform the task

Public function fnButton(WebBrowserDesc,WebPageDesc,WebButtonDesc,strAction,strParam,strExpected,strChkPoint)
					 Select Case strAction

                           'Click Button
												  Case "Click"
												                 Browser(WebBrowserDesc).Page(WebPageDesc).WebButton(WebButtonDesc).Click

						   'VerifyObjectExist				
												Case "VerifyObjectExist"
												               Set strActual= Browser(WebBrowserDesc).Page(WebPageDesc).WebButton(WebButtonDesc)
												               Call fnVerifyObjectExist(strExpected,strActual,strChkPoint)
										
                            'Delete card from Account Profile
												Case "DeleteCard"
													          Call fnDeleteCard(WebBrowserDesc,WebPageDesc,WebButtonDesc,strAction,strParam,strExpected,strChkPoint)

							'VerifyObject Not Exist				
												Case "VerifyObjectNotExist"
												               Set strActual= Browser(WebBrowserDesc).Page(WebPageDesc).WebButton(WebButtonDesc)
												               Call fnVerifyObjectNotExist(strExpected,strActual,strChkPoint)
										
					 End Select
End Function

'======================================================END of Function================================================================



'=======================================================Event Related to WebElement====================================================

' This function involves all the EditBox  related actions that shall Set  the values into EditBox  to perform the task.

Public function fnElement(WebBrowserDesc,Windowdesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
				 '	'Switch the relevant Action

						Select Case strAction
               'Check the Error Message
												Case "VerifyErrorMessage"
																strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebElement(WebObjDesc).GetROProperty(strParam)
                                                                Call fnVerifyProperty (strExpected,strActual,strChkPoint)

				'Check if Java Script Error Appears in each web page
												Case "FindJavaSErrorGetLineNumber"

																Call fnDetect_CloseJavaScriptError(WebBrowserDesc,Windowdesc,WebPageDesc,WebObjDesc,strParam)
'																strActual=Browser(WebBrowserDesc).Window(Windowdesc).Page(WebPageDesc).WebElement(WebObjDesc).GetROProperty(strParam)
'																msgbox strActual
																
				'Check the property of Element
												Case "VerifyProperty"
																strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebElement(WebObjDesc).GetROProperty(strParam)
																Call fnVerifyProperty (strExpected,strActual,strChkPoint)

				'Click  Web Element
												Case "Click"		
																Browser(WebBrowserDesc).Page(WebPageDesc).WebElement(WebObjDesc).Click

        	   'Checking the particular value shold not be there

												Case "VerifyPropertyForNotExist"
																strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebElement(WebObjDesc).GetROProperty(strParam)
																Call fnVerifyPropertyNotExist(strExpected,strActual,strChkPoint)

               'Checking the Web Element exist
											   Case "VerifyObjectExist"
															  Set strActual=Browser(WebBrowserDesc).page(WebPageDesc).WebElement(WebObjDesc)
															   Call fnVerifyObjectExist (strExpected,strActual,strChkPoint)

               'Checking the Card number in user's Profile page
												Case "VerifyCardNum"
																strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebElement(WebObjDesc).GetROProperty(strParam)
															    Call fnVerifyPropertyFileName(strExpected,strActual,strChkpoint)

               'Verify Marque in home page
												Case "VerifyMarque"
																 strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebElement(WebObjDesc).GetROProperty(strParam)
															     Call fnVerifyPropertyFileName(strExpected,strActual,strChkpoint)

                 'Verify the latest card number                       						
												Case "VerifyLatestCardNumber"
															  Set objWebElement=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebObjDesc)
																l=objWebElement.count
															   strActual=objWebElement(l-1).GetROProperty(strParam)
															   Call fnVerifyPropertyFileName(strExpected,strActual,strChkpoint)

				 'Verify Expired card
				                             Case "VerifyExpiredCard"
															Set objWebElement=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebObjDesc)
																l=objWebElement.count
                                                               strActual=objWebElement(l-1).GetROProperty(strParam)
															   Call fnVerifyPropertyFileName(strExpected,strActual,strChkpoint)

                'To Check the comments posted in the FaceBook
											   Case "VerifyNewsFeed"

															  Set WebBrowserDesc=Description.Create
															           WebBrowserDesc("micClass").value="Browser"
																		WebBrowserDesc("name").value="Twitter_2"

															  Set WebPageDesc=Description.Create
																		WebPageDesc("title").value="Twitter / Home"
                                                                   

															  Set WebObjDesc=Description.Create
																	WebObjDesc("micClass").value="WebElement"
																	WebObjDesc("Class").value="tweet-text"

                                                              Set objWebElement=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebObjDesc)
															  strActual=objWebElement(0).GetROProperty(strParam)
															  Call fnVerifyPropertyFileName(strExpected,strActual,strChkpoint)

              'VerifyCardNumNotExis
												Case "VerifyCardNumNotExist"
																strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebElement(WebObjDesc).GetROProperty(strParam)
																Call fnVerifyPropertyNotExist(strExpected,strActual,strChkpoint)

               'Getting the Designation value from the page
												Case "VerifyDesignation"
																Call fngetrownum()  
																DataTable.Value("Expected","SubDriver [SubDriver]")=strGetDesig
																strActual=Browser(WebBrowserDesc).Page(WebPageDesc).webtable(WebTableDesc).GetCellData(intRowNum,strParam)
																 strExpected=DataTable.Value("Expected","SubDriver [SubDriver]")
																Call  ffnVerifyProperty(strExpected,strActual,strChkPoint)

				 'Get  Designation value from Donation Transaction page
												 Case "GetDesignation"		
																strGetDesig=Browser(WebBrowserDesc).Page(WebPageDesc).WebElement(WebObjDesc).GetROProperty(strParam)
																DataTable.Value("Expected","SubDriver [SubDriver]")=strGetDesig
															
				'Get Organization total amount 
												Case "GetTotal"
        														strExpected=fnGetTotal(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
                                                                strExpected=Cdbl(fnTotal(strExpected))
																dblGetTotal=strExpected
                                                                DataTable.Value("Expected","SubDriver [SubDriver]")=dblGetTotal
                                                                										
				 'Verifying the Total amount of the Organization
												Case "VerifyTotal"
																dblVerifyTotal=fnGetTotal(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
                                                                dblVerifyTotal=Cdbl(fnTotal(dblVerifyTotal))
																strActual=dblVerifyTotal
																'strExpected=dblGetTotal+arrstrParam_Don(0)
																strExpected=dblGetTotal+intDonAmt
                                                                Call fnVerifyTotal(strExpected,strActual)


																								
				  'Get Total amount  from PRO/FR in Report
											   Case "GetTotal1"
																strExpected=fnGetTotal(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
                                                                strExpected=Cdbl(fnTotal(strExpected))
																dblGetTotal1=strExpected
                                                                DataTable.Value("Expected","SubDriver [SubDriver]")=dblGetTotal1
																
																
		          'Verify Total amount of the PRO/FR in Report
												 Case "VerifyTotal1"
                                        						dblVerifyTotal1=fnGetTotal(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
                                                                dblVerifyTotal1=Cdbl(fnTotal(dblVerifyTotal1))
																strActual=dblVerifyTotal1
                                                    			strExpected=dblGetTotal1+intDonAmt
                                                                Call fnVerifyTotal(strExpected,strActual)


				  ' To Check DonorWall
												 Case "VerifyDonorWall"
													 Set WebObjDesc=Description.Create
																WebObjDesc("micClass").value="WebElement"
																WebObjDesc("html id").value="comments"
																WebObjDesc("html tag").value="DIV"

																strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebElement(WebObjDesc).GetROProperty(strParam)
                                                            	Call fnVerifyDonorWall(strActual,strExpected)

			       	'To Check DonorWall not Exist							
												 Case "VerifyDonorWallNotExist"
                                                                 strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebElement(WebObjDesc).GetROProperty(strParam)
																 strDonWall=Mid(strActual,13)
															      Call  fnVerifyDonorWallNotExist(strDonWall,strExpected)

				'To Delete Image									
												  Case "DeleteImage"
															     Call fndeleteelement(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)

				'To Get Tracking Number					
												  Case "GetTrackingNo"
																 Set WebBrowserDesc=Description.Create
															           WebBrowserDesc("micClass").value="Browser"
																		WebBrowserDesc("name").value="Receipt"

																  Set WebPageDesc=Description.Create
																			WebPageDesc("title").value="Receipt"
																		
																 Set WebObjDesc=Description.Create
																 WebObjDesc("micClass").value="WebElement"
																 WebObjDesc("html tag").value="BODY"

																    aVar=Browser(WebBrowserDesc).Page(WebPageDesc).WebElement(WebObjDesc).GetROProperty(strParam)
										            				bVar=split(aVar,")")
																    intRefNum=mid(bVar(0),40)
																	DataTable.Value("Expected","SubDriver [SubDriver]")=intRefNum
																	Browser(WebBrowserDesc).Close

				 

				' To Get Disbursement Status						
													Case "VerifyDisbursementStatus" 
															        strActual=fnVerifyDibursementStatus(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
                                                        		    DataTable.Value("Actual","SubDriver [SubDriver]")=strActual
															        Call fnVerifyProperty(strExpected,strActual,strChkpoint)
										
               'To Verify Undisbursed Message
													Case "VerifyUndisbursedMessage" 
															       strActual=fnVerifyDibursementStatus (WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
                                                            		DataTable.Value("Actual","SubDriver [SubDriver]")=strActual
															        Call fnVerifyProperty (strExpected,strActual,strChkpoint)
										
												    Case "StatusLastChanged"
																	strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebElement(WebObjDesc).GetROProperty(strParam)
																	Call fnVerifyPropertyFileName(strExpected,strActual,strChkpoint)
										
               'To Verify Thanks message from thanks you screen
													Case "VerifyThanks" 
															       strActual=fnVerifyDibursementStatus (WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
																    DataTable.Value("Actual","SubDriver [SubDriver]")=strActual
															        Call fnVerifyProperty (strExpected,strActual,strChkpoint)

                'Verify Fan text message
													Case "VerifyFanText" 
															        strActual=fnVerifyDibursementStatus(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
                                                        		    DataTable.Value("Actual","SubDriver [SubDriver]")=strActual
															        Call fnVerifyProperty(strExpected,strActual,strChkpoint)
				'VerifyElement
													Case"VerifyDonMessage"
																	strActual=fnVerifyDibursementStatus(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
                                                        		    DataTable.Value("Actual","SubDriver [SubDriver]")=strActual
															        Call fnVerifyProperty(strExpected,strActual,strChkpoint)

               'Checking the Card number in user's Profile page
												Case "VerifyPropertyForExist"
																strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebElement(WebObjDesc).GetROProperty(strParam)
															    Call fnVerifyPropertyFileName(strExpected,strActual,strChkpoint)


			 'To Get the time zone displayed in the Story Page

								   				
								   				Case "GetTimeZone"
																	strExpected=fnGetTimeZone(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint)
																	strGetTimeZone=strExpected
																	DataTable.Value("Expected","SubDriver [SubDriver]")=strExpected	


				'To Verify the TimeZone dislayed in the Story Page

											   Case " VerifyTimeZone"
                                                                strExpected=fnTime(strGetTimeZone)
                                                                DataTable.Value("Expected","SubDriver [SubDriver]")=strExpected	
																strActual=fnGetTimeZone(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint)
                                                            	DataTable.Value("Actual","SubDriver [SubDriver]")=strActual
																If strExpected=strActual Then
																			strResult="Pass"
																Else
																			strResult="Fail"
																End If
																DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult


				'To Verify  My Projects, Fundraisers or Causes i am following
				                            Case "MyPagesOrCauses"
																		 Set WebObjDesc=Description.Create
																		 WebObjDesc("micClass").value="WebElement"
																		 WebObjDesc("class").value="results"

																		Set objWebElement=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebObjDesc)
																		strActual=objWebElement(strParam).getroproperty("innertext")
																		Call fnVerifyPropertyFileName (strExpected,strActual,strChkpoint)

					'Get User total donations
							
											Case "GetUserTotalDonations"
																set WebObjDesc=Description.Create
																WebObjDesc("micclass").value="WebElement"
																WebObjDesc("class").value="inset"
																WebObjDesc("html tag").value="DIV"
																
																Set objWebElement=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebObjDesc)
                                                                				
                                                                DataTable.Value("Actual","SubDriver [SubDriver]")=objWebElement(1).getroproperty(strParam)

				'Get Raised amount from Campaign story page
												Case "GetRaisedAmount"
															 strExpected= fnGetTotal(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
															 strRaised1=Split(strExpected,"Raised")
															 intGetRaised=Cint(Mid(strRaised1(0),2))
															 DataTable.Value("Actual","SubDriver [SubDriver]")=intGetRaised
                                                        
			'Get Donor Count from Campaign story page
												Case "GetDonorCount"
															 strExpected= fnGetTotal(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
															 strRaised1=Split(strExpected,"Donor")
															 intGetDonorCount=Cint(strRaised1(0))
															 DataTable.Value("Actual","SubDriver [SubDriver]")= intGetDonorCount

			'Verify  Raised amount in Campaign story page
												Case "VerifyRaisedAmount"
															 strExpected= fnGetTotal(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
															 strRaised1=Split(strExpected,"Raised")
															 intVerifyRaised=Cint(Mid(strRaised1(0),2))
															 DataTable.Value("Actual","SubDriver [SubDriver]")=intVerifyRaised
															 DataTable.Value("Expected","SubDriver [SubDriver]")=intGetRaised+intDonAmt
															Call fnVerifyProperty (intGetRaised+intDonAmt,intVerifyRaised,strChkPoint)

			'Verify Donor Count in Campaign story page
												Case "VerifyDonorCount"
															 strExpected= fnGetTotal(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
															 strRaised1=Split(strExpected,"Donor")
															 intVerifyDonorCount=Cint(strRaised1(0))
															 DataTable.Value("Actual","SubDriver [SubDriver]")= intVerifyDonorCount
                                                             DataTable.Value("Expected","SubDriver [SubDriver]")=intGetDonorCount+1
															Call fnVerifyProperty (intGetDonorCount+1,intVerifyDonorCount,strChkPoint)

			'Verify  Raised amount not increased in Campaign story page
                                                 Case "VerifyRaisedAmountNotIncreased"
															 strExpected= fnGetTotal(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
															 strRaised1=Split(strExpected,"Raised")
															 intVerifyRaised=Cint(Mid(strRaised1(0),2))
															 DataTable.Value("Actual","SubDriver [SubDriver]")=intVerifyRaised
															 DataTable.Value("Expected","SubDriver [SubDriver]")=intGetRaised
															Call fnVerifyProperty (intGetRaised,intVerifyRaised,strChkPoint)

	'Get FundRasisers Count from Campaign StoryPage
												Case "GetFundRaisersCount"
															 strExpected= fnGetTotal(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
															 strRaised1=Split(strExpected,"Fundraiser")
                                                              intGetFundRaisersCount=Cint(strRaised1(0))
															 DataTable.Value("Actual","SubDriver [SubDriver]")= intGetFundraisersCount

            'Verify Fundraisers Count in campaign Story page
											Case"VerifyFundraisersCount"
															strExpected= fnGetTotal(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
															 strRaised1=Split(strExpected,"Fundraiser")
															 intVerifyFundRaisersCount=Cint(strRaised1(0))
															 DataTable.Value("Actual","SubDriver [SubDriver]")= intVerifyFundRaisersCount
                                                             DataTable.Value("Expected","SubDriver [SubDriver]")=intGetFundRaisersCount+1
															Call fnVerifyProperty (intGetFundRaisersCount+1,intVerifyFundRaisersCount,strChkPoint)
														
           ' Verify  Fundraisers Count not increased in Campaign story page
												 Case "VerifyFundraisersCountNotIncreased"
															 strExpected= fnGetTotal(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
															 strRaised1=Split(strExpected,"Fundraiser")
															 intVerifyFundRaisersCount=Cint(strRaised1(0))
															 DataTable.Value("Actual","SubDriver [SubDriver]")=intVerifyFundRaisersCount
															 DataTable.Value("Expected","SubDriver [SubDriver]")=intGetFundRaisersCount
															Call fnVerifyProperty (intGetFundRaisersCount,intVerifyFundRaisersCount,strChkPoint)
			'Detect Js Issue
												Case "DetectJavaError"

														Call CloseJavaScriptError
														ErrorText = Window("regexpwndtitle:=Windows Internet Explorer").Page("title:= Windows Internet Explorer").WebElement("html tag:= DIV", "innertext:= Line.*").GetROProperty("innertext")
														msgbox (ErrorText)

      
			End Select
End Function

'======================================================END of Function================================================================



'======================================================Event related to Link=============================================================

' This function involves the Link's  related actions  

Public function fnLink(WebBrowserDesc,WebPageDesc,WebLinkDesc,strAction,strParam,strExpected,strChkPoint)

				'Switch the relevant Action

					Select Case strAction

                'To Cllick link
													Case "Click"
																	Browser(WebBrowserDesc).Page(WebPageDesc).Link(WebLinkDesc).Click
											
               ' To verify link Exist
													 Case "VerifyWebLink"
																	 Set strActual=Browser(WebBrowserDesc).Page(WebPageDesc).Link(WebLinkDesc)
																	  Call fnVerifyObjectExist(strExpected,strActual,strChkPoint)
											 
               'To Verify property of  link
												   Case "VerifyProperty"
																	strActual=Browser(WebBrowserDesc).Page(WebPageDesc).Link(WebLinkDesc).GetROProperty(strParam)
																	Call fnVerifyProperty (strExpected,strActual,strChkPoint)
											
               ' To verify link not Exist
												   Case "VerifyWebLinkNotExist"
																   if Not Browser(WebBrowserDesc).Page(WebPageDesc).link(WebLinkDesc).exist(5) Then
																		strResult="Pass"
																	else
																	     strResult="Fail"	
																	End If
                                                                    DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult
											
                  ' To Click particular View receipt
												 Case "ClickViewReceipt"
																Call fnViewReceipt(WebBrowserDesc,WebPageDesc,WebLinkDesc,strAction,strParam,strExpected,strChkPoint)
											
                  'To click particular link
												Case "ClickLink"
															   Call fnViewReceipt(WebBrowserDesc,WebPageDesc,WebLinkDesc,strAction,strParam,strExpected,strChkPoint)

					'To delete particular card						
				 								 Case "DeleteCard"
															    Call fnViewReceipt(WebBrowserDesc,WebPageDesc,WebLinkDesc,strAction,strParam,strExpected,strChkPoint)

						End Select
End Function

'======================================================END of Function================================================================



'======================================================Event related to List  ============================================================

' This function involves the ListBox(ComboBox)  related actions  

Public function fnList(WebBrowserDesc,WebPageDesc,WebListDesc,strAction,strParam,strExpected,strChkPoint)

					'Switch the relevant Action

					   Select Case strAction

					   'Select  value from Listbox
												Case "Select"
																Browser(WebBrowserDesc).Page(WebPageDesc).WebList(WebListDesc).Select strParam 
																strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebList(WebListDesc).GetROProperty("value")
																Call fnVerifyProperty (strParam,strActual,strChkPoint)
					
                       'verify property 
												Case "VerifyProperty"
											                	strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebList(WebListDesc).GetROProperty(strParam)
												                Call fnVerifyProperty(strExpected,strActual,strChkPoint)
									
                          'VerifyObjectExist												
						                           Case "VerifyObjectExist"
																  Set strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebList(WebListDesc)
																  Call fnVerifyObjectExist(strExpected,strActual,strChkPoint)
										
						End Select
													wait(5)
End Function


'======================================================END of Function================================================================


'======================================================Event related to CheckBox  ======================================================
 
'This function involves the CheckBox  related actions  

Public function fnCheckBox(WebBrowserDesc,WebPageDesc,WebCheckBoxDesc,strAction,strParam,strExpected,strChkPoint)

						'Switch the relevant Action

						 Select Case strAction 

						'Select CheckBox
													Case "Set"
																   Browser(WebBrowserDesc).Page(WebPageDesc).WebCheckBox(WebCheckBoxDesc).Set strParam
  						'Verify Checkbox is Selected
							   
													Case "VerifyChecked"
																	strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebCheckBox(WebCheckBoxDesc).GetROProperty(strParam)
																	Call fnVerifyProperty (strExpected,strActual,strChkPoint)
																	 
							'VerifyObjectExist							
													Case "VerifyObjectExist"
																	Set strActual=Browser(WebBrowserDesc).page(WebPageDesc).WebCheckBox(WebCheckBoxDesc)
																	Call fnVerifyObjectExist (strExpected,strActual,strChkPoint)
														
							'VerifyProperty
												   Case "VerifyProperty"
																   strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebCheckBox(WebCheckBoxDesc).GetROProperty(strParam)
																   Call fnVerifyProperty (strExpected,strActual,strChkPoint)

                           'UnSelect all checkboxes from Marque page
													Case "UnSelectAllCheckBoxes"
																	Call fnUnSelectCheckBoxes(WebBrowserDesc,WebPageDesc,WebTableDesc,WebCheckBoxDesc,strParam)
													
							'Select Particular CheckBox from Marque page			
													Case "SelectParticularCheckBox"
																	Call fnSelectParticularCheckBox(WebBrowserDesc,WebPageDesc,WebTableDesc,WebCheckBoxDesc,strParam)

                             'Select LatestCheckBox
												Case "SelectLatestCheckBox"
																Call fnSelectLatestCheckBox(WebBrowserDesc,WebPageDesc,WebTableDesc,WebCheckBoxDesc,strParam)
End Select
End Function


'======================================================END of Function================================================================



'======================================================Event related to RadioButton =====================================================

' This function involves the RadioButton related actions  

Public function  fnRadioGroup(WebBrowserDesc,WebPageDesc,WebRadioGroupDesc,strAction,strParam,strExpected,strChkPoint)		  
							
					     'Switch the relevant Action

						   Select Case strAction

							'Select RadioButton
												    Case "Select"
																	Browser(WebBrowserDesc).Page(WebPageDesc).WebRadioGroup(WebRadioGroupDesc).Select strParam
																	strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebRadioGroup(WebRadioGroupDesc).GetROProperty("selected item index")
																	Call fnVerifyProperty (strExpected,strActual,strChkPoint)

								'VerifyProperty							
													Case "VerifyProperty"
																	strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebRadioGroup(WebRadioGroupDesc).GetROProperty(strParam)
																	Call fnVerifyProperty (strExpected,strActual,strChkPoint)

								'Count No.of RadioButtons
															
												     Case "Count"
																	strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebRadioGroup(WebRadioGroupDesc).GetROProperty("items count")
																	Call fnVerifyProperty (strExpected,strActual,strChkPoint)

                                 'Select AddNewCard RadioButton
															
												    Case "AddNewCard"
																   Browser(WebBrowserDesc).Page(WebPageDesc).WebRadioGroup(WebRadioGroupDesc).Select strParam

									'VerifyObjectNotExist
																   
													Case "VerifyObjectNotExist"
																	Set strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebRadioGroup(WebRadioGroupDesc)
																	Call fnVerifyObjectNotExist(strExpected,strActual,strChkPoint)

													Case"VerifyObjectExist"
																	Set strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebRadioGroup(WebRadioGroupDesc)
																	Call fnVerifyObjectExist(strExpected,strActual,strChkPoint)
			
                                 End Select
End Function


'======================================================END of Function================================================================


'======================================================Event related to WinButton =======================================================

'This function involves the Button(in SubWindow) related actions  

Public function fnWinButton(WebBrowserDesc,WebDialogDesc,WinButtonDesc,strAction,strParam,strExpected,strChkPoint)

						'Switch the relevant Action

						   Select Case strAction

							'Click Button
													Case "Click"
														Browser(WebBrowserDesc).Dialog(WebDialogDesc).WinButton(WInButtonDesc).Click
											
							'VerifyWinButton
													Case "VerifyWinButton"
																	if Browser(WebBrowserDesc).Dialog(WebDialogDesc).WinButton(WinButtonDesc).exist(10) Then
																					strResult="Pass"
																	else
																					strResult="Fail"	
																	End If
											         DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult
							'Click Button
                                                     Case "ClickButton"
																Dialog(WebBrowserDesc).Dialog(WebDialogDesc).WinButton(WinButtonDesc).Click 
						End Select
End Function

'======================================================END of Function================================================================



'======================================================Event Related to WebTable======================================================

'This function involves the WebTable related actions  

Public function fnWebTable(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint)

					'Switch the relevant Action
						Select Case strAction

                      'Getting the Reference Number from View Receipt
													Case "GetReferenceNum"
																	Call fngetreferencenum(WebBrowserDesc,WebPageDesc,WebTableDesc,strParam)
					'Get DonorName
													Case "GetDonorName"
																	Call fngetdonorname(WebBrowserDesc,WebPageDesc,WebTableDesc,strParam,strExpected)
					'GetSuggestion amount

													Case "GetSuggestionAmtdesc"
																	Call fnGetSuggestionAmtDesc(WebBrowserDesc,WebPageDesc,WebTableDesc,strParam)
                                            
						'Check the all values in the View Receipt page

													Case "VerifyValue"
																	Set WebTableDesc=Description.Create

																	WebTableDesc("micClass").value="WebTable"
																	WebTableDesc("html tag").value="TABLE"
																	WebTableDesc("name").value="WebTable"

																	arrWebTab=split(strParam,",")
																	intRowNum=arrWebTab(0)
																    intColNum=arrWebTab(1)
																    strActual= Browser(WebBrowserDesc).page(WebPageDesc).WebTable(WebTableDesc).GetCellData(intRowNum,  intColNum)
																	Call  fnVerifyProperty (strExpected,strActual,strChkPoint)


						' check the Donor name,Contact info, Mail id, Source and Donated Amount in the Report

													Case "VerifyDname"
																	strActual=objWebTable(0).GetCellData(intRowNum,strParam)
																	Call  fnVerifyProperty (strExpected,strActual,strChkPoint)

					'Get the Row number from WebTable
													Case "GetRowNum"
																	Call  fnGetRowNum()

					'Getting latest tracking number
													Case"GetTrackingNumber"
																			Call fnLatestGetRowNum()  
																			strActual=objWebTable(0).GetCellData(2,1)
																			DataTable.Value("Actual","SubDriver [SubDriver]")=strActual
																			intRefNum=strActual
						'Check  Donor Name
                                                   Case "VerifyDnameGlobal"
                                                        			  Call fnGetRowNumAdmin()  
																	  strActual=objWebTable(arrWtIndex(0)).GetCellData(intRowNum,arrWtIndex(1))
																	  Call  fnVerifyProperty (strExpected,strActual,strChkPoint)

						'Check the designation in the report with what value we have taken from while donation

													  Case "VerifyDesignation"
																	Call  fnGetRowNum()  
																	DataTable.Value("Expected","SubDriver [SubDriver]")=strGetDesig
																	strActual=Browser(WebBrowserDesc).Page(WebPageDesc).webtable(WebTableDesc).GetCellData(intRowNum,strParam)
																	strExpected=DataTable.Value("Expected","SubDriver [SubDriver]")
																	Call  fnVerifyProperty (strExpected,strActual,strChkPoint)

						'Check the Donor name, Contact info, Designation, Amount donated to page of the Guest user
					   'We are checking the above details without using Reference Number, we are checking the details about Donor in the last rwo of the Donation Report
														Case "VerifyDnameGuestUser"
																		Call fnLatestGetRowNum()  
																	    strActual=objWebTable(0).GetCellData(intRowNum,strParam)
																	    Call  fnVerifyProperty (strExpected,strActual,strChkPoint)

							'Get DonatedAmount
														Case "GetDonateAmt"
																	  Call fnLatestGetRowNum()  
																	  strActual=objWebTable(0).GetCellData(intRowNum,strParam)
																	   intDonAmt=Cdbl(Mid(strActual,3))
																	  DataTable.Value("Expected","SubDriver [SubDriver]")=intDonAmt

								'Verify Organizatio(Verify/UnVerify)
														Case "VerifyAudit"
																		call fnWebTableOrgDetails(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint) 
				
					  'GetTotal Donations
                										Case "GetTotalDonations"
                                                                       dblGetDisbAmt=Cdbl(fngettotaldonations(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint) )
																		DataTable.Value("Expected","SubDriver [SubDriver]")=dblGetDisbAmt
				
				        'Verify Total Donations
														Case "VerifyTotalDonations"
																	   DataTable.Value("Actual","SubDriver [SubDriver]")=dblGetDisbAmt
																		dblVerifyTotDonAmt=Cdbl(fnverifygettotaldonations(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint) )
																		DataTable.Value("Expected","SubDriver [SubDriver]")=dblVerifyTotDonAmt
																		Call  fnVerifyProperty (dblVerifyTotDonAmt,dblGetDisbAmt,strChkPoint)
										
						'Refunds
														Case "GetTotalAdjustments" 
																	   dblGetRefAmt=Cdbl(fngettotaladjustments(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint))
																		DataTable.Value("Expected","SubDriver [SubDriver]")=dblGetRefAmt

						'Total Disbursement  Adjustments
												
														 Case "GetTotalDisbursementAdjustments"
																	   dblGetDisbAdjAmt=Cdbl(fngettotaldisbursementadjustments(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint))
																		DataTable.Value("Expected","SubDriver [SubDriver]")=dblGetDisbAdjAmt
						'Verify Disbursement Total

														 Case "VerifyDisbursementTotal"
																	   dblVerifyDisbTot=fnverifydisbursementtotal(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint)
																	   strActual=dblVerifyDisbTot
																		DataTable.Value("Actual","SubDriver [SubDriver]")=strActual
																	   strExpected = dblGetDisbAmt*(100 - dblGetPF-  dblGetBF) / 100 + dblGetRefAmt + dblGetDisbAdjAmt
																	   DataTable.Value("Expected","SubDriver [SubDriver]")=strExpected
																	   Call fnVerifyProperty (strExpected,strActual,strChkPoint)

							'Verifying Payment Details
													Case"VerifyPaymentDetails"
																	Set WebBrowserDesc=Description.Create
																		    WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"

																	 Set WebPageDesc=Description.Create
																				WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"

																	Set WebTableDesc=Description.Create
																			  WebTableDesc("micClass").value="WebTable"
																			 WebTableDesc("name").value="WebTable"
																			 WebTableDesc("html tag").value="TABLE"

																			arrWtIndex=split(strParam,",")
																	 Set objWebTable=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebTableDesc)

																			strActual=objWebTable(arrWtIndex(0)).GetCellData(2,arrWtIndex(1))
																			Call fnVerifyProperty(strExpected,strActual,strChkPoint)


'Set the Checkno in the CheckNumbers EditBox field
											   Case "SetCheckNumbers"
															Set WebBrowserDesc=Description.Create
															WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
															
															Set WebPageDesc=Description.Create
															WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
															
															  Set WebTableDesc=Description.Create
															  WebTableDesc("micClass").value="WebTable"
															  WebTableDesc("html tag").value="TABLE"
															ColValue=0
															n=browser(WebBrowserDesc).Page(WebPageDesc).WebTable(WebTableDesc).RowCount
															ReDim ColCount(n)
															For i=2 to n Step 1
															
															If browser(WebBrowserDesc).Page(WebPageDesc).WebTable(WebTableDesc).GetCellData(i,4)<>"" Then
															ColCount(ColValue)=browser(WebBrowserDesc).Page(WebPageDesc).WebTable(WebTableDesc).GetCellData(i,4)
															ColValue=ColValue+1
															End if
															Next
															ColValue=ColValue-1
															While  ColValue>=0 
															CheckNo=CheckNo&","&ColCount(ColValue)
															browser("An inspiring place to").Page("An inspiring place to").WebEdit("batch").Set CheckNo
															ColValue=ColValue-1
														 wend

'Verify CampaignFee in Fees and Subsidy fee table
										Case "VerifyCampaignFee"
														Set WebBrowserDesc=Description.Create
																WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
														
														Set WebPageDesc=Description.Create
																WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
														
														Set WebTableDesc=Description.Create
																WebTableDesc("micClass").value="WebTable"
																WebTableDesc("name").value="Processing Fees"
																WebTableDesc("html tag").value="TABLE"
																strActual=browser(WebBrowserDesc).Page(WebPageDesc).WebTable(WebTableDesc).GetCellData(4,2)
																DataTable.Value("Actual","SubDriver [SubDriver]")=strActual
																Call fnVerifyProperty(strExpected,strActual,strChkPoint)

'Verify CampaignFeeAmount  in Fees and Subsidy fee table
									    Case "VerifyCampaignFeeAmount"
													
													Set WebBrowserDesc=Description.Create
																WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
													
													Set WebPageDesc=Description.Create
																WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
													
													Set WebTableDesc=Description.Create
															WebTableDesc("micClass").value="WebTable"
															WebTableDesc("name").value="Processing Fees"
															WebTableDesc("html tag").value="TABLE"
															strActual=browser(WebBrowserDesc).Page(WebPageDesc).WebTable(WebTableDesc).GetCellData(4,3)
															DataTable.Value("Actual","SubDriver [SubDriver]")=strActual



					End Select
 End Function

'======================================================END of Function================================================================


'======================================================Check Disbursement Status======================================================

'This function Checks the Disbursement status  

Public Function fnVerifyDibursementStatus (WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
								 Set WebObjDesc=Description.Create
										 WebObjDesc("micClass").value="WebElement"
										WebObjDesc("html tag").value="SPAN"
								 Set  objWebElement=Browser("An inspiring place to").page("An inspiring place to").ChildObjects(WebObjDesc)
										fnVerifyDibursementStatus = objWebElement(strParam).getroproperty("innertext")
								Set WebObjDesc=nothing

End Function

'======================================================END of Function================================================================


'======================================================Sign Up Events=================================================================
'This function  is  for Craete An Account

Public function fnSignUp(WebBrowserDesc,WebPageDesc,strAction,strParam,strExpected,strChkPoint)
								Set WebEditDesc = Description.Create
								Set WebImageDesc = Description.Create
								Set WebButtonDesc = Description.Create
								Set WebLinkDesc = Description.Create
								Set WebCheckBoxDesc = Description.Create
								arrSignup=split(strParam,",")
								WebEditDesc("html id").value="user_first_name"
								Browser(WebBrowserDesc).Page(WebPageDesc).WebEdit(WebEditDesc).Set arrSignUp(0)
								WebEditDesc("html id").value="user_last_name"
								Browser(WebBrowserDesc).Page(WebPageDesc).WebEdit(WebEditDesc).Set arrSignUp(1)
								WebEditDesc("html id").value="user_email"
								Browser(WebBrowserDesc).Page(WebPageDesc).WebEdit(WebEditDesc).Set arrSignUp(2)
								WebEditDesc("html id").value="user_password"
								Browser(WebBrowserDesc).Page(WebPageDesc).WebEdit(WebEditDesc).Set arrSignUp(3)
								WebEditDesc("html id").value="user_password_confirmation"
								Browser(WebBrowserDesc).Page(WebPageDesc).WebEdit(WebEditDesc).Set arrSignUp(4)
								WebCheckBoxDesc("html id").value="user_terms_of_use"
								Browser(WebBrowserDesc).Page(WebPageDesc).WebCheckBox(WebCheckBoxDesc).Set arrSignUp(5)
								WebCheckBoxDesc("html id").value="user_mail_opt_in"
								Browser(WebBrowserDesc).Page(WebPageDesc).WebCheckBox(WebCheckBoxDesc).Set arrSignUp(6)
                                Browser(WebBrowserDesc).Page(WebPageDesc).WebButton("name:=Create Account").Click 
End Function

'======================================================END of Function================================================================


'======================================================Home Page ->Login============================================================

Public Function fnLogin(WebBrowserDesc,WebPageDesc,strAction,strParam,strExpected,strChkPoint)

									Browser("An inspiring place to").Page("An inspiring place to").Link("Log in").Click
									arrLogin=split(strParam,",")
									Browser("An inspiring place to").page("An inspiring place to").WebEdit("user_session[email]").Set arrLogin(0)
									Browser("An inspiring place to").Page("An inspiring place to").WebEdit("user_session[password]").Set arrLogin(1)
									Browser("An inspiring place to").Page("An inspiring place to").WebButton("Log in").Click

End Function


'======================================================END of Function================================================================



'======================================================Donation Process===============================================================
Public Function fnCardDetails(strParam)
                         
									arrstrParam_Don=Split(strParam,",")
									Browser("Receipt").Page("An inspiring place to_3").WebEdit("donation_transactiond_donation_amount").Set arrstrParam_Don(0)
									intDonAmt=arrstrParam_Don(0)
									Browser("Receipt").Page("An inspiring place to_3").WebEdit("order_user_name_on_card").Set arrstrParam_Don(1)
									Browser("Receipt").Page("An inspiring place to_3").WebEdit("order_user_order[address1]").Set arrstrParam_Don(2)
									Browser("Receipt").Page("An inspiring place to_3").WebEdit("order_user_order[city]").Set arrstrParam_Don(3)
									Browser("Receipt").Page("An inspiring place to_3").WebEdit("order_user_order[state]").Set arrstrParam_Don(4)
									Browser("Receipt").Page("An inspiring place to_3").WebEdit("order_user_order[postalcode]").Set arrstrParam_Don(5)
									Browser("Receipt").Page("An inspiring place to_3").WebList("order_user_order[country]").Select arrstrParam_Don(6)
									Browser("Receipt").Page("An inspiring place to_3").WebEdit("order_user_order[card_number]").Set arrstrParam_Don(7)
									Browser("Receipt").Page("An inspiring place to_3").WebList("order_user_order[expire_month]").Select arrstrParam_Don(8)
									Browser("Receipt").Page("An inspiring place to_3").WebList("order_user_order[expire_year]").Select arrstrParam_Don(9)
									Browser("Receipt").Page("An inspiring place to_3").WebEdit("order_user_order[security_code]").Set arrstrParam_Don(10)

End Function

'======================================================END of Function================================================================


'======================================================Get Donated Amt===============================================================

Public function fnGetDonateVal(WebBrowserDesc,WebPageDesc,WebObjDesc)

								  strParam = Browser(WebBrowserDesc).Page(WebPageDesc).WebElement(WebObjDesc).GetROProperty("innerhtml")
							      intDonVal=split(strParam,"$")
								  intDonVal1 = split(intDonVal(1)," ")

End Function

'======================================================END of Function================================================================


'======================================================Get Donation Reference Number==================================================

Public function  fnGetReferenceNum(WebBrowserDesc,WebPageDesc,WebTableDesc,strParam)
								   RowCol=split(strParam,",")
								   Row=RowCol(0)
								   Col=RowCol(1)
								   intRefNum = Browser(WebBrowserDesc).page(WebPageDesc).WebTable(WebTableDesc).GetCellData(Row,Col)
								   DataTable.Value("Expected","SubDriver [SubDriver]")=intRefNum
					
End Function


'======================================================END of Function================================================================


'======================================================GetSuggestionAmt& Description==================================================

Public function fngetsuggestionamtdesc(WebBrowserDesc,WebPageDesc,WebTableDesc,strParam)

									strparam = browser(WebBrowserdesc).page(WebPageDesc).webtable(webtabledesc).GetCellData (1,2)
									strSugAmt = split(strParam,"$")
									strSugAmt1 = split(strSugAmt(1)," ")
									
End Function

'======================================================END of Function================================================================


'======================================================Get Fans Count===================================================================

Public function fnFanCount(WebBrowserDesc,WebPageDesc,WebImageDesc,strParam)
						Set WebImageDesc=Description.Create
							
								WebImageDesc("height").Value = 36
								WebImageDesc("width").value=36
								Set objtotalFans = Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebImageDesc)
								fnFanCount=objtotalFans.Count
							                        

End Function

'======================================================END of Function================================================================


'======================================================Getting WebImage file name===================================================================

Public function fnVerifyLogo (WebBrowserDesc,WebPageDesc,WebImageDesc,strParam)

							Set objtotalFans = Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebImageDesc)
							fnVerifyLogo=objtotalFans(strParam).getroproperty("file name")
                             
End Function

'======================================================END of Function================================================================

'======================================================View Receipt==================================================================

Public Function fnViewReceipt(WebBrowserDesc,WebPageDesc,WebLinkDesc,strAction,strParam,strExpected,strChkPoint)

							 	Set WebBrowserDesc=Description.Create
                                   WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"

								Set WebPageDesc=Description.Create
									WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"

							    Set WebLinkDesc=Description.Create
                                    WebLinkDesc("micClass").value="Link"
									WebLinkDesc("html tag").value="A"

								Set objtotalLinks=Browser(WebBrowserDesc).Page(WebPageDesc).Childobjects(WebLinkDesc)
                                        objtotalLinks(strParam).Click


End Function

'======================================================END of Function================================================================


'======================================================Click Image under My Fundraisers=================================================

Public Function  fnClickImage(WebBrowserDesc,WebPageDesc,WebImageDesc,strAction,strParam,strExpected,strChkPoint)

								Set intTotImages=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebImageDesc)
								WebImageDesc("abs_x").value= intTotImages(strParam).getroproperty("abs_x")
								WebImageDesc("abs_y").value= intTotImages(strParam).getroproperty("abs_y")
								Browser(WebBrowserDesc).Page(WebPageDesc).Image(WebImageDesc).click

End Function

'======================================================END of Function================================================================


'======================================================Click to  Delete an ORG(WebElement0=============================================

Public Function  fnDeleteElement(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)

								Set intTotImages=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebObjDesc)
								WebObjDesc("abs_x").value= intTotImages(strParam).getroproperty("abs_x")
								WebObjDesc("abs_y").value= intTotImages(strParam).getroproperty("abs_y")
								Browser(WebBrowserDesc).Page(WebPageDesc).WebElement(WebObjDesc).click

End Function

'======================================================END of Function================================================================



'===========================================Delete Image under My Fundraisers/Follow ups=================================================

Public Function  fnDeleteImage(WebBrowserDesc,WebPageDesc,WebImageDesc,strAction,strParam,strExpected,strChkPoint)

								Set intTotImages=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebImageDesc)
								intTotImages(strParam).click

End Function

'======================================================END of Function================================================================


'======================================================Set WebEdit Textbox Value======================================================

'To Set the value in the WebEdit box when more than one edit box is available in the application if the properties are same

Public Function  fnSetWebEditBox(WebBrowserDesc,WebPageDesc,WebEditDesc,strAction,strParam,strExpected,strChkPoint)

									Set intEditbxCnt=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebEditDesc)
									arrParam=split(strParam,",")
									WebEditDesc("abs_x").value=intEditbxCnt(arrParam(0)).getroproperty("abs_x")
									WebEditDesc("abs_y").value=intEditbxCnt(arrParam(0)).getroproperty("abs_y")
									Browser(WebBrowserDesc).Page(WebPageDesc).WebEdit(WebEditDesc).Set arrParam(1)

End Function

'======================================================END of Function================================================================



'======================================================Delete Card from user profile=====================================================

' Delete Card from user profile even though more cards available

Public Function fnDeleteCard(WebBrowserDesc,WebPageDesc,WebButtonDesc,strAction,strParam,strExpected,strChkPoint)

										Set intButtonCnt=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebButtonDesc)
										WebButtonDesc("abs_x").value= intButtonCnt(strParam).getroproperty("abs_x")
										WebButtonDesc("abs_y").value= intButtonCnt(strParam).getroproperty("abs_y")
										Browser(WebBrowserDesc).Page(WebPageDesc).WebButton(WebButtonDesc).Click

End Function

'======================================================END of Function================================================================



'======================================================GetChampaignGoal &Date=================================================

Public function fnGetChampaingoDate(WebBrowserDesc,WebPageDesc,WebobjDesc,strParam)

								  strparam = browser(WebBrowserDesc).page(WebPageDesc).webElement(WebObjDesc).GetROProperty(strParam) 
								  strSugAmt = split(strParam,"$")
								  strSugAmt1 = split(strSugAmt(1),"by")
						
End Function


'======================================================END of Function================================================================


'======================================================Get FR Link====================================================================

Public function fnGetcChildLink(WebBrowserDesc,WebPageDesc,WebobjDesc,strParam)
									  Set objLink = Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebLinkdesc) 
									   intLinkCount = objLink.count
									   strLinkName=strParam

										For i = 1 to intLinkCount-1 step 1
										strLinkFound =objLink(i).GetRoProperty("name")

												If  strLinkName = strLinkfound Then
														 Exit for
												      End If
										Next
End Function

'======================================================END of Function================================================================


'======================================================Verifythe Expected==============================================================

Public Function fnVerifyTotal(strExpected,strActual)

									If strExpected=strActual Then
											strResult="Pass"
									Else
											strResult="Fail"
									End If
									DataTable.Value("Actual","SubDriver [SubDriver]")=strActual
									DataTable.Value("Expected","SubDriver [SubDriver]")=strExpected
									DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult
				
 End Function

'======================================================END of Function================================================================

'===========================================Get Row number from Web Table============================================================

Public Function fnGetRowNum()
							'intRefNum="64"

								  Set WebBrowserDesc=Description.Create
										   WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
		
								  Set WebPageDesc=Description.Create
											WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
		
								  Set WebTableDesc=Description.Create
									       WebTableDesc("micClass").value="WebTable"
									       WebTableDesc("name").value="WebTable"
									        WebTableDesc("html tag").value="TABLE"


							       Set objWebTable=Browser(WebBrowserDesc).Page(WebPageDesc).Childobjects(WebTableDesc)
                                        
											  intRowCount=objWebTable(0).rowcount
										
										   For j=0 to intRowCount step 1
													if objWebTable(0).GetCellData(j,1)=intRefNum then
																	   intRowNum=j
                  											Exit for
													end if
											  Next  


End Function

'======================================================END of Function================================================================


'=========================================Get the Latest Row number from Web Table=====================================================

Public Function fnLatestGetRowNum()

			
										Set WebBrowserDesc=Description.Create
										WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
			
			
										Set WebPageDesc=Description.Create
										WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
			
									   Set WebTableDesc=Description.Create
										WebTableDesc("micClass").value="WebTable"
										WebTableDesc("html tag").value="TABLE"
										WebTableDesc("name").value="WebTable"
			
			
										Set objWebTable=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebTableDesc)
														  intRowCount=objWebTable(0).RowCount
			
														  intRowNum=2

End Function


'======================================================END of Function================================================================



 '========================================Get the Row number from Web Table in Global Admin Report========================================

Public Function  fnGetRowNumAdmin()

										Set WebBrowserDesc=Description.Create
										WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
			
			
										Set WebPageDesc=Description.Create
										WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
			
									   Set WebTableDesc=Description.Create
										WebTableDesc("micClass").value="WebTable"
										WebTableDesc("html tag").value="TABLE"
										WebTableDesc("name").value="WebTable"
			
									   Set objWebTable=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebTableDesc)
									   arrWtIndex=split(strParam,",")
									   intRowCount=objWebTable(arrWtIndex(0)).getroproperty("rows")
									   For j=1 to intRowCount step 1
											  if objWebTable(arrWtIndex(0)).GetCellData(j,2)=intRefNum then
															   intRowNum=j
										Exit for
												 end if
										Next  
End Function

'======================================================END of Function================================================================



'======================================================Verify DonorWall================================================================

Public Function fnVerifyDonorWall(strDonWall,strExpected)
									 If  Instr(Trim(strDonWall),Trim(strExpected))=1Then
													strResult="Pass"
									Else
													strResult="Fail"
									  End If
									  DataTable.Value("Actual","SubDriver [SubDriver]")=strDonWall
									  DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult

End Function

'======================================================END of Function================================================================


'======================================================Exist in DonorWall =============================================================

Public Function fnVerifyDonorWallNotExist(strDonWall,strExpected)
									If strDonWall=Mid(strActual,13) then
											  strResult="Fail"
									Else
												strResult="Pass"
									End If
									DataTable.Value("Actual","SubDriver [SubDriver]")=strDonWall
									DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult

End Function

'======================================================END of Function================================================================


'======================================================Verify NpoDetails in Disbursemnt  =================================================

Public Function fnWebTableOrgDetails(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint)

									  Set objWebTable=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebTableDesc)
									  arrWtIndex=split(strParam,",")
									  strActual=objWebTable(arrWtIndex(0)).getcelldata(arrWtIndex(1),arrWtIndex(2))
									  call fnVerifyProperty (strExpected,strActual,strChkPoint)

   End Function


'======================================================END of Function================================================================


'===========================================Calculate total donations amount  in Disbursement===============================================

Public Function fnGetTotalDonations(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint)

									  Set WebBrowserDesc=Description.Create
											   WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
			
									  Set WebPageDesc=Description.Create
											   WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
			
									   Set WebTableDesc=Description.Create
											   WebTableDesc("micClass").value="WebTable"
											   WebTableDesc("name").value="WebTable"
											   WebTableDesc("html tag").value="TABLE"
            			
										 arrWtIndex=split(strParam,",")
										 Set objWebTable=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebTableDesc)
										 GetTotAmt=0
			
										  For l=2 to objWebTable(arrWtIndex(0)).getroproperty("rows")-1 step 1
										  GetTotAmt=GetTotAmt+Cdbl(Mid(objWebTable(arrWtIndex(0)).getcelldata(l,arrWtIndex(1)),2))
									 
										Next
										   fnGetTotalDonations=GetTotAmt

   End Function


'======================================================END of Function================================================================


'=============================================Verfify total donations amount  in Disbursement===============================================

Public Function fnVerifyGetTotalDonations(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint)

									 Set WebBrowserDesc=Description.Create
											   WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
			
									  Set WebPageDesc=Description.Create
												WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
			
									  Set WebTableDesc=Description.Create
											  WebTableDesc("micClass").value="WebTable"
											  WebTableDesc("name").value="WebTable"
											  WebTableDesc("html tag").value="TABLE"
			
											arrWtIndex=split(strParam,",")
											Set objWebTable=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebTableDesc)
											GetTotAmt=0
											GetTotAmt=objWebTable(arrWtIndex(0)).getroproperty("rows") -2
											GetTotAmt = GetTotAmt  *intDonAmt
											fnVerifyGetTotalDonations=GetTotAmt

End Function

'======================================================END of Function================================================================


'===============================================Calculate total Adjustments / Refunds=====================================================

Public Function fnGetTotalAdjustments(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint) 

									 Set WebBrowserDesc=Description.Create
											   WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
			
									  Set WebPageDesc=Description.Create
												WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
			
										  Set WebTableDesc=Description.Create
										  WebTableDesc("micClass").value="WebTable"
										   WebTableDesc("name").value="WebTable"
										   WebTableDesc("html tag").value="TABLE"
            			
										arrWtIndex=split(strParam,",")
										Set objWebTable=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebTableDesc)
	
										GetTotAmt=0
    									 For l=2 to objWebTable(arrWtIndex(0)).getroproperty("rows")-1 step 1
												 If  Instr(objWebTable(arrWtIndex(0)).getcelldata(l,arrWtIndex(1)),"-")>0Then
														GetTotAmt=GetTotAmt-Cdbl(Mid(objWebTable(arrWtIndex(0)).getcelldata(l,arrWtIndex(1)),3))
												else
														GetTotAmt=GetTotAmt+Cdbl(Mid(objWebTable(arrWtIndex(0)).getcelldata(l,arrWtIndex(1)),2))
												End If
										 Next
										fnGetTotalAdjustments=GetTotAmt

   End Function


'======================================================END of Function================================================================


'================================================Calculate total  Disbursement Adjustments ================================================

Public Function fngettotaldisbursementadjustments(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint)

									 Set WebBrowserDesc=Description.Create
											  WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
			
									  Set WebPageDesc=Description.Create
											   WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
			
									  Set WebTableDesc=Description.Create
											   WebTableDesc("micClass").value="WebTable"
											   WebTableDesc("name").value="WebTable"
											   WebTableDesc("html tag").value="TABLE"
			
										 arrWtIndex=split(strParam,",")
			
										 Set objWebTable=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebTableDesc)
			
										GetTotAmt=0
			
										 For l=2 to objWebTable(arrWtIndex(0)).getroproperty("rows")-1 step 1
												If  instr(objWebTable(arrWtIndex(0)).getcelldata(l,arrWtIndex(1)),"-")>0 Then
													  GetTotAmt=GetTotAmt - Cdbl(Mid(objWebTable(arrWtIndex(0)).getcelldata(l,arrWtIndex(1)),3))
												else
													  GetTotAmt=GetTotAmt+Cdbl(Mid(objWebTable(arrWtIndex(0)).getcelldata(l,arrWtIndex(1)),2))
												End If
										Next
			
										fnGetTotalDisbursementAdjustments=GetTotAmt

End Function

'======================================================END of Function================================================================

'======================================================Verify Total Disbursemtnts =======================================================

Public Function fnVerifyDisbursementTotal(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint)

									 Set WebBrowserDesc=Description.Create
											  WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
			
									  Set WebPageDesc=Description.Create
											   WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
			
									  Set WebTableDesc=Description.Create
											  WebTableDesc("micClass").value="WebTable"
											   WebTableDesc("name").value="WebTable"
											   WebTableDesc("html tag").value="TABLE"
			
										arrWtIndex=split(strParam,",")
										Set objWebTable=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebTableDesc)
			
										GetTotAmt=0
            								   If Instr(objWebTable(arrWtIndex(0)).getcelldata(l,arrWtIndex(1)),"-")>0Then
														GetTotAmt=Cdbl(Mid(objWebTable(arrWtIndex(0)).getcelldata(1,arrWtIndex(1)),3))
												else
														GetTotAmt=Cdbl(Mid(objWebTable(arrWtIndex(0)).getcelldata(1,arrWtIndex(1)),2))
										   End If
            								fnVerifyDisbursementTotal=GetTotAmt

   End Function

'======================================================END of Function================================================================


'======================================================Set Tracking # in WebEdit box ====================================================================

Public Function fnSettingValue(WebBrowserDesc,WebPageDesc,WebEditDesc,strAction,strParam,strExpected,strChkPoint)

									Select Case strParam 
												Case "GetTrackingNo"
																Browser(WebBrowserDesc).Page(WebPageDesc).WebEdit(WebEditDesc).Set intRefNum
									End Select

End Function

'======================================================Support Functions==================================================================

Public function fnVerifyError(strExpected,strActual,strChkPoint)

								   If strExpected=strActual Then
												strResult="Pass"
									else
												strResult="Fail"	
									End If
									DataTable.Value("Actual","SubDriver [SubDriver]")=strResult
									DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult

End Function


'======================================================END of Function================================================================


'======================================================Does Property  exist===========================================================

Public function fnVerifyProperty (strExpected,strActual,strChkPoint)

									If trim(cstr(strExpected))=trim(cstr(strActual)) Then
												strResult="Pass"
									 else
												strResult="Fail"	
									End If
								
								   DataTable.Value("Actual","SubDriver [SubDriver]")=strActual
								   DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult

End Function


'======================================================END of Function================================================================

'======================================================Verify  if Property does not  exist======================================================

Public Function fnVerifyPropertyNotExist(strExpected,strActual,strChkpoint)

									 If instr(strActual,strExpected)>0 Then
											strResult="Fail"
									 else
											strResult="Pass"	
									End If
										DataTable.Value("Actual","SubDriver [SubDriver]")=strActual
										DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult

End Function


'======================================================END of Function================================================================


'======================================================VerifyPropertyFileName==========================================================

Public Function fnVerifyPropertyFileName(strExpected,strActual,strChkpoint)
	
									 If instr(strActual,strExpected)>0 Then
										strResult="Pass"
										else
										strResult="Fail"
									End If
									DataTable.Value("Actual","SubDriver [SubDriver]")=strActual
									DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult

End Function

'======================================================END of Function================================================================


'======================================================Does ObjectExist=============================================================================

Public function fnVerifyObjectExist (strExpected,strActual,strChkPoint)

								If  strActual.exist(5) Then
											strResult="Pass"
								else
											strResult="Fail"
								End If
								DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult

End Function

'======================================================END of Function================================================================


'======================================================Check for Object Not Exist=================================================================================

Public Function fnVerifyObjectNotExist(strExpected,strActual,strChkPoint)
	
									If Not strActual.exist(10) Then
												strResult="Pass"
									  Else
												  strResult="Fail"
									 End if   
									DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult

   End Function

'======================================================END of Function================================================================


'======================================================VerifyFileName in FB=============================================================================

Public Function fnVerifyPropertyFileName(strExpected,strActual,strChkpoint)

									 If instr(strActual,strExpected)>0 Then
													strResult="Pass"
									 else
													strResult="Fail"
									End If
									DataTable.Value("Actual","SubDriver [SubDriver]")=strActual
									DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult

End Function

'======================================================END of Function================================================================


'======================================================Check PageExist=========================================================================

Public function fnBrowserExists (WebBrowserDesc,WebPageDesc,strAction,strParam,strExpected,strChkPoint,strObjects)
								Select Case strObjects
			
											Case "Browser"
														If Browser(WebBrowserDesc).Page(WebPageDesc).Exist(10) then 
														strResult="Pass"
														DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult
			
														Else
														strResult="Fail"
														DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult
			
												End if
			
			
							   End Select
End Function

'======================================================END of Function================================================================


'======================================================Verify if Web Link Exist==============================================================================

Public function fnVerifyWebLink(strExpected,strActual,strChkPoint)
	
								   If strActual.exist Then
										strResult="Pass"
								   else
										strResult="Fail"
								   End If
								   Datatable.Value("PassFail","SubDriver[SubDriver]")=strResult

End function

'======================================================END of Function================================================================


'======================================================Verify if Web Link Not Exist===========================================================================

Public function fnVerifyWebLinkNotExist (strExpected,strActual,strChkPoint)	

									If Not strActual.exist Then
											strResult="Pass"
									   else
											strResult="Fail"
									   End If
									   Datatable.Value("PassFail","SubDriver[SubDriver]")=strResult
End Function

'======================================================END of Function================================================================


'======================================================Sleep Event===================================================================
Public function fnSleep(strAction,strParam)

									Select Case strAction 
		
													Case "Wait"
																	Wait (strParam)
									End Select
End Function

'======================================================END of Function================================================================

'==================================================Unselect all checkboxes from Marque page=============================================
Public Function fnUnSelectCheckBoxes(WebBrowserDesc,WebPageDesc,WebTableDesc,WebCheckBoxDesc,strParam)

									Set WebBrowserDesc=Description.Create
									WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
		
        							Set WebPageDesc=Description.Create
									WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
		
								   Set WebTableDesc=Description.Create
									WebTableDesc("micClass").value="WebTable"
									WebTableDesc("html tag").value="TABLE"
                                    		
									Set WebCheckBoxDesc=Description.Create
									WebCheckBoxDesc("micClass").value="WebCheckBox"
									WebCheckBoxDesc("type").value="checkbox"

									Set objCheckBox=Browser(WebBrowserDesc).Page(WebPageDesc).webtable(WebTableDesc).ChildObjects(WebCheckBoxDesc)
									intRowCount=objCheckBox.Count
						
									For j=0 to intRowCount-1 step 1
											 
												objCheckBox(j).Set strParam                                           													
									  Next  


End Function

'======================================================END of Function================================================================

'=============================================Select particular checkboxe from Marque page================================================

Public Function fnSelectParticularCheckBox(WebBrowserDesc,WebPageDesc,WebTableDesc,WebCheckBoxDesc,strParam)

												Set WebBrowserDesc=Description.Create
												WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
                    					
												Set WebPageDesc=Description.Create
												WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
					
											   Set WebTableDesc=Description.Create
												WebTableDesc("micClass").value="WebTable"
												WebTableDesc("class").value="image-table"
                                            					
												Set WebCheckBoxDesc=Description.Create
												WebCheckBoxDesc("micClass").value="WebCheckBox"
												WebCheckBoxDesc("type").value="checkbox"
												intRowCount=Browser(WebBrowserDesc).Page(WebPageDesc).WebTable(WebTableDesc).RowCount
								
    											 For j=1 to intRowCount step 1
														if Trim(Browser(WebBrowserDesc).Page(WebPageDesc).webtable(WebTableDesc).GetCellData(j,4))=Trim(strParam) then
																		   intRowNum=j
												Exit for
														end if
												  Next  
	
												Set objCheckBox=Browser(WebBrowserDesc).Page(WebPageDesc).WebTable(WebTableDesc).ChildObjects(WebCheckBoxDesc)
					
												objCheckBox(intRowNum-2).Set "ON"

End Function

'======================================================END of Function================================================================

'================================================Emails Checking=====================================================================

Public Function  fnSelectLatestCheckBox(WebBrowserDesc,WebPageDesc,WebTableDesc,WebCheckBoxDesc,strParam)

									Set WebBrowserDesc=Description.Create
									WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
		
									Set WebPageDesc=Description.Create
									WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
		
								   Set WebTableDesc=Description.Create
									WebTableDesc("micClass").value="WebTable"
									WebTableDesc("html tag").value="TABLE"
						
									Set WebCheckBoxDesc=Description.Create
									WebCheckBoxDesc("micClass").value="WebCheckBox"
									WebCheckBoxDesc("type").value="checkbox"
	
									intRowCount=Browser(WebBrowserDesc).Page(WebPageDesc).WebTable(WebTableDesc).GetROProperty("rows")
									intBig=0 
		
									 For j=2 to intRowCount Step 1
		
											  If intBig < Cint (Browser(WebBrowserDesc).Page(WebPageDesc).WebTable(WebTableDesc).GetCellData(j,2)) Then
				
											   intBig=Cint (Browser(WebBrowserDesc).Page(WebPageDesc).WebTable(WebTableDesc).GetCellData(j,2))
				
											 End if
	
									Next
							
								   For j=2 to intRowCount Step 1
						
											 If Cint(intBig) = Cint (Browser(WebBrowserDesc).Page(WebPageDesc).WebTable(WebTableDesc).GetCellData(j,2)) Then
						
												Exit For
						
											End If
									  
								 Next
	
							   Set objCheckBox=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebCheckBoxDesc)
								
								 objCheckBox( j - 1 ).Set strParam

End Function
'======================================================END of Function================================================================

'================================================Emails Checking=====================================================================

Public Function fnEmailsChecking()

										Select Case strAction

										'Check the ResetPassword
																Case "ResetPassWord"
																						set olapp = createobject("outlook.application") 
																						set inbox = olapp.getnamespace("mapi").folders 
																						
																						for each objparentfolder in inbox 
																						
																							getsubfolders(objparentfolder) 
																				
																						next 
                                                                                        												                                                          
															'Check the RazooMails
																	Case "EmailContentChecking"

																					set olapp = createobject("outlook.application") 
																					set inbox = olapp.getnamespace("mapi").folders 
													
																					Set MyExcel = createobject("Excel.application")
																					
																					 Set MyFile=myExcel.workbooks.open (Mid(strDataFileParam,1,12) &"\RazooExcel.xls")
																					
																					
																					arrstrParam=Split(strParam,",")

																					for each fold in inbox 
																						getsubfolders1(fold) 
																					next 
																					 MyExcel.ActiveWorkbook.Save
																					
																					myExcel.Quit
																					Set myExcel=Nothing	

                                                                    Case "FindAndReplace"
                                                                            																		
																			Set MyExcel=createobject("Excel.application")
																		
																			Set MyFile=myExcel.workbooks.open (Mid(strDataFileParam,1,12) &"\RazooExcel.xls")
																				arrstrParam=Split(strParam,",")
																			strW1=myFile.worksheets(arrstrParam(1)).Cells(2,1)
																	
																			If  arrstrParam(1)="ScheduleDonation" Then
                                                                            	Replacetest=Replace(strW1,"999999",dblVerifyTotal)
																			 ElseIf arrstrParam(1)="ResendReceipt" Then
																			 Replacetest=Replace(strW1,"999999",intRefNum)
																		
																			 End if
																			msgbox Replacetest
																			myFile.worksheets(arrstrParam(1)).Cells(2,1)=Replacetest
																			
																			myExcel.ActiveWorkbook.Save 
																			myExcel.Quit
																			 Set myExcel=Nothing

												End Select

End Function	

'======================================================END of Function================================================================

'================================================Read File Content=====================================================================


Public Function fnReadFileContent(strAction,strParam)
			Select Case strAction

			 'Open the File&read the File content
						   Case "DisbursementExport"
										   Set fso=createobject("scripting.filesystemobject")
										   set MyFile=fso.OpenTextFile(strParam,1)
							   While not MyFile.AtEndOfStream
										FileData=MyFile.ReadLine
										Check_No=split(FileData,",")
										CheckNo=Check_No(0)
										Org_Name=Check_No(6)
									
										Datatable.Value("Expected","SubDriver[SubDriver]")=CheckNo
								 Wend
			 End Select
End Function

'======================================================END of Function================================================================

'========================================Sub functions related to Reset password========================================================== 
Sub getunreadmails(objfolder) 
	
			set colValue = objfolder.items 
			for each mail in colValue 
			If mail.unread then 
				 strMailSub1=mail.subject
			  strMailSub2=split(strMailSub1,"-")

			  If instr(strMailSub1,strParam)>0 Then
			strMailBody1=mail.body
			strMailBody2=split(strMailBody1,"http://")
			strMailBody3=split(Trim(strMailBody2(1)),"edit")
			
			strResetUrl=Trim(strMailBody3(0))&"edit"
			mail.unread=false 
			End if
			end if 
			next 

End Sub


	
Sub getsubfolders(objparentfolder) 
													Set colfolders = objparentfolder.folders
												
													For each objfolder in colfolders 
												
														set objsubfolder = objparentfolder.folders(objfolder.name)
												
														if objfolder.name<>"notes" then 
															getunreadmails(objfolder) 
														end if 
														getsubfolders(objsubfolder)
													next 
End Sub

'======================================================END of Function================================================================

'=======================================Checking email content=========================================================================
   	
	Sub getunreadmails1(objfolder) 
					
													Set col = objfolder.items 
													For each mail in col 
													If mail.unread then 
														strMailSub1=mail.subject
														
													 
														If Instr(strMailSub1,arrstrParam(0))>0 Then
				
														strMailBody1=mail.body
														
				
												MyFile.worksheets(arrstrParam(1)).Cells(2, 2)= strMailBody1
				 
													If  MyFile.worksheets(arrstrParam(1)).Cells(2,1)= myFile.worksheets(arrstrParam(1)).Cells(2, 2) Then
														MyFile.worksheets(arrstrParam(1)).Cells(2,3).value="Pass"
														else
														'Msgbox "Fail"
														 MyFile.worksheets(arrstrParam(1)).Cells(2,3).value="Fail"
													End If
				
													mail.unread=false 
													End if
													end if 
													next 
	End Sub 

	
	Sub getsubfolders1(objparentfolder) 
												set colfolders = objparentfolder.folders
												
												For each objfolder in colfolders 
												
													set objsubfolder = objparentfolder.folders(objfolder.name)
													   
													if objfolder.name<>"notes" then 
														getunreadmails1 (objfolder) 
													end if 
													getsubfolders1(objsubfolder )
				
												next 
	End Sub


'=======================================================End Function=========================================================

'======================================================Fetching Total amount in the donation report===================================

Public Function fnTotal(strExpected)
													   strAmt1=split(strExpected,"$")

													   strAmt2=strAmt1(3)

													   strAmt3=split(strAmt2,".")

													   fnTotal=strAmt3(0) &"." &mid(strAmt3(1),1,2)
End Function

'=========================================================End Function============================================================

'=====================================================Send the Results to output window=================================================
Public Function fnResultsWindow(intPassCount,intFailCount,k)
									  k=k-1
									While (k>0)
									
										DataTable.SetCurrentRow(k)

												If DataTable.Value("PassFail","SubDriver [SubDriver]")="Pass" Then
													  intPassCount=intPassCount+1

												 ElseIf DataTable.Value("PassFail","SubDriver [SubDriver]")="Fail" Then
													  intFailCount=intFailCount+1

												  End if

												k=k-1
										   wend
											
											Reporter.ReportEvent micPass,"Passed",intPassCount

											If intFailCount>0 Then
												Reporter.ReportEvent micFail ,"Failed",intFailCount
												Parameter("strStatus")="Failed"
End If
End Function

'================================================================================================================================
Public Function fnCheckResults(intPass,intFail,k)
  								  k=k-1
									Do While (k>0)
										DataTable.SetCurrentRow(k)
												If DataTable.Value("PassFail","SubDriver [SubDriver]")="Pass" Then
															Myvalue=1
												 ElseIf DataTable.Value("PassFail","SubDriver [SubDriver]")="Fail" Then
															Myvalue=0
															Exit do
												  End if
												k=k-1
										Loop
End Function

'=========================================================End Function============================================================

Public Function fnGetTotal(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)

									Set WebBrowserDesc=Description.Create
											WebBrowserDesc("micClass").value="Browser"
											WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
									
									Set WebPageDesc=Description.Create
											WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"

									Set WebObjDesc=Description.Create
											WebObjDesc("micClass").value="WebElement"
											WebObjDesc("class").value="gutter"
											WebObjDesc("html tag").value="DIV"
									 Set objWebElement=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebObjDesc)
								
									 strExpected=objWebElement(strParam).getroproperty("innertext")

	fnGetTotal=strExpected
End Function


'==================================================Checking the Time Zone========================================================
'To get the Get Time Zone
Public function fnGetTimeZone(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint)

									Set WebObjDesc=Description.Create
											 WebObjDesc("micclass").value="WebElement"
											 WebObjDesc("html tag").value="H3"
					
									Set ObjWebElement=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebObjDesc)
									
											strGetTimeZone=ObjWebElement(0).getroproperty(strParam)
									
		fnGetTimeZone=strGetTimeZone			        			
End Function

Public Function fntime(strExpected)

									strTime1 = split(strGetTimeZone,"at")
				
									ampm = strTime1(1)
				
				
									If instr(ampm,"AM")>0 Then
											strTime2 = split(strTime1(1),"AM")
				
											else
											strTime2 = split(strTime1(1),"PM")
				
									End If
				
				
									TZDate=strTime2(0)
									TZDate=Cdate(TZDate)	
				
									strTime = DateAdd("h", -1, TZDate)
				
									strtime3=split(strTime,":00")
				
									If instr(ampm,"AM")>0 Then
											strtime4=strtime3(0) & " " & "AM"
				
									else
											strtime4=strtime3(0) & " " & "PM"
				
									End If
									strtime=strTime1(0)  & "at"  &  " " & strTime4 &  " " & "CT"

	fnTime = strTime
End Function
'========================================================End of Function=============================================================

 
' Recovery Scenario Functions
Public Function fnDetect_CloseJavaScriptError(WebBrowserDesc,Windowdesc,WebPageDesc,WebObjDesc,strParam)

	If Browser(WebBrowserDesc).Window(Windowdesc).Exist(2) Then
			strActual=Browser(WebBrowserDesc).Window(Windowdesc).Page(WebPageDesc).WebElement(WebObjDesc).GetROProperty(strParam)
			msgbox strActual
			DataTable.Value("Actual","SubDriver [SubDriver]")=strActual
			Browser(WebBrowserDesc).Window(Windowdesc).Page(WebPageDesc).WebButton("html tag:=BUTTON", "html id:= btnOK").Click
	End If

End Function

'Public Function CloseJavaScriptError()
' 
'If Window("regexpwndtitle:=Windows Internet Explorer").Exist(2) Then
' 
'Window("regexpwndtitle:=Windows Internet Explorer").Page("title:= Windows Internet Explorer").WebButton("html tag:=BUTTON", "html id:= btnOK").Click
' Error Text = window("regexpwndtitle:=Internet Explorer").Page("title:= Internet Explorer").WebElement("html tag:= DIV", "html id:= divDetails", "innertext:= Line.*").GetROProperty("innertext")
'
'msgbox(ErrorText)
'End If
' 
'End Function
 
