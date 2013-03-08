README.TXT for QTP
================================================================================================================

Before Execution for each Release, Kindly make sure that you have done the below things,

1. Do the DB Refresh(www-qaindia.razoo.com/admin/db_refresh).
2. Login with super admin(brian@razoo.com,razoo1).
3. Modify User first name and last name as Razoo and SuperAdmin respectively
4. Run the hack url to make data present in Search screen(www-qaindia.razoo.com/admin/reindex_all)
5. Create a CMS page with key as "orders-share-panel" with body content as orders-share-panel
6. Create Six(6) Marquees in Razoo brand before first round(we need not create marquees from Second round onwards)
7. Upload a Preferred_Npos CSV file in Razoo brand
8. Before script Execution insert one Empty row at top in TestData sheet in TestSuite.xls file. Remvoe the inserted    Row in TestData sheet in Testsuite.xls file once Script execution has been completed in Each and Every round


Once all Scripts have been executed for First Round, Do the below mentioned things for remaining Rounds
1. Login to application with sdr@srasys.co.in, razoo1
2. Delete the Saved Credit card in user profile(sdr@srasys.co.in)
3. Navigate to Razoo Edit brand and Save brand with below mentioned details
   Brand fee=0
   Campaign fee=0
   Processing fee=0
   Sponsor name(Cisco systems)=0
   Select Time zone as (GMT-05:00) Eastern Time (US & Canads) 
4. Rename object repositories from ObjRep2/3/4/5/6 to ObjRep according to corresponding rounds in OR folder which is presented in QTP_RAZOO folder
================================================================================================================