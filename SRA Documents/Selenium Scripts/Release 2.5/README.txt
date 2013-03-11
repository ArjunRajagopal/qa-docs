README.TXT for Selenium
==========================

Before Execution, Kindly make sure that you have done the below things,

1. Start the latest selenium server 2.14.
2. Please change the testdata path in the TestSuite file.
3. Make sure the following theme is available with URN "Holiday-Wish".
4. Make sure the Gift card theme is available in the app.

BEFORE EXECUTION:
==================
1. Open the browser(which one you are going to use for execution).
2. Login via FB and Logout.
3. Login via GMail and Logout.

DURING EXECUTION:
==================
1. First scenario passed, scripts failed from second scenario, stop execution and comment(Ctrl+Q)
     the script line in 'STATIC VALUES' section
     $new_staticvalue = $old_staticvalue.to_i()+1

2. Remove the Comment(Ctrl+Q) from the script line in 'STATIC VALUES' section
     $new_staticvalue = $old_staticvalue

AFTER EXECUTION:
=================
If Execution completed successfully.

1. Remove the  comment(Ctrl+Q) from the script line in 'STATIC VALUES' section
      $new_staticvalue = $old_staticvalue.to_i()+1

2.  Comment(Ctrl+Q) the script line in 'STATIC VALUES' section
      $new_staticvalue = $old_staticvalue

3.  Save it.
