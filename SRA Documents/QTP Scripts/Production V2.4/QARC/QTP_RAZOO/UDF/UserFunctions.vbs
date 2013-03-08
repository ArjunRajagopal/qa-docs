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
Dim arrObjProperty,strObjProperty,strObjValue,strObjProp,strActual,strResult,intRowNum,intColNum,j,intRowCount,intColCount
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
Dim Replacetest,strW11,intGetFansCount
Dim Startdate1,Startdate,EndDate,NofDtoEnd,Startdate_Camp,StartDate_camp1
Dim objtotalLinks1,NPOName,objWebButton
Dim dblVerifyRefAmt,dblVerifyDisbAdjAmt,dblGetPBFee,dblVerifyPBFee
Dim intRefCardCode,strItemInWidget
Dim strParam,mySheet,Email,EINNo,EINNo1,EIN,EIN1,E1,TodaysDate,Yearonly,Monthonly,Dayonly,Monthonly1,Dayonly1, CurrentURL
Dim Cols_Count,colsno,Rows_Count,T2,B2
Dim CardCode,strTotal,FileName,att,StrSearchResult1, StrSearchResult2,intWsCount 

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
												'		 SystemUtil.Run "C:\Program Files\Internet Explorer\IEXPLORE.EXE", strParam
														SystemUtil.Run "C:\Program Files (x86)\Internet Explorer\IEXPLORE.EXE", strParam
														 Call fnBrowserExists(WebBrowserDesc,WebPageDesc,strAction,strParam,strExpected,strChkPoint,"Browser")
							'Check Page loaded
									  Case "CheckPageLoaded"
													Call fnBrowserExists (WebBrowserDesc,WebPageDesc,strAction,strParam,strExpected,strChkPoint,"Browser")
						
							'Enters valid card details
										Case "Donation"
													   Call fnCardDetails(strParam)

							' Enter Credit Card details in Purchasing a Gift Card  form
                                          Case "GuestDonation"	
											           Call fnGuestCardDetails(strParam)
						
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

								'ChangeTestdata	
											Case "SetTestdata"

														  Call fnExceltestdata()

							'Append to URL
							                  Case "AppendURL"
                                            			    CurrentURL =  Browser(WebBrowserDesc).Page(WebPageDesc).GetROProperty("url")
															StrExpected= CurrentURL& "/" & StrParam
                                        					Browser(WebBrowserDesc).Navigate StrExpected

						' Get the Current URL
                                               Case "GetUrl"
															strResetUrl =  Browser(WebBrowserDesc).Page(WebPageDesc).GetROProperty(strParam)
															DataTable.Value("Actual","SubDriver [SubDriver]")=strResetUrl

			         	'  VerifyURL
										      Case"VerifyURL"
														    strActual =  Browser(WebBrowserDesc).Page(WebPageDesc).GetROProperty(strParam)
   															DataTable.Value("Actual","SubDriver [SubDriver]")=strActual
															Call fnVerifyProperty(strExpected,strActual,strChkPoint)
								 
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
													 WebButtonDesc("micClassname").value="WebButton"
													 WebButtonDesc("name").value="Update"
													Browser(WebBrowserDesc).Page(WebPageDesc).WebEdit(WebEditDesc).Set strParam
													Browser(WebBrowserDesc).Page(WebPageDesc).WebButton(WebButtonDesc).Click



										 Case "GetDonateAmt"
														intDonAmt =Trim(Browser(WebBrowserDesc).Page(WebPageDesc).WebEdit(WebEditDesc).GetROProperty(strParam))
														DataTable.Value("Actual","SubDriver [SubDriver]")=intDonAmt

						'Verify  Button Code in the Share Page
												Case "VerifyPropertyForExist"
																strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebEdit(WebEditDesc).GetROProperty(strParam)
															    Call fnVerifyPropertyFileName(strExpected,strActual,strChkpoint)

						'Verify EditBox Not Exist
											   Case "VerifyObjectNotExist"
															 Set strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebEdit(WebEditDesc)
															 Call fnVerifyObjectNotExist(strExpected,strActual,strChkPoint)														

				'To setting the value in the CardCode
				                           Case "SetCardCode"
														Call fnSettingValue(WebBrowserDesc,WebPageDesc,WebEditDesc,strAction,strParam,strExpected,strChkPoint)
			  ' Checking the particular value in the Widget
                                            Case "VerifyPropertyForWidgetExist"
												          strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebEdit(WebEditDesc).GetROProperty(strParam)
														  DataTable.Value("Actual","SubDriver [SubDriver]")= strActual
														 Call fnVerifyPropertyForWidgetExist(WebBrowserDesc,WebPageDesc,WebEditDesc,strAction,strParam,strExpected,strChkPoint)
				

                 ' 	 Get the status widget code
										 Case "GetValue"
														strActual =Browser(WebBrowserDesc).Page(WebPageDesc).WebEdit(WebEditDesc).GetROProperty(strParam)
														DataTable.Value("Actual","SubDriver [SubDriver]")=strActual

               ' Setting the paritcular value in the Object Repository
                                        Case "SetPropertyValue"
       											        Browser(WebBrowserDesc).Page(WebPageDesc).WebEdit(WebEditDesc).SetTOProperty strParam, strExpected

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

						 ' Verify Hitler Image in User Profile Screen
												  Case "VerifyHitlerImage"
													             Call HitlerImageCheckPoint()

                             ' Verify Golden Cookie Image in User Profile Screen
												   Case "VerifyGoldenCookie"
																 Call GoldenCookieCheckPoint()

                             ' Verify Preview Theme Image in Giftcard Purchasing screen
													Case "VerifyPreviewImage"
														         Call ImagePreviewCheckPoint()

							  'Verify Sample Image in Theme creation page		
													Case "VerifySampleImage"
														      Call SampleThemeCheckPoint()

							' Verify Avatar Image in User Profile Screen
													Case "VerifyAvatar"
															Call AvatarCheckPoint()   

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
                           'Delete Orgadmin from Admin page
						                         Case "ClickDelete"
															   Call fnDeleteOrgAdmin(WebBrowserDesc,WebPageDesc,WebButtonDesc,strAction,strParam,strExpected,strChkPoint)
                          ' Click on button if button existed
                                                Case "IfClickButtonExists"
													           If  Browser(WebBrowserDesc).Page(WebPageDesc).WebButton(WebButtonDesc).Exist Then
																    Browser(WebBrowserDesc).Page(WebPageDesc).WebButton(WebButtonDesc).Click
															   End If
										

										
					 End Select
End Function

'======================================================END of Function================================================================



'=======================================================Event Related to WebElement====================================================

' This function involves all the EditBox  related actions that shall Set  the values into EditBox  to perform the task.

