'==============================
'Version Number :  ver 1.0
'Created date : 05-05-2010
'==============================
Option Explicit

'Datatable variables
Dim strComponent,strBrowser,strObject,strObjectName,strAction,strParam,strExpected,strChkpoint

'Testcase sheet details
Dim strDataFileParam,strLibParam,arrLibrarypath,strLibrarypath,str

'Local loop variables
Dim intsdrRowCount,k,cRow,arrFilepath1
Dim intPassCount,intFailCount,strObjRep
Dim strPage

intPassCount=0
intFailCount=0

'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
'TotalDonationsToStoryPage=0
'=================================
'getting parameter  value from the Driver
'=================================
'On error resume next
strLibParam=Parameter("strLibLoc")

ExecuteFile strLibParam

strDataFileParam=Parameter("strDataLoc")

'=================================
'Importing the Data File.xls to Local datatable
'=================================
DataTable.ImportSheet strDataFileParam,"TestCase","SubDriver [SubDriver]"

'=================================
'Get Rowcount of datatable to get the no.of iterations
'=================================

intsdrRowCount=DataTable.GetSheet("SubDriver [SubDriver]").GetRowCount 

strObjRep=Parameter("ObjRep")

RepositoriesCollection.Add(strObjRep)

'=================================
'PassFail column is added to Local datatable
'=================================

DataTable.GetSheet("SubDriver [SubDriver]").AddParameter "PassFail",""
'msgbox datatable.GetSheet("SubDriver [SubDriver]").GetRowCount



'============================================================
'Fetches the Datatable values  Row by Row and stores in the variables 
'============================================================

For  k=1 to intsdrRowCount step 1
    DataTable.GetSheet("SubDriver [SubDriver]").SetCurrentRow(k)
	strComponent=DataTable.GetSheet("SubDriver [SubDriver]").GetParameter("Component").ValueByRow(k)
    strBrowser=DataTable.GetSheet("SubDriver [SubDriver]").GetParameter("Browser").ValueByRow(k)
	strPage=DataTable.GetSheet("SubDriver [SubDriver]").GetParameter("Page").ValueByRow(k)

	strObject=DataTable.GetSheet("SubDriver [SubDriver]").GetParameter("Object").ValueByRow(k)
    strObjectName=DataTable.GetSheet("SubDriver [SubDriver]").GetParameter("ObjectName").ValueByRow(k)
    strAction=DataTable.GetSheet("SubDriver [SubDriver]").GetParameter("Action").ValueByRow(k)
	strParam=DataTable.GetSheet("SubDriver [SubDriver]").GetParameter("Param").ValueByRow(k)
	strExpected=DataTable.GetSheet("SubDriver [SubDriver]").GetParameter("Expected").ValueByRow(k)
	'strChkpoint=DataTable.GetSheet("SubDriver [SubDriver]").GetParameter("Checkpoint").ValueByRow(i)

					'=========================================================
					'Component funtions are callled and  are mapped to the application
					'=========================================================

	Select Case strComponent
		Case "Web"
			
				Select Case strObject

					Case "Browser"
            					   Call  fnBrowser (strBrowser, strPage, strAction, strParam, strExpected,strChkPoint)

					Case "WebEdit"
									Call fnEdit(strBrowser,strPage,strObjectName,strAction,strParam,strExpected,strChkPoint)

					Case "WebElement"
                             		Call fnElement (strBrowser,strPage,strObjectName,strAction,strParam,strExpected,strChkPoint)

					Case "WebButton"	 
									Call fnButton (strBrowser, strPage, strObjectName,strAction,strParam,strExpected,strChkPoint)

					Case "WebLink"	 
                        			Call fnlink(strBrowser,strPage,strObjectName,strAction,strParam,strExpected,strChkPoint)	

					Case "WebList"	 
                             		Call fnlist(strBrowser,strPage,strObjectName,strAction,strParam,strExpected,strChkPoint)	

					Case "WebCheckBox"	 
                       				Call fnCheckBox(strBrowser, strPage, strObjectName,strAction,strParam,strExpected,strChkPoint)
                        
					Case "WebFile"	 
                             	   Call fnfile(strBrowser, strPage, strObjectName,strAction,strParam,strExpected,strChkPoint)

					Case "WebRadioGroup"	
                        			Call fnRadioGroup (strBrowser,strPage,strObjectName,strAction,strParam,strExpected,strChkPoint)		  

					Case "Sleep"	
								   Call fnSleep(strAction,strParam)		

					 Case "WebImage"
									  Call fnImageAction (strBrowser,strPage,strObjectName,strAction,strParam,strExpected,strChkPoint)

				   Case "WebTable"
						    	 Call fnWebTable(strBrowser,strPage,strObjectName,strAction,strParam,strExpected,strChkPoint)

				   Case "WinButton"
                        		 Call fnwinbutton (strBrowser,strPage,strObjectName,strAction,strParam,strExpected,strChkPoint)

				   Case "WinEdit"
                        		 Call fnwinedit (strBrowser,strPage,strObjectName,strAction,strParam,strExpected,strChkPoint)

                   End Select

				 Case "Win"
							    Call fnEmailsChecking()

                Case "File"
							   Call fnReadFileContent(strAction,strParam)
                            
		        Case "DBCheck"
							   Call fndbcheck(strObjectname,strAction,strParam,strExpected,strChkPoint)	

             
        End Select
        
Next

Call fnResultsWindow(intPassCount,intFailCount,k)


'========================================
'Results are stored to the Log file from datatable
'========================================

arrFilepath1=split(strDataFileParam,".")

dataTable.Export "D:\QTP_RAZOO\LogFiles\" & mid(arrFilepath1(0),20)  &"_TestReport_" &MonthName(Month(now))  &"_"  &Day(Date)  &"_"  & Year(Now) &"_" & Hour(now) &"_" &Minute(Now) &"_" &Second(Now) &".xls"

ExitAction (1)

'On error goto 0

RepositoriesCollection.RemoveAll()
