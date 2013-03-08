
'==============================
'Version Number :  ver 1.1
'Modified  date: 13-Oct-2010
'==============================
Option explicit
Dim intdrRowCount,strDataLoc,strFileName,strTestSuite
Dim arrFilepath
Dim i,j,repeatNo,strObjRep,strStatus,arrFilepath1
Dim OutlookApplication,Mail,WshShell


''Fetching data from environment file
'==============================
Environment.LoadFromFile ("D:\QTP_RAZOO\Config.xml")


'Fetching the function library path
'==============================
strFileName=Environment.Value("Libpath")

'Fetching  the testsuite path
'====================================
strTestSuite=Environment.Value("TestSuitepath")
strObjRep= Environment.Value ("ObjRep")


'Importing the testsuite sheet to Driver DataTable
'====================================
Datatable.ImportSheet strTestSuite ,"Tests","Driver"


'Importing the SampleTestData sheet to Global DataTable
'====================================
Datatable.ImportSheet strTestSuite ,"Testdata","Global"


'Fetching the data fram  DataTable
'====================================
intdrRowCount=DataTable.GetSheet("Driver").GetRowCount
For i=1 to intdrRowCount step 1
	Datatable.GetSheet("Driver").SetCurrentRow(i)
	If Ucase(Trim(DataTable.Value("Flag","Driver")))=Ucase("Yes") Then
             repeatNo=DataTable.Value("Repeat","Driver")
					If repeatNo="" Then
									repeatNo=1
					End If
					
				   For j=1 to repeatNo step 1

					  strStatus="Passed"

								  strDataLoc=DataTable.GetSheet("Driver").GetParameter("TestFiles").ValueByRow(i)
								  
								  RunAction "SubDriver [SubDriver]", alliterations,strFileName,strDataLoc,strObjRep,strStatus
								 
								  Datatable.GetSheet("Driver").SetCurrentRow(i)
								
								  DataTable.Value("Status","Driver")=strStatus
                                
								  Datatable.ExportSheet strTestSuite,2
				   Next
				   'Msgbox "Completed :" &i
    End If
Next


Set OutlookApplication = CreateObject("Outlook.Application")
Set Mail = OutlookApplication.CreateItem(0)
Mail.To = "rmo@srasys.co.in; rki@srasys.co.in" 'Enter your mail id here
Mail.Subject = "test"
Mail.Body = "this is a test of QTP"
Mail.display
Set WshShell = CreateObject("WScript.Shell")
WshShell.SendKeys("%s")
Set Mail = Nothing 





