﻿
'==============================
'Version Number :  ver 1.1
'Modified  date: 13-Oct-2010
'==============================
Option explicit
Dim intdrRowCount,strDataLoc,strFileName,strTestSuite
Dim arrFilepath
Dim i,j,repeatNo,strObjRep,strStatus,arrFilepath1

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
				   Msgbox "Completed :" &i
    End If
Next

'arrFilepath1=split(strTestSuite,".")
'Datatable.Export "D:\QTP_RAZOO\LogFiles\" & mid(arrFilepath1(0),14)  &"_TestReport_" &MonthName(Month(now))  &"_"  &Day(Date)  &"_"  & Year(Now) &"_" & Hour(now) &"_" &Minute(Now) &"_" &Second(Now) &".xls"