Public function fnElement(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
				 '	'Switch the relevant Action

						Select Case strAction
               'Check the Error Message
												Case "VerifyErrorMessage"
																strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebElement(WebObjDesc).GetROProperty(strParam)
                                                                Call fnVerifyProperty (strExpected,strActual,strChkPoint)

                'To check End date greater than Starting date in Campaign page creation
												Case "VerifyEnddateGtrStartdate"
														Set WebBrowserDesc=Description.Create
														'WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
                                                        'WebBrowserDesc("name").value="My Razoo Title modified END - Razoo"
														 WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
														Set WebPageDesc=Description.Create
														'WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
														'WebPageDesc("title").value="My Razoo Title modified END - Razoo"
														WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"

														Startdate1=Browser(WebBrowserDesc).Page(WebPageDesc).WebElement("class:=field","html tag:=DIV","height:=53","width:=120").GetROProperty("innertext")
														msgbox Startdate1
														Startdate=mid(Startdate1,1,10)
														msgbox Startdate
														Enddate=Browser(WebBrowserDesc).Page(WebPageDesc).Webedit("html id:=campaign_end_at","class:=hasDatepicker").GetROProperty("value")
														msgbox Enddate
														'Enddate = cdate(Enddate)
														'Startdate = cdate(Startdate)
														NofDtoEnd = datediff("d",Startdate,Enddate)				
														msgbox NofDtoEnd
														If  datediff("d",Startdate,Enddate)>0 Then
															DataTable.Value("Actual","SubDriver [SubDriver]") = NofDtoEnd & "Days Remaining"
														else
															DataTable.Value("Actual","SubDriver [SubDriver]") = "Start Date should not be greater than End date"
														End If

  						Case "VerifyDateExist"
														Set WebBrowserDesc=Description.Create
														'WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
                                                        WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
														Set WebPageDesc=Description.Create
														'WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
														WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"

														Set WebObjDesc=Description.Create
														WebObjDesc("micClass").value="WebElement"
														WebObjDesc("class").value="field"
														WebObjDesc("html tag").value="DIV"

														Set StartDate_camp=Browser(WebBrowserDesc).Page(WebPageDesc).Childobjects(WebObjDesc)
														StartDate_camp1=StartDate_camp(4).GetROProperty(strParam)
														DataTable.Value("Actual","SubDriver [SubDriver]")=StartDate_camp1
														If strExpected=strActual Then
																			strResult="Pass"
																Else
																			strResult="Fail"
																End If
														DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult
                                                          
											
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
															 strExpected= fnGetTotal1(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
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
															 strExpected= fnGetTotal1(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
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
															 strExpected= fnGetTotal1(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
															 strRaised1=Split(strExpected,"Fundraiser")
                                                              intGetFundRaisersCount=Cint(strRaised1(0))
															 DataTable.Value("Actual","SubDriver [SubDriver]")= intGetFundraisersCount

            'Verify Fundraisers Count in campaign Story page
											Case"VerifyFundraisersCount"
															strExpected= fnGetTotal1(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
															 strRaised1=Split(strExpected,"Fundraiser")
															 intVerifyFundRaisersCount=Cint(strRaised1(0))
															 DataTable.Value("Actual","SubDriver [SubDriver]")= intVerifyFundRaisersCount
                                                             DataTable.Value("Expected","SubDriver [SubDriver]")=intGetFundRaisersCount+1
															Call fnVerifyProperty (intGetFundRaisersCount+1,intVerifyFundRaisersCount,strChkPoint)
														
           ' Verify  Fundraisers Count not increased in Campaign story page
												 Case "VerifyFundraisersCountNotIncreased"
															 strExpected= fnGetTotal1(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
															 strRaised1=Split(strExpected,"Fundraiser")
															 intVerifyFundRaisersCount=Cint(strRaised1(0))
															 DataTable.Value("Actual","SubDriver [SubDriver]")=intVerifyFundRaisersCount
															 DataTable.Value("Expected","SubDriver [SubDriver]")=intGetFundRaisersCount
															Call fnVerifyProperty (intGetFundRaisersCount,intVerifyFundRaisersCount,strChkPoint)

              'Get  Disbursement  Total  Amount 
												Case "GetDisbursementTotalAmount"
															  strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebElement(WebObjDesc).GetROProperty(strParam)
															   DataTable.Value("Actual","SubDriver [SubDriver]")= strActual

              'Get  Number of  Disbursement 's 
												  Case "GetNumberOfDisbursements"
																 strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebElement(WebObjDesc).GetROProperty(strParam)
																 DataTable.Value("Actual","SubDriver [SubDriver]")= strActual

			' Get Fans count from header			
												Case "GetFansCount"
															strExpected= fnGetTotal1(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
															 strRaised1=Split(strExpected,"Fan")
															intGetFansCount=Cint(strRaised1(0))
															 DataTable.Value("Actual","SubDriver [SubDriver]")=intGetFansCount

				'GetCmapignTime
										Case "GetCampaignTime"
														strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebElement(WebObjDesc).GetROProperty(strParam)
														DataTable.Value("Actual","SubDriver [SubDriver]")=strActual

			 'Checking the Web Element  not exist
											   Case "VerifyObjectNotExist"
															  Set strActual=Browser(WebBrowserDesc).page(WebPageDesc).WebElement(WebObjDesc)
															   Call fnVerifyObjectNotExist (strExpected,strActual,strChkPoint)
      

               ' Setting the paritcular value in the Object Repository
                                        Case "SetValue"
											        Browser(WebBrowserDesc).Page(WebPageDesc).WebElement(WebObjDesc).SetTOProperty strParam, strExpected

				' Verify Date Format in User profile
				                        Case "VerifyDateFormat"
											           StrActual=Browser(WebBrowserDesc).page(WebPageDesc).WebElement(WebObjDesc).GetROProperty(strParam)
													   strExpected=mid(monthname(month(now)),1) &" " &day(now) &", "&year(now)
													   DataTable.Value("Actual","SubDriver [SubDriver]")=strActual
													   DataTable.Value("Expected","SubDriver [SubDriver]")=strExpected
													   Call fnVerifyPropertyFileName(strExpected,strActual,strChkpoint)

					' Get Gift Card code from Thank you screen
										Case "GetCardCode"
														   CardCode=Browser(WebBrowserDesc).page(WebPageDesc).WebElement(WebObjDesc).GetROProperty(strParam)
														   intRefCardCode=Trim(Right(CardCode,20))
														   DataTable.Value("Actual","SubDriver [SubDriver]")=trim(intRefCardCode)

                     ' Get Total donation From user profile
										   Case "GetTotalDonatedAmt"
											              strActual=fnGetTotalDonated(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)															
											              DataTable.Value("Actual","SubDriver [SubDriver]")=strActual
														  dblGetTotal=strActual

                       ' Verify the Total donations after donation is happened
										   Case "VerifyTotalDonatedAmt"
											              strActual=fnGetTotalDonated(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)															
											              DataTable.Value("Actual","SubDriver [SubDriver]")=strActual
														  strExpected=dblGetTotal+25
														  Call fnVerifyProperty (strExpected,strActual,strChkPoint)

					' Verify Whether view receipt is tax decutible or not and Verify view receipt is contains Gift Card code
										Case "VerifyPropertyForGiftCard"
												
														strActual=Browser(WebBrowserDesc).page(WebPageDesc).WebElement(WebObjDesc).GetROProperty(strParam)
   													    DataTable.Value("Expected","SubDriver [SubDriver]")=intRefCardCode
														strActual=Mid(strActual,650)
													    Call fnVerifyPropertyFileName(intRefCardCode,strActual,strChkpoint)

                   ' Verfiy Story Title length
                                         Case "VerifyTitleLength"
											             strActual=Browser(WebBrowserDesc).page(WebPageDesc).WebElement(WebObjDesc).GetROProperty(strParam)
														 strActual=len(strActual)
														 Call fnVerifyProperty (strExpected,strActual,strChkPoint)

					'Verify Search results in search screen
                                       Case "VerifySearchResults"
										              strActual=Browser(WebBrowserDesc).page(WebPageDesc).WebElement(WebObjDesc).GetROProperty(strParam)
													  DataTable.Value("Actual","SubDriver [SubDriver]")= strActual
													  DataTable.Value("Expected","SubDriver [SubDriver]")=StrSearchResult2(2)
                                                      strExpected=StrSearchResult2(2)
										              Call fnVerifyPropertyFileName(strExpected,strActual,strChkpoint)

					'To Verify the content of Hack urls
										Case "VerifyPropertyForHackUrlExist"
														strActual=Browser(WebBrowserDesc).page(WebPageDesc).WebElement(WebObjDesc).GetROProperty(strParam)
														Call fnVerifyPropertyForHackUrlExist()


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

					'To Click Link if it exists
												Case "ClickLinkifExists"											
		
															If  Browser(WebBrowserDesc).Page(WebPageDesc).Link(WebLinkDesc).Exist(5) Then
																Browser(WebBrowserDesc).Page(WebPageDesc).Link(WebLinkDesc).Click				
                                                    		End if

						'Get the number count on link (See all fundraisers) in Org story page 
                                                 Case "GetSearchResults"
													        	StrSearchResult1=Browser(WebBrowserDesc).Page(WebPageDesc).Link(WebLinkDesc).GetROProperty(strParam)
																StrSearchResult2=split(StrSearchResult1," ")
																DataTable.Value("Actual","SubDriver [SubDriver]")=StrSearchResult2(2)

					 'Get  Id for Giving Event Schedule donation in user profile
													Case "GetIdForGivingEventDonation"
	                                                          objLink=Browser(WebBrowserDesc).Page(WebPageDesc).Link(WebLinkDesc).GetROProperty("url")
															  strActual=split(objLink,"donations")
															  DataTable.Value("Actual","SubDriver [SubDriver]")=strActual(1)
															  strResetUrl=strparam &strActual(1)

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

               'Checking  the specified value in the list box
												Case "VerifyPropertyForExist"
																strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebList(WebListDesc).GetROProperty(strParam)
															    Call fnVerifyPropertyFileName(strExpected,strActual,strChkpoint)
										
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

							  'Select Ten CheckBoxes in Marquees
												Case "SelectTenCheckBoxes"
																 Call fnSelectTenCheckBoxes(WebBrowserDesc,WebPageDesc,WebTableDesc,WebCheckBoxDesc,strParam)

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
												                   	 intColCount=objWebTable(0).getroproperty("cols")
																					 For j=0 to intColCount step 1
																							 if objWebTable(0).GetCellData(1,j)=Trim(strParam) then
																								 intColNum=j
																								Exit for
																							end if
																					Next  
																	strActual=objWebTable(0).GetCellData(intRowNum,intColNum)
																	Call  fnVerifyProperty (strExpected,strActual,strChkPoint)
                                                                    
					'Get the Row number from WebTable
													Case "GetRowNum"
																	Call  fnGetRowNum()

					' Getting the Row Num
													Case "GetRowNumAdmin"
													Call fnGetRowNumAdmin()  

						'Check  Donor Name
                                                   Case "VerifyDnameGlobal"
																		 intColCount=objWebTable(arrWtIndex(0)).getroproperty("cols")
																		 arrWtIndex=split(strParam,",")
																				 For j=1 to intColCount step 1
																						 if objWebTable(arrWtIndex(0)).GetCellData(1,j)=Trim(arrWtIndex(1)) then
																							 intColNum=j
																							Exit for
																						end if
																					 Next

																	  strActual=objWebTable(arrWtIndex(0)).GetCellData(intRowNum,intColNum)
																	  Call  fnVerifyProperty (strExpected,strActual,strChkPoint)

						'Check  Donate anywhere Details 
                                                   Case "VerifyDnameGlobalDware"
                                                        			  Call fnGetRowNumAdmin1()  
																	  strActual=objWebTable(arrWtIndex(0)).GetCellData(intRowNum,intColNum)
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
																				intColCount=objWebTable(0).getroproperty("cols")
																						 For j=0 to intColCount step 1
																							 if objWebTable(0).GetCellData(1,j)=Trim(strParam) then
																								 intColNum=j
																									Exit for
																								end if
																						Next  
   																	    strActual=objWebTable(0).GetCellData(intRowNum,intColNum)
																	    Call  fnVerifyProperty (strExpected,strActual,strChkPoint)

							'Get DonatedAmount
														Case "GetDonateAmt"
																		Call fnLatestGetRowNum()  
																		 intColCount=objWebTable(0).getroproperty("cols")
																				 For j=0 to intColCount step 1
																						 if objWebTable(0).GetCellData(1,j)=Trim(strParam) then
																							 intColNum=j
																							Exit for
																						end if
																					 Next

																	  strActual=objWebTable(0).GetCellData(intRowNum,intColNum)
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
								'										WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
																		WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"		
								'			
																		Set WebPageDesc=Description.Create
																		'WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
																		WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"

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
								'										WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
																		WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"		
								'			
																		Set WebPageDesc=Description.Create
																		'WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
																		WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"
															
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
								'										WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
																		WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"		
								'			
																		Set WebPageDesc=Description.Create
																		'WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
																		WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"
														
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
								'										WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
																		WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"		
								'			
																		Set WebPageDesc=Description.Create
																		'WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
																		WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"
													
													Set WebTableDesc=Description.Create
															WebTableDesc("micClass").value="WebTable"
															WebTableDesc("name").value="Processing Fees"
															WebTableDesc("html tag").value="TABLE"
															strActual=browser(WebBrowserDesc).Page(WebPageDesc).WebTable(WebTableDesc).GetCellData(4,3)
															DataTable.Value("Actual","SubDriver [SubDriver]")=strActual

 'Getting latest tracking number
                                          Case"GetTrackingNumber"
														Call fnLatestGetRowNum()  
														 strActual=objWebTable(0).GetCellData(2,1)
														DataTable.Value("Actual","SubDriver [SubDriver]")=strActual
														intRefNum=Trim(Cstr(strActual))


					'Getting latest tracking number from Givemn site in donations report
													Case "GetTrackingNumberGivemn"
																			Call fnLatestGetRowNumGivemn()  
																			strActual=objWebTable(0).GetCellData(2,1)
																			DataTable.Value("Actual","SubDriver [SubDriver]")=strActual
																			intRefNum=Trim(cstr(strActual))


                      '  Verify the particular cell data in the table
										Case "VerifyCellData"
											        arrstrParam=split(strParam,",")
                                                    strActual=browser(WebBrowserDesc).Page(WebPageDesc).WebTable(WebTableDesc).GetCellData(arrstrParam(0),arrstrParam(1))
											    	Call fnVerifyProperty(strExpected,strActual,strChkPoint)

                      '  Get the particular cell data value in the table
										Case "GetCellData"
											        arrstrParam=split(strParam,",")
                                                    strActual=browser(WebBrowserDesc).Page(WebPageDesc).WebTable(WebTableDesc).GetCellData(arrstrParam(0),arrstrParam(1))
													DataTable.Value("Actual","SubDriver [SubDriver]")=strActual		


  'GetTotal Donations
                										Case "GetTotDonations"
                                                                       dblGetDisbAmt=Cdbl(fngettotaldonations(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint) )
																		DataTable.Value("Expected","SubDriver [SubDriver]")=dblGetDisbAmt
				
				        'Verify Total Donations
														Case "VerifyTotDonations"
																	   DataTable.Value("Expected","SubDriver [SubDriver]")=dblGetDisbAmt
																		dblVerifyTotDonAmt=Cdbl(fnverifygettotdonations(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint) )
																		DataTable.Value("Actual","SubDriver [SubDriver]")=dblVerifyTotDonAmt
																		Call  fnVerifyProperty (dblVerifyTotDonAmt,dblGetDisbAmt,strChkPoint)
										
						'Refunds
														Case "GetTotAdjustments" 
																	   dblGetRefAmt=Cdbl(fngettotaladjustments(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint))
																		DataTable.Value("Expected","SubDriver [SubDriver]")=dblGetRefAmt

														Case "VerifyTotAdjustments"
																	DataTable.Value("Expected","SubDriver [SubDriver]")=dblGetRefAmt
                                                                    dblVerifyRefAmt=fnVerifyGetTotAdjustments(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint) 
																	DataTable.Value("Actual","SubDriver [SubDriver]")=dblVerifyRefAmt
																	Call  fnVerifyProperty (dblGetRefAmt,dblVerifyRefAmt,strChkPoint)

						'Total Disbursement  Adjustments
												
														 Case "GetTotDisbursementAdjustments"
																	   dblGetDisbAdjAmt=Cdbl(fngettotaldisbursementadjustments(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint))
																		DataTable.Value("Expected","SubDriver [SubDriver]")=dblGetDisbAdjAmt


														 Case "VerifyTotDisbursementAdjustments"
																	   DataTable.Value("Expected","SubDriver [SubDriver]")=dblGetDisbAdjAmt
																     dblVerifyDisbAdjAmt=fnVerifygettotdisbursementadjustments(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint)
																		 DataTable.Value("Actual","SubDriver [SubDriver]")= dblVerifyDisbAdjAmt
																		 	Call  fnVerifyProperty (dblGetDisbAdjAmt,dblVerifyDisbAdjAmt,strChkPoint)


'                                                     
													    Case "GetPBFee"
																		dblGetPBFee=fnGetPBFee(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint) 
																		  DataTable.Value("Expected","SubDriver [SubDriver]")=	dblGetPBFee


														  Case "VerifyPBFee"
															              DataTable.Value("Expected","SubDriver [SubDriver]")=	dblGetPBFee
																		  dblVerifyPBFee=fnVerifyGetPBFee(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint) 
                                                                           DataTable.Value("Actual","SubDriver [SubDriver]")=	 dblVerifyPBFee       

						'Verify Disbursement Total

														 Case "VerifyDisbursementTot"
																	   dblVerifyDisbTot=fnverifydisbursementtot(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint)
																	   strActual=dblVerifyDisbTot
																		DataTable.Value("Actual","SubDriver [SubDriver]")=strActual
																	   strExpected = dblGetDisbAmt + dblGetRefAmt + dblGetDisbAdjAmt + dblGetPBFee
																	   DataTable.Value("Expected","SubDriver [SubDriver]")=strExpected
																	   Call fnVerifyProperty (strExpected,strActual,strChkPoint)


					'Getting CardCode from WebTable
												  	Case"GetCardCode"
																	Call fnLatestGetRowNum() 
																	arrstrParam=Split(strParam,",") 
																	strActual=objWebTable(0).GetCellData(arrstrParam(0),arrstrParam(1))
																	DataTable.Value("Actual","SubDriver [SubDriver]")=strActual
																	 intRefCardCode=strActual	


						'Check  Donor Name in Givemn site
                                                   Case "VerifyDnameGlobalGivemn"
                                                        			  Call fnGetRowNumAdminGivemn()  
																	  strActual=objWebTable(arrWtIndex(0)).GetCellData(intRowNum,intColNum)
																	  Call  fnVerifyProperty (strExpected,strActual,strChkPoint)	


						' Get the new tracking number from Org donation report in New Domain
                                                      Case "GetNewTrackingNumber"
																	arrstrParam=Split(strParam,",") 
														            strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebTable(WebTableDesc).GetCellData(arrstrParam(0),arrstrParam(1))
																	intRefNum=strActual 	
																    DataTable.Value("Actual","SubDriver [SubDriver]")=strActual 	

              ' Verifying the Gift Card table in application
											      Case "VerifyGiftCardTable"
													             intColNum=fnGetGiftCardColumnNum(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint)

															      strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebTable(WebTableDesc).GetCellData(2,intColNum)
																  Call  fnVerifyProperty (strExpected,strActual,strChkPoint)				

                    'Get disbursement data from disbursement table
												Case "GetDisbData"
																   arrstrParam=Split(strParam,",")
																   Cols=Browser(WebBrowserDesc).Page(WebPageDesc).WebTable(WebTableDesc).GetROProperty("cols")
																   strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebTable(WebTableDesc).GetCellData(Cols,arrstrParam(0))
																   DataTable.Value("Actual","SubDriver[SubDriver]")=strActual

					 'Get  Number of Rows  from Doantion(ORG) Report
											  Case "GetNumberOfRecordsInDonationReport"
														   strActual=Browser(WebBrowserDesc).Page(WebPageDesc).WebTable(WebTableDesc).GetROProperty("rows")-1
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

								If  Browser(WebBrowserDesc).Page(WebPageDesc).WebCheckBox(WebCheckBoxDesc).Exist(1) Then
									Browser(WebBrowserDesc).Page(WebPageDesc).WebCheckBox(WebCheckBoxDesc).Set arrSignUp(6)
								End If
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
									'Browser("Receipt").Page("An inspiring place to_3").WebEdit("donation_transactiond_donation_amount").Set arrstrParam_Don(0)
									intDonAmt=Browser("An inspiring place to").Page("An inspiring place to").WebEdit("donation_transactiond_donation_amount").GetROProperty("value")
									'intDonAmt=arrstrParam_Don(0)
									Browser("An inspiring place to").Page("An inspiring place to").WebEdit("order_user_name_on_card").Set arrstrParam_Don(0)
									Browser("An inspiring place to").Page("An inspiring place to").WebEdit("order_user_order[address1]").Set arrstrParam_Don(1)
									Browser("An inspiring place to").Page("An inspiring place to").WebEdit("order_user_order[city]").Set arrstrParam_Don(2)
									'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("order_user_order[state]").Set arrstrParam_Don(3)
									Browser("An inspiring place to").Page("An inspiring place to").WebList("order_user_order[state]").Select arrstrParam_Don(3)
									Browser("An inspiring place to").Page("An inspiring place to").WebEdit("order_user_order[postalcode]").Set arrstrParam_Don(4)
									Browser("An inspiring place to").Page("An inspiring place to").WebList("order_user_order[country]").Select arrstrParam_Don(5)
									Browser("An inspiring place to").Page("An inspiring place to").WebEdit("order_user_order[card_number]").Set arrstrParam_Don(6)
									Browser("An inspiring place to").Page("An inspiring place to").WebList("order_user_order[expire_month]").Select arrstrParam_Don(7)
									Browser("An inspiring place to").Page("An inspiring place to").WebList("order_user_order[expire_year]").Select arrstrParam_Don(8)
									Browser("An inspiring place to").Page("An inspiring place to").WebEdit("order_user_order[security_code]").Set arrstrParam_Don(9)

									Browser("An inspiring place to").Page("An inspiring place to").webCheckBox("Widget_Donation Form_Terms").Set "ON"

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
								'										WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
																		WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"		
								'			
																		Set WebPageDesc=Description.Create
																		'WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
																		WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"

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



'======================================================GetChampaignGoal &Date======================================================

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
						'	intRefNum="301353"

																		Set WebBrowserDesc=Description.Create
								'										WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
																		WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"		
								'			
																		Set WebPageDesc=Description.Create
																		'WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
																		WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"
		
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
'										WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
										WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"		
'			
										Set WebPageDesc=Description.Create
										'WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
										WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
									   Set WebTableDesc=Description.Create
										WebTableDesc("micClass").value="WebTable"
										WebTableDesc("html tag").value="TABLE"
										WebTableDesc("name").value="WebTable"
			
			
										Set objWebTable=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebTableDesc)
														  intRowCount=objWebTable(0).RowCount
			
														  intRowNum=2

End Function


'======================================================END of Function================================================================


'====================================================Start function=====================================================================
Public Function fnLatestGetRowNumGivemn()

			
										Set WebBrowserDesc=Description.Create
									'	WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
										WebBrowserDesc("name").value="The online destination for individuals and nonprofit organizations creating change in Minnesota - GiveMN"
			
										Set WebPageDesc=Description.Create
										'WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
										WebPageDesc("title").value="The online destination for individuals and nonprofit organizations creating change in Minnesota - GiveMN"
			
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
'intRefNum="79"
																		Set WebBrowserDesc=Description.Create
								'										WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
																		WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"		
								'			
																		Set WebPageDesc=Description.Create
																		'WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
																		WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
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


 '========================================Get the Row number from Web Table in Global Admin Report========================================

Public Function  fnGetRowNumAdmin1()

										Set WebBrowserDesc=Description.Create
										'WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
										WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
			
										Set WebPageDesc=Description.Create
										'WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
										WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
									   Set WebTableDesc=Description.Create
										WebTableDesc("micClass").value="WebTable"
										WebTableDesc("html tag").value="TABLE"
										WebTableDesc("name").value="WebTable"
			
									   Set objWebTable=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebTableDesc)
									   arrWtIndex=split(strParam,",")
									   intRowCount=objWebTable(arrWtIndex(0)).getroproperty("rows")
									   For j=1 to intRowCount step 1
											  if objWebTable(arrWtIndex(0)).GetCellData(j,2)=intRefNum then
															   intRowNum=j+1
										Exit for
												 end if
										Next  

									 arrWtIndex=Split(strParam,",")
									 intColCount=objWebTable(arrWtIndex(0)).getroproperty("cols")
												 For j=1 to intColCount step 1
														 if objWebTable(arrWtIndex(0)).GetCellData(1,j)=Trim(arrWtIndex(1)) then
															 intColNum=j
															Exit for
														end if
													 Next

End Function

'======================================================END of Function================================================================


'======================================================Verify DonorWall================================================================

Public Function fnVerifyDonorWall(strDonWall,strExpected)
									 If  Instr(Trim(strDonWall),Trim(strExpected))>0Then
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
								'										WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
																		WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"		
								'			
																		Set WebPageDesc=Description.Create
																		'WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
																		WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
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
								'										WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
																		WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"		
								'			
																		Set WebPageDesc=Description.Create
																		'WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
																		WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"

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
								'										WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
																		WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"		
								'			
																		Set WebPageDesc=Description.Create
																		'WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
																		WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
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
								'										WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
																		WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"		
								'			
																		Set WebPageDesc=Description.Create
																		'WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
																		WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
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
								'										WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
																		WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"		
								'			
																		Set WebPageDesc=Description.Create
																		'WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
																		WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
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

												Case "GetCardCode"
																Browser(WebBrowserDesc).Page(WebPageDesc).WebEdit(WebEditDesc).Set intRefCardCode


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
								'										WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
																		WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"		
								'			
																		Set WebPageDesc=Description.Create
																		'WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
																		WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"
		
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
								'										WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
																		WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"		
								'			
																		Set WebPageDesc=Description.Create
																		'WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
																		WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"
					
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
								'										WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
																		WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"		
								'			
																		Set WebPageDesc=Description.Create
																		'WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
																		WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"
		
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
								
								 ' objCheckBox( j - 1 ).Set strParam

								   objCheckBox( j + 1  ).Set strParam

End Function
'======================================================END of Function================================================================

'================================================Emails Checking=====================================================================

Public Function fnEmailsChecking()

										Select Case strAction

										'Check the ResetPassword
																Case "ResetPassWord"
																						set olapp = createobject("outlook.application") 
																						set inbox = olapp.getnamespace("mapi").folders 

																						On Error Resume next
																						for each objparentfolder in inbox 
																						
																							getsubfolders(objparentfolder) 
																				
																						next 
																						On Error Goto 0
                                                                                        												                                                          
															'Check the RazooMails
																	Case "EmailContentChecking"

																					set olapp = createobject("outlook.application") 
																					set inbox = olapp.getnamespace("mapi").folders 
													
																					Set MyExcel = createobject("Excel.application")
																					
																					 Set MyFile=myExcel.workbooks.open (Mid(strDataFileParam,1,12) &"\RazooExcel.xls")
																					
																					
																					arrstrParam=Split(strParam,",")

																		        	On Error Resume next
																					for each fold in inbox 
																						getsubfolders1(fold) 
																					next 
																					 MyExcel.ActiveWorkbook.Save
																					
																					myExcel.Quit
																					Set myExcel=Nothing	
																					 On Error Goto 0

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



                                                    Case "ReadAllMails"
																					set olapp = createobject("outlook.application") 
																					set inbox = olapp.getnamespace("mapi").folders 

																					For each fold in inbox 
																						getsubfolders2(fold) 
																					next 

                                    'Checking the Designation in the Email
													Case "VerifyEmailDesigExist"
																						set olapp = createobject("outlook.application") 
																						set inbox = olapp.getnamespace("mapi").folders 
																						strResult=""
																						On Error Resume next
																						For each objparentfolder in inbox 
																						
																							getsubfolders3(objparentfolder) 
																				
																						Next 
																				       On Error Goto 0


                                    'Checking the Designation in the Email not Exist
													Case "VerifyEmailDesigNotExist"
																						set olapp = createobject("outlook.application") 
																						set inbox = olapp.getnamespace("mapi").folders 
																						strResult=""
																						On Error Resume next
																						For each objparentfolder in inbox 
																						
																							getsubfolders4(objparentfolder) 
																				
																						Next 
																					 On Error Goto 0


							'	Getting Url from the ORG Request  and Updation in RazooExcel Document
													Case "GetTheOrgRequestUrl"

																						set olapp = createobject("outlook.application") 
																						set inbox = olapp.getnamespace("mapi").folders 

																						arrstrParam=Split(strParam,",")
																						On Error Resume next
																						for each objparentfolder in inbox 
																						
																							getsubfolders5(objparentfolder) 
																				
																						next 
																					   On Error Goto 0

                                                        Case"VerifyReportColumns"
																				call fnVerifyReportColumns()

														 Case"VerifyReportValues"
																				call fnVerifyReportValues()


						'Get  the Bulk Disbursement Url from Email
														Case "GetBulkDisbursementUrl"
																					  On Error Resume Next
															 							set olapp = createobject("outlook.application") 
																						set inbox = olapp.getnamespace("mapi").folders 
																						
																						for each objparentfolder in inbox 
																						
																							getsubfolders6(objparentfolder) 
																				
																						next 
																						On Error Goto 0

							' Verify the Org name in the Export Disbursement
													Case "VerifyDisbursementName"
														           Call fnVerifyDisbursementName()


                            ' Verify ORG Donation Report
                                                    Case" VerifyOrgDonationReport"
																    call fnVerifyOrgDonationReport()

													Case "SendClick"
																   Call  fnSendEmail()

												'Verify specified content in Razoo Excel
													 Case "SpecifiedContentInEmailChecking"

																					Set MyExcel = createobject("Excel.application")
																					
																					 Set MyFile=myExcel.workbooks.open (Mid(strDataFileParam,1,12) &"\RazooExcel.xls")

																				   arrstrParam=split(strParam,";")

     																				  Set Mysheet=Myfile.Worksheets(arrstrParam(0))
																					  strActual=mysheet.cells(2,2)

																					  If instr(strActual,arrstrParam(1))>0 Then
                                                                                          	strResult="Pass"
																							   else
																									strResult="Fail"
																						  End If

																							   DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult
                                             
																					MyFile.Close
																					MyExcel.Quit
																					Set MyExcel=nothing


                                   'To Save PDF /any attachment in Local System
												Case "DownloadGiftCardAttachement"
												
																		set olapp = createobject("outlook.application") 
                                                                         set inbox = olapp.getnamespace("mapi").folders 
                                                                         for each fold in inbox 
                                                                         getsubfolders7(fold) 
                                                                         next 


													Case "Get2011GivingStatementUrl"

																					 Set MyExcel = createobject("Excel.application")
																					
																					 Set MyFile=myExcel.workbooks.open (Mid(strDataFileParam,1,12) &"\RazooExcel.xls")
																					
                                                         							strMailBody1=	MyFile.worksheets(strParam).Cells(2, 2)

																	    	         msgbox strMailbody1
				 
													                                 strMailbody2=split(strMailbody1,"http://")
													
                                                									 strMailbody3=split(strMailbody2(2),"/2011")

																					strResetUrl=strMailbody3(0) &"/2011"
																					msgbox strResetUrl
													
  																					myExcel.Quit
																					Set myExcel=Nothing	



								'Verify Email Content Presented
													Case "VerifyEmailContentPresented"
																			Call fnVerifyEmailContentPresented()


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



	Sub getunreadmails2(objfolder) 
					
													Set col = objfolder.items 
													For each mail in col 
													If mail.unread then 
														strMailSub1=mail.subject
                                                		strMailBody1=mail.body
														mail.unread=false 
													End if
												
													next 
	End Sub 

	
	Sub getsubfolders2(objparentfolder) 
												set colfolders = objparentfolder.folders
												
												For each objfolder in colfolders 
												
													set objsubfolder = objparentfolder.folders(objfolder.name)
													   
													if objfolder.name<>"notes" then 
														getunreadmails2 (objfolder) 
													end if 
													getsubfolders2(objsubfolder )
				
												next 
	End Sub

'=======================================================End Function=========================================================



'=============================================Sub function for  Reading the designatio in the email============================================
Sub getunreadmails3(objfolder) 
	
			set colValue = objfolder.items 
			for each mail in colValue 
			If mail.unread then 
				 strMailSub1=mail.subject
			  strMailSub2=split(strMailSub1,"-")
			arrstrParam=split(strParam,",")
			  If instr(strMailSub1,arrstrParam(0))>0 Then
			strMailBody1=mail.body
			                   If Instr(strMailBody1,arrstrParam(1))>0 Then
						               	   strResult="Pass"
					                 else
							               strResult="Fail"
									End If
    				DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult
					
    		mail.unread=false 
			End if
			End if 
			next 

End Sub

	
Sub getsubfolders3(objparentfolder) 
													Set colfolders = objparentfolder.folders
												
													For each objfolder in colfolders 
												
														set objsubfolder = objparentfolder.folders(objfolder.name)
												
														if objfolder.name<>"notes" then 
															getunreadmails3(objfolder) 
														end if 
														getsubfolders3(objsubfolder)
													next 
End Sub

'======================================================END of Function================================================================


'=============================================Sub function for  Reading the designatio in the email not exist============================================
Sub getunreadmails4(objfolder) 
	
			set colValue = objfolder.items 
			for each mail in colValue 
			If mail.unread then 
				 strMailSub1=mail.subject
			  strMailSub2=split(strMailSub1,"-")
			arrstrParam=split(strParam,",")
			  If instr(strMailSub1,arrstrParam(0))>0 Then
			strMailBody1=mail.body
			                   If Instr(strMailBody1,arrstrParam(1))>0 Then
						               	   strResult="Fail"
					                 else
							               strResult="Pass"
									End If
    				DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult
					
    		mail.unread=false 
			End if
			End if 
			next 

End Sub

	
Sub getsubfolders4(objparentfolder) 
													Set colfolders = objparentfolder.folders
												
													For each objfolder in colfolders 
												
														set objsubfolder = objparentfolder.folders(objfolder.name)
												
														if objfolder.name<>"notes" then 
															getunreadmails4(objfolder) 
														end if 
														getsubfolders4(objsubfolder)
													next 
End Sub

'======================================================END of Function================================================================

'===============================================Getting Url for the ORG Request==========================================================

Sub getunreadmails5(objfolder) 
	
			set colValue = objfolder.items 
			for each mail in colValue 
			If mail.unread then 
				 strMailSub1=mail.subject
			  strMailSub2=split(strMailSub1,"-")

			  If instr(strMailSub1,arrstrParam(0))>0 Then
			strMailBody1=mail.body


						Set MyExcel = createobject("Excel.application")
						Set MyFile=myExcel.workbooks.open (Mid(strDataFileParam,1,12) &"\RazooExcel.xls")
						MyFile.worksheets(arrstrParam(1)).Cells(2, 2)= strMailBody1
						If  MyFile.worksheets(arrstrParam(1)).Cells(2,1)= myFile.worksheets(arrstrParam(1)).Cells(2, 2) Then
						MyFile.worksheets(arrstrParam(1)).Cells(2,3).value="Pass"
						 else
						'Msgbox "Fail"
						MyFile.worksheets(arrstrParam(1)).Cells(2,3).value="Fail"
						 End If
						MyExcel.ActiveWorkbook.Save
                        myExcel.Quit
                        Set myExcel=Nothing

			strMailBody2=split(strMailBody1,"http://")
			strMailBody3=split(Trim(strMailBody2(1)),"Sincerely")
		
			strResetUrl=Trim(strMailBody3(0))
				'msgbox strMailBody3(0)
				exit for
			mail.unread=false 
			End if
			end if 
			next 

End Sub


	
Sub getsubfolders5(objparentfolder) 
													Set colfolders = objparentfolder.folders
												
													For each objfolder in colfolders 
												
														set objsubfolder = objparentfolder.folders(objfolder.name)
												
														if objfolder.name<>"notes" then 
															getunreadmails5(objfolder) 
														end if 
														getsubfolders5(objsubfolder)
													next 
End Sub

'==================================================End Function================================================================

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

'=========================================================End Function============================================================

Public Function fnGetTotal(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
'
																		Set WebBrowserDesc=Description.Create
								'										WebBrowserDesc("name").value="An inspiring place to donate and raise money - Razoo"
																		WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"		
								'			
																		Set WebPageDesc=Description.Create
																		'WebPageDesc("title").value="An inspiring place to donate and raise money - Razoo"
																		WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"

									Set WebObjDesc=Description.Create
											WebObjDesc("micClass").value="WebElement"
											WebObjDesc("class").value="gutter"
											WebObjDesc("html tag").value="DIV"
									 Set objWebElement=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebObjDesc)
								
									 strExpected=objWebElement(strParam).getroproperty("innertext")

	fnGetTotal=strExpected
End Function


'=============================Get Donor Count and Fundraisers count=========================================
Public Function fnGetTotal1(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)


									Set WebObjDesc=Description.Create
											WebObjDesc("micClass").value="WebElement"
											WebObjDesc("class").value="gutter"
											WebObjDesc("html tag").value="DIV"
									 Set objWebElement=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebObjDesc)
								
									 strExpected=objWebElement(strParam).getroproperty("innertext")

	fnGetTotal1=strExpected
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


 '===========================Delete or cancel the Org admins==========================================================
 Public Function fnDeleteOrgAdmin(WebBrowserDesc,WebPageDesc,WebButtonDesc,strAction,strParam,strExpected,strChkPoint)

						Set WebButtonDesc=Description.Create
							     WebButtonDesc("micClass").value="WebButton"
								 WebButtonDesc("html tag").value="INPUT"
								 WebButtonDesc("name").value="Delete"

								 intRowCount=Browser(WebBrowserDesc).Page(WebPageDesc).WebTable("MatchingGrant Table").GetROProperty("rows")

                                 arrstrParam=Split(strParam,",")
								  For j=1 to intRowCount step 1
														if Trim(Browser(WebBrowserDesc).Page(WebPageDesc).webtable("MatchingGrant Table").GetCellData(j,1))=Trim(arrstrParam(0)) And  Trim(Browser(WebBrowserDesc).Page(WebPageDesc).webtable("MatchingGrant Table").GetCellData(j,3))=Trim(arrstrParam(1)) then
																		   intRowNum=j
												Exit for
														end if
												  Next  
	
												Set objWebButton=Browser(WebBrowserDesc).Page(WebPageDesc).WebTable("MatchingGrant Table").ChildObjects(WebButtonDesc)

                                       objWebButton(intRowNum-2).Click

End Function
'============================================================End Function===================================================================




'===========================================Calculate total donations amount  in Disbursement=====================================================

Public Function fnGetTotDonations(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint)

									  Set WebBrowserDesc=Description.Create
											   WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
									  Set WebPageDesc=Description.Create
											   WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
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

Public Function fnVerifyGetTotDonations(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint)

									 Set WebBrowserDesc=Description.Create
											   WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
									  Set WebPageDesc=Description.Create
												WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
									  Set WebTableDesc=Description.Create
											  WebTableDesc("micClass").value="WebTable"
											  WebTableDesc("name").value="WebTable"
											  WebTableDesc("html tag").value="TABLE"
			
											arrWtIndex=split(strParam,",")
											Set objWebTable=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebTableDesc)
											GetTotAmt=0
											GetTotAmt=objWebTable(arrWtIndex(0)).getroproperty("rows")
											GetTotAmt =objWebTable(arrWtIndex(0)).GetCellData(GetTotAmt,arrWtIndex(1))
											fnVerifyGetTotDonations=Mid(GetTotAmt,2)

End Function

'======================================================END of Function================================================================


'===============================================Calculate total Adjustments / Refunds=====================================================

Public Function fnGetTotAdjustments(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint) 

									 Set WebBrowserDesc=Description.Create
											   WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
									  Set WebPageDesc=Description.Create
												WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
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

'======================================Verify Total Adjustments/ Refunds=================================================================

Public Function fnVerifyGetTotAdjustments(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint) 
'strParam="1,2"
									 Set WebBrowserDesc=Description.Create
											   WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
									  Set WebPageDesc=Description.Create
												WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
										  Set WebTableDesc=Description.Create
										  WebTableDesc("micClass").value="WebTable"
										   WebTableDesc("name").value="WebTable"
										   WebTableDesc("html tag").value="TABLE"
            			
										arrWtIndex=split(strParam,",")
										Set objWebTable=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebTableDesc)
	
										GetTotAmt=0
    									 l=objWebTable(arrWtIndex(0)).getroproperty("rows")
										
												 If  Instr(objWebTable(arrWtIndex(0)).getcelldata(l,arrWtIndex(1)),"-")>0Then
														
															GetTotAmt= GetTotAmt - Mid(objWebTable(arrWtIndex(0)).getcelldata(l,arrWtIndex(1)),3)
                                                                                                
          										else
														GetTotAmt=GetTotAmt+Cdbl(Mid(objWebTable(arrWtIndex(0)).getcelldata(l,arrWtIndex(1)),2))
												End If
						 fnVerifyGetTotAdjustments=GetTotAmt

   End Function

'====================================================================================================================================

'================================================Calculate total  Disbursement Adjustments ================================================

Public Function fngettotdisbursementadjustments(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint)

                                    
									Set WebBrowserDesc=Description.Create
											  WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
									  Set WebPageDesc=Description.Create
											   WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
									  Set WebTableDesc=Description.Create
											   WebTableDesc("micClass").value="WebTable"
											   WebTableDesc("name").value="Processing Fees"
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
			
										fnGetTotDisbursementAdjustments=GetTotAmt

End Function

'======================================================END of Function================================================================

'======================Verify Disbursement Adjustments amount===========================================================================
Public Function fnVerifygettotdisbursementadjustments(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint)

'strParam="2,2"
									 Set WebBrowserDesc=Description.Create
											  WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
									  Set WebPageDesc=Description.Create
											   WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
									  Set WebTableDesc=Description.Create
											   WebTableDesc("micClass").value="WebTable"
											   WebTableDesc("name").value="WebTable"
											   WebTableDesc("html tag").value="TABLE"
			
										 arrWtIndex=split(strParam,",")
			
										 Set objWebTable=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebTableDesc)
			
										GetTotAmt=0
			
									l= objWebTable(arrWtIndex(0)).getroproperty("rows")
										
												If  instr(objWebTable(arrWtIndex(0)).getcelldata(l,arrWtIndex(1)),"-")>0 Then
                                                	  GetTotAmt=GetTotAmt - Cdbl(Mid(objWebTable(arrWtIndex(0)).getcelldata(l,arrWtIndex(1)),3))
													
												else
													  GetTotAmt=GetTotAmt + Cdbl(Mid(objWebTable(arrWtIndex(0)).getcelldata(l,arrWtIndex(1)),2))
													
												End If
			
										fnVerifygettotdisbursementadjustments=GetTotAmt

End Function
'======================================================END of Function================================================================

'==============================Get Brand Fee and Processing Fee=======================================================================
Public Function fnGetPBFee(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint) 

	'strParam="0,3"

                                    
									Set WebBrowserDesc=Description.Create
											  WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
									  Set WebPageDesc=Description.Create
											   WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
									  Set WebTableDesc=Description.Create
											   WebTableDesc("micClass").value="WebTable"
											   WebTableDesc("name").value="Processing Fees"
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
									fnGetPBFee=GetTotAmt
End Function
'======================================================END of Function================================================================


'============================Verifying Processing and Brand Fee amounts=================================================================
Public Function fnVerifyGetPBFee(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint) 

									 Set WebBrowserDesc=Description.Create
											  WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
									  Set WebPageDesc=Description.Create
											   WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
									  Set WebTableDesc=Description.Create
											   WebTableDesc("micClass").value="WebTable"
											   WebTableDesc("name").value="Processing Fees"
											   WebTableDesc("html tag").value="TABLE"
			
										 arrWtIndex=split(strParam,",")
			
										 Set objWebTable=Browser(WebBrowserDesc).Page(WebPageDesc).ChildObjects(WebTableDesc)
			
										GetTotAmt=0
			
									l= objWebTable(arrWtIndex(0)).getroproperty("rows")
										
												If  instr(objWebTable(arrWtIndex(0)).getcelldata(l,arrWtIndex(1)),"-")>0 Then
													
													  GetTotAmt=GetTotAmt - Cdbl(Mid(objWebTable(arrWtIndex(0)).getcelldata(l,arrWtIndex(1)),3))
													
												else
													  GetTotAmt=GetTotAmt + Cdbl(Mid(objWebTable(arrWtIndex(0)).getcelldata(l,arrWtIndex(1)),2))
												End If
												fnVerifyGetPBFee=GetTotAmt
   End Function
'======================================================END of Function================================================================

'======================================================Verify Total Disbursemtnts =======================================================

Public Function fnVerifyDisbursementTot(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint)

									 Set WebBrowserDesc=Description.Create
											  WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
									  Set WebPageDesc=Description.Create
											   WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"
			
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
            								fnVerifyDisbursementTot=GetTotAmt

   End Function

'======================================================END of Function================================================================

'=============================================Function for  Getting row number in Admin console Report for Givemn site==========================
Public Function  fnGetRowNumAdminGivemn()

    ' intRefNum="43"
										Set WebBrowserDesc=Description.Create
										WebBrowserDesc("name").value="The online destination for individuals and nonprofit organizations creating change in Minnesota - GiveMN"
			
			
										Set WebPageDesc=Description.Create
										WebPageDesc("title").value="The online destination for individuals and nonprofit organizations creating change in Minnesota - GiveMN"
			
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

									 intColCount=objWebTable(arrWtIndex(0)).getroproperty("cols")
											 For j=0 to intColCount step 1
													 if objWebTable(arrWtIndex(0)).GetCellData(1,j)=Trim(arrWtIndex(1)) then
														 intColNum=j
														Exit for
													end if
												 Next
End Function
'======================================================END of Function================================================================

Public Function fnExceltestdata()
Set myExcel = CreateObject("Excel.Application")
myExcel.Visible = True
Set myFile=myExcel.workbooks.open (Mid(strDataFileParam,1,12) &"\TestSuite.xls")
Set mySheet=myFile.worksheets("TestData")
Email=mySheet.Cells(4,4)
E1=Email+1
mysheet.Cells(4,4)=E1

EIN=mySheet.Cells(5,16)
EINNo=EIN+1
mySheet.Cells(5,16)=EINNo

EIN1=mySheet.Cells(6,16)
EINNo1=EIN1+1
mySheet.Cells(6,16)=EINNo1

TodaysDate=Now
Yearonly=Year(TodaysDate)
Monthonly=Month(TodaysDate)
Dayonly =Day(TodaysDate)
If len(Monthonly)<>2 Then
	Monthonly1="0" &Monthonly
	Monthonly=Monthonly1
End If
If len(Dayonly)<>2 Then
	Dayonly1="0"&Dayonly
	Dayonly=Dayonly1
End If

mySheet.Cells(8,4)=Yearonly&"-"&Monthonly&"-"&Dayonly
mySheet.Cells(13,63)=Monthonly&"/"&Dayonly+1&"/"&Yearonly

myExcel.Activeworkbook.save
myExcel.Quit
End Function
'=====================================================================================================================================
'======================================================For Checking the Widget code=================================================
 Public Function fnVerifyPropertyForWidgetExist(WebBrowserDesc,WebPageDesc,WebEditDesc,strAction,strParam,strExpected,strChkPoint)
'msgbox strExpected
'msgbox strActual
	arrstrParam=split(strExpected,",")

	For Each strItemInWidget in arrstrParam
		If  Instr(strActual, strItemInWidget)>0 Then
           DataTable.Value("PassFail","SubDriver [SubDriver]")="Pass"
		   Exit for
'msgbox strItemInWidget
		End If


	Next
End Function
'======================================================End Function================================================================

'======================================================For Verifying values in Admin reports============================================
Public Function fnVerifyReportValues()
   Set myExcel = CreateObject("Excel.Application")
myExcel.Visible = True
arrstrParam=Split(strParam,",")
Set myFile= myExcel.Workbooks.Open(arrstrParam(0))
Set mySheet=myFile.worksheets(arrstrParam(1))
Rows_Count=mySheet.usedrange.rows.count
Cols_Count=mySheet.usedrange.columns.count
'msgbox Cols_Count
For i = 1 to Cols_Count
    'msgbox mySheet.cells(1,i)
If mySheet.cells(1,i)="Team Name"Then
	'msgbox i &mySheet.cells(1,i)
	T2=i
	'msgbox T2
End If
If mySheet.cells(1,i)="Brand" Then
	'msgbox i &mySheet.cells(1,i)
	B2=i
	'msgbox B2
End If
Next 
'StrExpected="Sep08team"
For i=1 to Rows_Count
	If StrExpected=mySheet.cells(i+1,T2) Then
       	StrResult="Pass Brand Name:" &mySheet.cells(i+1,B2)
    		'msgbox StrResult
	End If
Next
		DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult
End Function
'==========================================================End Function============================================================
'======================================================For Verifying admin reports====================================================
Public Function fnVerifyReportColumns()

									StrResult="Pass"
									Set myExcel = CreateObject("Excel.Application")
									myExcel.Visible = True
									arrstrParam=Split(strParam,",")
									Set myFile= myExcel.Workbooks.Open(arrstrParam(0))
									Set mySheet=myFile.worksheets(arrstrParam(1))
                                    Cols_Count=mySheet.usedrange.columns.count
									'msgbox Cols_Count
									'StrParam="EIN,Name,City,State,Audit History URL,Donations Count,Donations Sum,Razoo Audit Date,Razoo Audit Status,Patriot Act Audit Date,Patriot Act Audit Status,IRS Audit Date,IRS Audit Status,#Widgets,#Followers,#Org Admins"
									arrstrParam=Split(strExpected,",")
									For i=0 to Cols_Count-1
									colsno=mySheet.Cells(1,i+1)
									'msgbox colsno
									'msgbox arrstrParam(i)
									If arrstrParam(i)<>colsno then
									StrResult="Fail " &arrstrParam(i)
									Exit For
                                   End if
									Next
									DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult

                                   myExcel.Quit
								   Set myExcel=nothing
                                                                       	
End Function
'==========================================================End Function============================================================

'========================================================Get the Url for Bulk Disbursement in Email======================================
Sub getunreadmails6(objfolder) 
	
			set colValue = objfolder.items 
			for each mail in colValue 
			If mail.unread then 
				 strMailSub1=mail.subject
			 

			  If instr(strMailSub1,strParam)>0 Then
			strMailBody1=mail.body
			strMailBody2=split(strMailBody1,"https://")
			strMailBody3=split(Trim(strMailBody2(1)),"data")
			
			strResetUrl=Trim(strMailBody3(0))&"data"
			'msgbox strResetUrl
            			
			mail.unread=false 
			End if
			end if 
			next 

End Sub


	
Sub getsubfolders6(objparentfolder) 
													Set colfolders = objparentfolder.folders
												
													For each objfolder in colfolders 
												
														set objsubfolder = objparentfolder.folders(objfolder.name)
												
														if objfolder.name<>"notes" then 
															getunreadmails6(objfolder) 
														end if 
														getsubfolders6(objsubfolder)
													next 
End Sub

'=============================================End function======================================================

'===================================Verify the Org name in the CSV  file==============================================
Public Function fnVerifyDisbursementName()
   Set myExcel = CreateObject("Excel.Application")
									myExcel.Visible = True
									arrstrParam=Split(strParam,",")
									Set myFile= myExcel.Workbooks.Open(arrstrParam(0))
									Set mySheet=myFile.worksheets(arrstrParam(1))
                                    Cols_Count=mySheet.usedrange.columns.count
									
									
									For i=1 to Cols_Count step 1
									colsno=mySheet.Cells(1,i)
  									If arrstrParam(2)=colsno then
										l=i
                                      	Exit For
                                   End if
									Next

                             strResult="Fail"
							 
                                   For i=1 to mySheet.usedrange.rows.count step 1
									  
									   If Trim(strExpected)=Trim(mySheet.Cells(i,l)) Then
										  ' msgbox "Passed"
										  strResult="Pass"
										DataTable.Value("Actual","SubDriver [SubDriver]")=strExpected
										Exit for
									   End If										
								   Next
								   DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult
								   myExcel.Quit
								   Set myExcel=nothing
End Function
'=============================================End function======================================================

'===========================================Verify ORG Donation Report==========================================
Public Function fnVerifyOrgDonationReport()
   'strParam="D:\QTP_Razoo\Files\DonationsReport.csv,DonationsReport,Email"

arrstrParam=split(strParam,",")
 Set myExcel=CreateObject("Excel.Application")
   myExcel.Visible=True
   Set myFile=myExcel.Workbooks.Open(arrstrParam(0))
   Set mySheet=myFile.worksheets(arrstrParam(1))
   Cols_Count=mySheet.usedrange.columns.count
   Rows_Count=mySheet.usedrange.rows.count
   Cells_Count=mySheet.usedrange.cells.count

  ' intRefNum="308"
	For i=1 to Rows_Count
     
        	   If Cint(intRefNum)=mySheet.Cells(i,1) Then
                    m=i
					'msgbox m
					Exit for
				   End if
                   Next
'msgbox arrstrParam(2)
				  
   For j=1 to Cols_Count
	   If arrstrParam(2)=mySheet.Cells(1,j) Then
		i=j
		'msgbox i
		 Exit For
            End if
		   Next
		   strResult=mySheet.Cells(1,j)
  DataTable.Value("strActual","SubDriver [SubDriver]")=strResult
  myExcel.Quit
Set myExcel=nothing
 msgbox mySheet.Cells(m,i)

 End Function
 '=====================================================End function==================================================

'===========================================Click Send button while sharing story page===================================
Public Function fnSendEmail()
Window("Message (HTML)").WinObject("window id:=4099").Type StrParam
Window("Message (HTML)").WinButton("text:=&Send").Click
End Function
 '=====================================================End function==================================================


'====================================Filling Credit Card details========================================================
Public Function fnGuestCardDetails(strParam)
                         
									arrstrParam_Don=Split(strParam,",")
									'Browser("Receipt").Page("An inspiring place to_3").WebEdit("donation_transactiond_donation_amount").Set arrstrParam_Don(0)
									'intDonAmt=Browser("An inspiring place to").Page("An inspiring place to").WebEdit("donation_transactiond_donation_amount").GetROProperty("value")
									'intDonAmt=arrstrParam_Don(0)
									Browser("An inspiring place to").Page("An inspiring place to").WebEdit("Guest_NameOnCard").Set arrstrParam_Don(0)
									Browser("An inspiring place to").Page("An inspiring place to").WebEdit("Guest_Street").Set arrstrParam_Don(1)
									Browser("An inspiring place to").Page("An inspiring place to").WebEdit("Guest_City").Set arrstrParam_Don(2)
									'Browser("An inspiring place to").Page("An inspiring place to").WebEdit("order_user_order[state]").Set arrstrParam_Don(3)
									Browser("An inspiring place to").Page("An inspiring place to").WebList("Guest_State").Select arrstrParam_Don(3)
									Browser("An inspiring place to").Page("An inspiring place to").WebEdit("Guest_PostalCode").Set arrstrParam_Don(4)
									Browser("An inspiring place to").Page("An inspiring place to").WebList("Guest_Country").Select arrstrParam_Don(5)
									Browser("An inspiring place to").Page("An inspiring place to").WebEdit("Guest_CardCode").Set arrstrParam_Don(6)
									Browser("An inspiring place to").Page("An inspiring place to").WebList("Guest_ExpMonth").Select arrstrParam_Don(7)
									Browser("An inspiring place to").Page("An inspiring place to").WebList("Guest_ExpYear").Select arrstrParam_Don(8)
									Browser("An inspiring place to").Page("An inspiring place to").WebEdit("Guest_SecureCode").Set arrstrParam_Don(9)

									Browser("An inspiring place to").Page("An inspiring place to").webCheckBox("Gift Card_Terms").Set "ON"

End Function
 '=====================================================End function==================================================

'==========================Getting totla amount from user profile Donations================================================
Public Function fnGetTotalDonated(WebBrowserDesc,WebPageDesc,WebObjDesc,strAction,strParam,strExpected,strChkPoint)
															strExpected=Browser(WebBrowserDesc).page(WebPageDesc).WebElement(WebObjDesc).GetROProperty(strParam)	 
															strTotal=Split(strExpected,"Donated")
															strExpected=cdbl(Trim(Mid(strTotal(0),2)))
															fnGetTotalDonated=strExpected
   End Function
 '=====================================================End function==================================================

'=================================Get the Column number from Gift Card table=============================================
Public Function fnGetGiftCardColumnNum(WebBrowserDesc,WebPageDesc,WebTableDesc,strAction,strParam,strExpected,StrChkPoint)


    intColCount=Browser(WebBrowserDesc).Page(WebPageDesc).WebTable(WebTableDesc).getroproperty("cols")

											 For j=0 to intColCount step 1
													 if Browser(WebBrowserDesc).Page(WebPageDesc).WebTable(WebTableDesc).GetCellData(1,j)=Trim(strParam) then
														 intColNum=j
														Exit for
													end if
												 Next

												 fnGetGiftCardColumnNum= intColNum

End Function
 '=====================================================End function==================================================

'======================================To Save PDF/any attachments==================================================
Sub getunreadmails7(objfolder) 
					                                                    Set col = objfolder.items 
																		For each mail in col 
																		If mail.unread then 
																		For each att in mail.attachments
																		'FileName="D:\QTP_Razoo\Files\"& att.FileName
																		FileName=Mid(strDataFileParam,1,12) &"\Files\" &att.FileName
																		att.saveasfile FileName
																		Next
																		End If
																		mail.unread=false 
																		next 
																		End Sub 


													Sub getsubfolders7(objparentfolder) 

																		set colfolders = objparentfolder.folders
																		For each objfolder in colfolders 
																		set objsubfolder = objparentfolder.folders(objfolder.name)
																		if objfolder.name<>"notes" then 
																		getunreadmails7 (objfolder) 
																		end if 
																		getsubfolders7(objsubfolder )
																		next 
																		End Sub
 '=====================================================End function==================================================

  '==================================================Select  10 checkboxes from Marque page============================
Public Function fnSelectTenCheckBoxes(WebBrowserDesc,WebPageDesc,WebTableDesc,WebCheckBoxDesc,strParam)

									Set WebBrowserDesc=Description.Create
									WebBrowserDesc("name").value="Raise Money for Nonprofits and Charities Online - Razoo"
		
        							Set WebPageDesc=Description.Create
									WebPageDesc("title").value="Raise Money for Nonprofits and Charities Online - Razoo"
		
								   Set WebTableDesc=Description.Create
									WebTableDesc("micClass").value="WebTable"
									WebTableDesc("html tag").value="TABLE"
                                    		
									Set WebCheckBoxDesc=Description.Create
									WebCheckBoxDesc("micClass").value="WebCheckBox"
									WebCheckBoxDesc("type").value="checkbox"

									Set objCheckBox=Browser(WebBrowserDesc).Page(WebPageDesc).webtable(WebTableDesc).ChildObjects(WebCheckBoxDesc)
									intRowCount=objCheckBox.Count
						
									For j=0 to 9 step 1
											 
												objCheckBox(j).Set strParam                                           													
									  Next  


End Function

'======================================================END of Function================================================================

'=====================================================Hitler Image Checkpoint===========================================================
Public Function HitlerImageCheckPoint()

                                             strResult= Browser("An inspiring place to").Page("An inspiring place to").Image("Razoo User").Check(CheckPoint("Razoo User"))
	                                         If strResult Then
											  strResult="Pass"
								              else
											  strResult="Fail"
											  End If
											  DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult
End Function


'=====================================================Golden Cookie Image Checkpoint====================================================
Public Function GoldenCookieCheckPoint()

                                            strResult=Browser("An inspiring place to").Page("An inspiring place to").Image("Gold_size_150x150").Check(CheckPoint("Gold_size_150x150"))
										    If strResult Then
										     strResult="Pass"
								            else
										    strResult="Fail"
										    End If
										    DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult
End Function
'======================================================END of Function==================================================================


'=====================================================Preview Theme Image Checkpoint====================================================

Public Function ImagePreviewCheckPoint()
  

                                            strResult=Browser("An inspiring place to").Page("An inspiring place to").Image("Loading").Check(CheckPoint("Loading"))
                                            If strResult Then
										     strResult="Pass"
								            else
										    strResult="Fail"
										    End If
										    DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult
End Function
'======================================================END of Function=================================================================


'==============================================Sample Image Checkpoint in Theme Creation Page===========================================
Public Function SampleThemeCheckPoint()

											strResult=Browser("An inspiring place to").Page("An inspiring place to").Image("Sample Email Layout").Check(CheckPoint("Sample Email Layout"))
											If strResult Then
											strResult="Pass"
											else
											strResult="Fail"
											End If
											DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult
End Function
'======================================================END of Function================================================================

'=====================================================Verify Email Presented===========================================================
Public Function fnVerifyEmailContentPresented()

Set MyExcel=createobject("Excel.application")
																		
	Set MyFile=myExcel.workbooks.open (Mid(strDataFileParam,1,12) &"\RazooExcel.xls")

intWsCount=MyFile.Worksheets.count

j=1
While j<=intWsCount

	If  myfile.Worksheets(j).cells(2,2)<>""Then
          myfile.Worksheets(j).cells(2,3)="Pass"
		  Else
          myfile.Worksheets(j).cells(2,3)="Fail"
	End If

	j=j+1

Wend
	 MyExcel.ActiveWorkbook.Save
																					
		myExcel.Quit
  		Set myExcel=Nothing	

End Function

'======================================================END of Function================================================================

'====================================To Verify the Content of Hack urls====================================================================
 Public Function fnVerifyPropertyForHackUrlExist()

										If len(strActual)>200 Then
										   strActual=Trim(Mid(strActual,1,200))
    											End If
									
											If instr(strActual, strExpected)>0 Then
												strResult="Pass"
												else
												strResult="Fail"
											End If

								   DataTable.Value("Actual","SubDriver [SubDriver]")=strActual
								   DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult
End Function
'======================================================END of Function================================================================

'=====================================================Avatar Image Checkpoint===========================================================
Public Function AvatarCheckPoint()

                                             strResult= Browser("An inspiring place to").Page("An inspiring place to").Image("Avatar").Check(CheckPoint("Avatar"))
	                                         If strResult Then
											  strResult="Pass"
								              else
											  strResult="Fail"
											  End If
											  DataTable.Value("PassFail","SubDriver [SubDriver]")=strResult
End Function
'======================================================END of Function=================================================================