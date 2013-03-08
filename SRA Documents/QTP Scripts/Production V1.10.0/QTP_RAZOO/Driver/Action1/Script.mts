
'==============================
'Version Number :  ver 1.1
'Modified  date: 13-Oct-2010
'==============================
Option explicit
Dim intdrRowCount,strDataLoc,strFileName,strTestSuite
Dim arrFilepath, strAppUrl
Dim i,j,repeatNo,strObjRep,intFcount,results,strRes 

''Fetching data from environment file
'==============================
Environment.LoadFromFile ("D:\QTP_RAZOO\Config.xml")

'Fetching the Application path
'==============================
'strAppUrl=Environment.Value("AppUrl")

'Fetching the function library path
'==============================
strFileName=Environment.Value("Libpath")

'Fetching  the test case path from Test Suite
'====================================
strTestSuite=Environment.Value("TestSuitepath")
strObjRep= Environment.Value ("ObjRep")
'msgbox strTestSuite
'msgbox strAppUrl
'msgbox strFileName

'Importing the test case file to DataTable
'====================================
Datatable.ImportSheet strTestSuite ,"Tests","Driver"

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
'sht
'                			    strDataLoc=DataTable.GetSheet("Driver").GetParameter("TestFiles").ValueByRow(i)
'								RunAction "SubDriver [SubDriver]", alliterations,strFileName,strDataLoc,strObjRep,results
'                                Datatable.GetSheet("Driver").SetCurrentRow(i)
'								msgbox "results:" &results
'								DataTable.Value("Status","Driver")=results
'                             Datatable.ExportSheet "D:\QTP_RAZOO\Testsuite.xls",2
'sht
					 strStatus="Passed"

								  strDataLoc=DataTable.GetSheet("Driver").GetParameter("TestFiles").ValueByRow(i)
								  
								  RunAction "SubDriver [SubDriver]", alliterations,strFileName,strDataLoc,strObjRep,strStatus
								 
								  Datatable.GetSheet("Driver").SetCurrentRow(i)
								
								  DataTable.Value("Status","Driver")=strStatus
                                
								  Datatable.ExportSheet strTestSuite,2
				  Next
				  
    End If
Next



