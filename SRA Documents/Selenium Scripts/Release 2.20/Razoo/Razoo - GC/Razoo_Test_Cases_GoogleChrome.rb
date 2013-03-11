#-----------------------------------------------------------------------------#
# Razoo_Test_Cases.rb
#
# Author: EBI,SDR and SID
# Date: 4-OCT-2010
# Description:  Includes all the methods that are required to execute the test cases in IE.
#
# Change history:
# 5-OCT-2010  - Added createFundraise scenarios.
# 13-OCT-2010 - Fine tuned few codes and added grantOrgAdminRights() method
# 14-OCT-2010 - Added scenario 4. 5, 6 and 7. # 15-OCT-2010 - Included Facebook pop up code. # 21-OCT-2010 - Included Share page code. # 28-OCT-2010 - Included 9, 10 scenarios. 
# 16-NOV-2010 - Update on Release 1.8. # 25-NOV-2010 - Implementing EXCEL concept. # 22-DEC-2010 - Update - Release 1.10. # 14-Jan-2010 - Update - Release 1.11.
# 7-Feb-2011 - Update - Release 1.11.1.  # 25-Feb-2011 - Update - Release 1.12. # 28-Mar-2011 - Update - Release 1.13. # 28-Apr-2011 - Update - Release 1.14. # 11-May-2011 - Update - Release 1.15.
# 19-May-2011 - Update - Release 1.16. # 3-June-2011 - Update - Release 1.17. # 15-June-2011 - Update - Release 1.18. # 30-June-2011 - Update - Release 1.19.
# 14-July-2011 - Update - Release 1.20. # 23-July-2011 - Update - Release 1.22. # 23-Sep-2011 - Update - Release 1.23&1.24.  # 06-Oct-2011 - Update - Release 1.25
# 18-Oct-2011 - Update - Release 1.25.3 # 2-Nov-2011 - Update - Release 1.26 # 24-Nov-2011 - Update - Release 2.1 # 19-Jan-2012 - Update - Release 2.2
# 27-Feb-2012 -Scripts updated with scenario by scenario execution method with time.
#-----------------------------------------------------------------------------# 

require "test/unit"
require "rubygems"
gem "selenium-client"
require "selenium/client"
# Variable declarations
$verification_errors = []

#------------------------------------------------------------------#
# Description:  It is a METHOD for invoking the Razoo Site
#------------------------------------------------------------------#

def invokeRazooSite(test_site)
	
	puts "************** START : Invoke Razoo Application ****************"	
	# Create a new instance of the Selenium-Client driver.
	$browser = Selenium::Client::Driver.new \
		:host => "localhost",
		:port => 4444,
		:browser => "*googlechrome", 
		:url => test_site,
		:timeout_in_second => 300

	# Start the browser session
	$browser.start_new_browser_session
	
	# Print a message in the browser-side log and status bar
	$browser.set_context("Razoo Application")
	$browser.open "/"
	puts "Passed. Razoo Site gets invoked successfully!"
	puts "************** END : Invoke Razoo Application ****************"
	
end

#-----------------------------------------------------------------------------#
# Description:  This method allows the user to create account in Razoo.
#-----------------------------------------------------------------------------#

def createRazooAccount(first_name, last_name, email_id, pass_word)
	
	puts "************** START : Create a Razoo Account ****************"	
	sleep 10
	begin
		assert $browser.is_text_present("Already Have an Account?")
		puts "Click on 'Sign Up' link in the donation form screen."
		#***************** Link position check *****************#
		@createaccountlink_topposition = $browser.get_element_position_top "link=create an account"
		puts "Create account link Top position : #{@createaccountlink_topposition}"
		if @createaccountlink_topposition == '246'
			puts "UI Check : Pass. Create Account link is present at the correct position in Donation Form."
		else
			puts "UI Check : Fail. Create Account link is not present at the correct position in Donation Form."
		end
		$browser.click "link=create an account"
		$browser.wait_for_page_to_load 
	rescue
		#***************** Link position check *****************#
		@signuplink_topposition = $browser.get_element_position_top "link=Sign up"
		puts "Sign in link Top position : #{@signuplink_topposition}"
		if @signuplink_topposition == '47' or @signuplink_topposition == '46'
			puts "UI Check : Pass. Signup link is present at the correct position in Home screen."
		else
			puts "UI Check : Fail. Signup link is not present at the correct position in Home screen."
		end
		$browser.click "link=Sign up"
		sleep 2
	end

	begin
		assert $browser.is_text_present("Create an account on Razoo")
		puts "Passed. User has reached the Account creation page successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. User didn't reach the Account creation page."
	end
	puts "Step 1 : Entering  Account creation details"
	$browser.type "user_first_name", first_name
	$browser.type "user_last_name", last_name
	$browser.type "user_email", email_id
	$browser.click "user_terms_of_use"
	$browser.type "user_password", pass_word
	$browser.type "user_password_confirmation", pass_word
	begin
		assert $browser.is_text_present("Send me the monthly Razoo newsletter")
		puts "Pass. 'Send me the monthly Razoo newsletter' checkbox is present in the Razoo Signup screen."
	rescue Test::Unit::AssertionFailedError
		puts "Pass. 'Send me the monthly Razoo newsletter' checkbox is not present in the GiveMN Signup screen."
	end
	#***************** Button position check *****************#
	@createaccountbutton_topposition = $browser.get_element_position_top "//button[@type='submit']"
	puts "Create Account button Top position : #{@createaccountbutton_topposition}"
	if @createaccountbutton_topposition == '601' or @createaccountbutton_topposition == '613'
		puts "UI Check : Pass. CreateAccount button is present at the correct position in Signup screen."
	else
		puts "UI Check : Fail. CreateAccount button is not present at the correct position in Signup screen."
	end
	$browser.click "//button[@type='submit']"
	$browser.wait_for_page_to_load
		 
	begin
		assert $browser.is_text_present("Your Donation")
		begin
			assert $browser.is_text_present("Your account has been created.")
			$user_name = first_name+" "+ last_name
			puts "Step 2 : Passed. Account has been created successfully! and retained in the Donation Form screen."
		rescue Test::Unit::AssertionFailedError
			begin
				assert $browser.is_text_present("Email is already in use by another account (if it's yours, you can recover your account password from the login screen)")
				puts "Step 2 : Failed. #{email_id} has already been taken."
			rescue Test::Unit::AssertionFailedError
				puts "@@@@@@@@@ FAILED @@@@@@@@@ Step 2 : Failed. Account not created successfully!"
			end
		end
	rescue Test::Unit::AssertionFailedError
	
		begin
			assert $browser.is_text_present("Your account has been created.")
			puts "Step 2 : Passed. Account has been created successfully!"
		rescue Test::Unit::AssertionFailedError
			begin
				assert $browser.is_text_present("Email is already in use by another account (if it's yours, you can recover your account password from the login screen)")
				puts 	"Step 2 : Failed. #{email_id} has already been taken."
			rescue Test::Unit::AssertionFailedError
				puts "@@@@@@@@@ FAILED @@@@@@@@@ Step 2 : Failed. Account not created successfully!"
			end
		end
		begin
			assert $browser.is_element_present("//img[@alt='Your profile picture']")
			$browser.click "//img[@alt='Your profile picture']"
			$browser.wait_for_page_to_load 
			begin
				assert $browser.is_element_present("css=img.photo")
				puts "Pass. Hitler image is present in Profile page."
			rescue Test::Unit::AssertionFailedError
				puts "Fail. Hitler image is not present in Profile page."
			end
			$browser.click "link=My Profile"
			$browser.wait_for_page_to_load 
			begin
				$user_name = first_name+" "+last_name
				assert $browser.is_text_present($user_name)
				puts "Step 3 : Passed. #{$user_name} gets displayed in Account screen."
			rescue Test::Unit::AssertionFailedError
				puts "Step 3 : Failed. #{$user_name} doesn't get displayed in Account screen."
			end
		rescue Test::Unit::AssertionFailedError
			puts "No header links displayed in the Thank you screen."
			$browser.click "css=em"
			$browser.wait_for_page_to_load
			$browser.click "css=a.button > em"
			$browser.wait_for_page_to_load 
		end
		
	end
	puts "************** END : Create a Razoo Account ****************"	
end


#------------------------------------------------------------------------------------------------------#
# Description:  This method allows the user to create account in Razoo thru Sign up modal.
#------------------------------------------------------------------------------------------------------#

def createRazooAccountSignupModal(first_name, last_name, email_id, pass_word)
	
	puts "************** START : Create a Razoo Account ****************"	
	
	begin
		assert $browser.is_text_present("Already Have an Account?")
		puts "Click on 'Sign Up' link in the donation form screen."
		#***************** Link position check *****************#
		@createaccountlink_topposition = $browser.get_element_position_top "link=create an account"
		puts "Create account link Top position : #{@createaccountlink_topposition}"
		if @createaccountlink_topposition == '246'
			puts "UI Check : Pass. Create Account link is present at the correct position in Donation Form."
		else
			puts "UI Check : Fail. Create Account link is not present at the correct position in Donation Form."
		end
		$browser.click "link=create an account"
		sleep 2
	rescue
		#***************** Link position check *****************#
		@signuplink_topposition = $browser.get_element_position_top "link=Sign up"
		puts "Sign in link Top position : #{@signuplink_topposition}"
		if @signuplink_topposition == '47' or @signuplink_topposition == '46'
			puts "UI Check : Pass. Signup link is present at the correct position in Home screen."
		else
			puts "UI Check : Fail. Signup link is not present at the correct position in Home screen."
		end
		$browser.click "link=Sign up"
		sleep 2
	end
	
	begin
		assert $browser.is_text_present("Create a free account")
		puts "Passed. User has reached the Sign up Modal dialog successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. User didn't reach the Sign up Modal dialog."
	end
	sleep 2
	begin
		assert $browser.is_element_present("css=a.razoo-signup-link > b")
		$browser.click "css=a.razoo-signup-link > b"
		sleep 3
		begin
			assert $browser.is_text_present("By Registering, you agree to the Razoo Terms of Use")
			puts "Passed. User has reached the Email Sign up Modal dialog successfully."
		rescue Test::Unit::AssertionFailedError
			puts "Failed. User didn't reach the Email Sign up Modal dialog."
		end
		puts "Step 1 : Entering  Account creation details"
		$browser.type "id=user_signup_first_name", first_name
		$browser.type "id=user_signup_last_name", last_name
		$browser.type "id=user_email", email_id
		$browser.type "id=user_password", pass_word
		$browser.type "id=user_password_confirmation", pass_word
		begin
			assert_equal "on", $browser.get_value("id=user_signup_mail_opt_in")
			puts "Pass. 'Please send me the Razoo newsletter' checkbox is checked by default."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. 'Please send me the Razoo newsletter' checkbox is not checked by default."
		end
		begin
			assert $browser.is_element_present("css=#signup-razoo > div > div > a.btn-auth.btn-facebook")
			puts "Pass. 'Facebook button is present in the Email modal dialog."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. 'Facebook button is not present in the Email modal dialog."
		end
		begin
			assert $browser.is_element_present("//div[@id='signup-razoo']/div/div[2]/a")
			puts "Pass. 'Google button is present in the Email modal dialog."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. 'Google button is not present in the Email modal dialog."
		end
		$browser.click "xpath=(//button[@type='button'])[2]"
		sleep 25
		$browser.wait_for_page_to_load
		begin
			assert $browser.is_text_present("Your account has been created.")
			puts "Step 2 : Passed. Account has been created successfully!"
		rescue Test::Unit::AssertionFailedError
			begin
				assert $browser.is_text_present("Email is already in use. Log in")
				puts 	"Step 2 : Failed. #{email_id} has already been taken."
			rescue Test::Unit::AssertionFailedError
				puts "@@@@@@@@@ FAILED @@@@@@@@@ Step 2 : Failed. Account not created successfully!"
			end
		end
		begin
			assert $browser.is_element_present("//img[@alt='Your profile picture']")
			$browser.click "//img[@alt='Your profile picture']"
			$browser.wait_for_page_to_load 
			begin
				assert $browser.is_element_present("css=img.photo")
				puts "Pass. Hitler image is present in Profile page."
			rescue Test::Unit::AssertionFailedError
				puts "Fail. Hitler image is not present in Profile page."
			end
			begin
				assert_equal first_name, $browser.get_value("id=user_first_name")
				puts "Pass. #{first_name} is present in the first_name field."
			rescue Test::Unit::AssertionFailedError
				puts "Fail. #{first_name} is not present in the first_name field."
			end
			begin
				assert_equal last_name, $browser.get_value("id=user_last_name")
				puts "Pass. #{last_name} is present in the last_name field."
			rescue Test::Unit::AssertionFailedError
				puts "Fail. #{last_name} is not present in the last_name field."
			end	
			begin
				$user_name = first_name+" "+ last_name
				assert $browser.is_text_present($user_name)
				puts "Step 3 : Passed. #{$user_name} gets displayed in Account screen."
			rescue Test::Unit::AssertionFailedError
				puts "Step 3 : Failed. #{$user_name} doesn't get displayed in Account screen."
			end
			$browser.click "link=Account Settings"
			$browser.wait_for_page_to_load 	
			begin
				assert_equal email_id, $browser.get_value("id=user_email")
				puts "Pass. #{email_id} is present in the email_id field."
			rescue Test::Unit::AssertionFailedError
				puts "Fail. #{email_id} is not present in the email_id field."
			end
		rescue Test::Unit::AssertionFailedError
			puts "Fail. Not able to click on 'User profile image' at the header."
		end
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@ 'use email' option is not present in the Signup modal."
	end
	puts "************** END : Create a Razoo Account ****************"	
end

# ------------------------------------------------------------------------------#
# Description:  This method allows the user to login to Razoo application.
# ------------------------------------------------------------------------------#
def login(email_id, pass_word)
	
	puts "************** START : Login to Razoo ****************"	
	sleep 10
	#***************** Link position check *****************#
	@loginlink_topposition = $browser.get_element_position_top "link=Log in"
	puts "Login link Top position : #{@loginlink_topposition}"
	if @loginlink_topposition == '47' or @loginlink_topposition == '46'
		puts "UI Check : Pass. Login link is present at the correct position in Home screen."
	else
		puts "UI Check : Fail. Login link is not present at the correct position in Home screen."
	end
	$browser.click "link=Log in"
	sleep 2
	puts "Step 1 : Entering valid User credintials - User Name as #{email_id} and Password as #{pass_word}"
	$browser.type "modal_user_session_email", email_id 
	$browser.type "modal_user_session_password", pass_word
	#***************** Button position check *****************#
	@loginbutton_topposition = $browser.get_element_position_top "css=button.submit"
	puts "Login button Top position : #{@loginbutton_topposition}"
	if @loginbutton_topposition == '324' or @loginbutton_topposition == '332'
		puts "UI Check : Pass. Login button is present at the correct position in Login screen."
	else
		puts "UI Check : Fail. Login button is not present at the correct position in Login screen."
	end
	$browser.click "id=modal-login-submit"
	$browser.wait_for_page_to_load
	sleep 15
	begin
		assert $browser.is_text_present("Login successful!")
		puts "Step 2 : Passed. Login was Successful!!!"
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@ Step 2 : Login Failed"
	end
	puts "************** END : Login to Razoo ****************"	
end


# ------------------------------------------------------------------------------#
# Description:  This method allows the user to Reset the password.
# ------------------------------------------------------------------------------#
def changeMyPassword(old_password, new_password)
	
	puts "************** START : Reset my password ****************"	
	
	$browser.click "//img[@alt='Your profile picture']"
	$browser.wait_for_page_to_load 
	sleep 2
	#***************** Link position check *****************#
	@accountsettingslink_topposition = $browser.get_element_position_top "link=Account Settings"
	puts "Account Settings link Top position : #{@accountsettingslink_topposition}"
	if @accountsettingslink_topposition == '185' or @accountsettingslink_topposition == '183'
		puts "UI Check : Pass. AccountSettings link is present at the correct position in MyAccount screen."
	else
		puts "UI Check : Fail. AccountSettings link is not present at the correct position in MyAccount screen."
	end
	$browser.click "link=Account Settings" 
	$browser.wait_for_page_to_load 
	puts "Step 1: Enter password and password confirmation"
	begin
		assert $browser.is_element_present("id=user_current_password")
		puts "Pass. Current Password field is present in the Account Settings screen."
		$browser.type "id=user_current_password", old_password
	rescue Test::Unit::AssertionFailedError
		puts "Fail. Current Password field is not present in the Account Settings screen."
	end
	$browser.type "user_password", new_password
	$browser.type "user_password_confirmation", new_password
	begin
		assert $browser.is_text_present("Send me the monthly Razoo newsletter")
		puts "Fail. 'Send me the monthly Razoo newsletter' checkbox is present in the Razoo/GiveMN Signup screen."
	rescue Test::Unit::AssertionFailedError
		puts "Pass. 'Send me the monthly Razoo newsletter' checkbox is not present in the Razoo/GiveMN Signup screen."
	end
	#***************** Button position check *****************#
	@savechangesbutton_topposition = $browser.get_element_position_top "//button[@type='submit']"
	puts "Save Changes button Top position : #{@savechangesbutton_topposition}"
	if @savechangesbutton_topposition == '426' or @savechangesbutton_topposition == '436'
		puts "UI Check : Pass. SaveChanges button is present at the correct position in AccountSettings screen."
	else
		puts "UI Check : Fail. SaveChanges button is not present at the correct position in AccountSettings screen."
	end
	$browser.click "//button[@type='submit']"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Account updated.")
		puts "Step 2: Passed. Account updated successfully"
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Step 2: Failed. Account not updated successfully."
	end
 
	puts "************** END : Reset my password ****************"	
end


#-------------------------------------------------------------------------#
# Description:  This method allows the user to search ORG
# -------------------------------------------------------------------------#

def searchOrg(org_name,org_url)
	
	$story_name = org_name
	puts "************** START: Search ORG ****************"
	#***************** Button position check *****************#
	@donatebutton_topposition = $browser.get_element_position_top "css=input[type=\"image\"]"
	puts "Donate button Top position : #{@donatebutton_topposition}"
	if @donatebutton_topposition == '92' or @donatebutton_topposition == '8' or @donatebutton_topposition == '93' or @donatebutton_topposition == '10'
		puts "UI Check : Pass. Donate button is present at the correct position in Home screen."
	else
		puts "UI Check : Fail. Donate button is not present at the correct position in Home screen."
	end
	$browser.click "css=input[type=\"image\"]"
	$browser.wait_for_page_to_load
	sleep 2
	$browser.click "link=see all causes"
	$browser.wait_for_page_to_load
	sleep 2
	begin
		assert $browser.is_text_present("Search by Name, Keyword, or ZIP Code")
		begin
		assert $browser.is_element_present("preferredNposOnly")
		$browser.click "preferredNposOnly"
		sleep 5
		rescue Test::Unit::AssertionFailedError
		end
		
		#***************** Checkbox position check *****************#
		@procheckbox_topposition = $browser.get_element_position_top "projectScope"
		puts "Project checkbox Top position : #{@procheckbox_topposition}"
		if @procheckbox_topposition == '224' or @procheckbox_topposition == '189' or @procheckbox_topposition == '227' or @procheckbox_topposition == '192'
			puts "UI Check : Pass. Project checkbox is present at the correct position in Search screen."
		else
			puts "UI Check : Fail. Project checkbox is not present at the correct position in Search screen."
		end
		$browser.click "projectScope"
		sleep 3
		#***************** Checkbox position check *****************#
		@frcheckbox_topposition = $browser.get_element_position_top "widgetScope"
		puts "FR checkbox Top position : #{@frcheckbox_topposition}"
		if @frcheckbox_topposition == '224' or @frcheckbox_topposition == '189' or @frcheckbox_topposition == '227' or @frcheckbox_topposition == '192'
			puts "UI Check : Pass. FR checkbox is present at the correct position in Search screen."
		else
			puts "UI Check : Fail. FR checkbox is not present at the correct position in Search screen."
		end
		$browser.click "widgetScope"
		sleep 3
		puts "Step 1 : Type #{$story_name} in the Search Field"
		$browser.type "parametricKeyword", $story_name
		#***************** Button position check *****************#
		@searchbutton_topposition = $browser.get_element_position_top "//button[@type='submit']"
		puts "Search button Top position : #{@searchbutton_topposition}"
		if @searchbutton_topposition == '177' or @searchbutton_topposition == '142' or @searchbutton_topposition == '179' or @searchbutton_topposition == '144'
			puts "UI Check : Pass. Search button is present at the correct position in Search screen."
		else
			puts "UI Check : Fail. Search button is not present at the correct position in Search screen."
		end
		$browser.click "//button[@type='submit']"
		sleep 12
		puts "Step 2 : Click on #{$story_name} link"
		begin
			assert $browser.is_element_present("link=#{$story_name}")
			$browser.click "//a[contains(text(),'#{$story_name}')]"
			$browser.wait_for_page_to_load
			begin
				assert_equal "#{$story_name} - Razoo", $browser.get_title
				puts "Step 3 : Passed. User reached #{$story_name} Story Page successfully!!"
			rescue Test::Unit::AssertionFailedError
				puts "Step 3 : Failed. Problem in reaching the ORG Story page."
			end
		rescue Test::Unit::AssertionFailedError
			puts "@@@@@@@@@ FAILED @@@@@@@@@. Newly created ORG is not displayed in the search screen."
			$browser.open org_url
		end
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Exception thrown in the search screen."
		$browser.open org_url
	end
	puts "************** END : Search ORG ****************"
end

#-------------------------------------------------------------------------#
# Description:  This method allows the user to search Project.
# -------------------------------------------------------------------------#

def searchProject(project_name)
	
	$story_name = project_name
	begin
		assert $browser.is_text_present("I'm Done")
		$browser.click "css=em"
		$browser.wait_for_page_to_load
		$browser.click "css=a.button > em"
		$browser.wait_for_page_to_load 
	rescue Test::Unit::AssertionFailedError
	end
	puts "************** START: Search PROJECT ****************"
	$browser.click "css=input[type=\"image\"]"
	$browser.wait_for_page_to_load
	sleep 2
	$browser.click "link=see all causes"
	$browser.wait_for_page_to_load
	begin
		assert $browser.is_text_present("Search by Name, Keyword, or ZIP Code")
		begin
			assert $browser.is_element_present("preferredNposOnly")
			$browser.click "preferredNposOnly"
			sleep 5
		rescue Test::Unit::AssertionFailedError
		end
		sleep 2
		#***************** Checkbox position check *****************#
		@orgcheckbox_topposition = $browser.get_element_position_top "orgScope"
		puts "ORG checkbox Top position : #{@orgcheckbox_topposition}"
		if @orgcheckbox_topposition == '142'
			puts "UI Check : Pass. ORG checkbox is present at the correct position in Search screen."
		else
			puts "UI Check : Fail. ORG checkbox is not present at the correct position in Search screen."
		end
		$browser.click "orgScope"
		sleep 3
		puts "Step 1 : Type #{$story_name} in the Search Field"
		$browser.type "parametricKeyword", project_name
		$browser.click "//button[@type='submit']"
		sleep 10
		puts "Step 2 : Click on #{$story_name} link"
		begin
			assert $browser.is_element_present("link=#{$story_name}")
			$browser.click "//a[contains(text(),'#{$story_name}')]"
			$browser.wait_for_page_to_load
			begin
				assert_equal "#{$story_name} - Razoo", $browser.get_title
				puts "Step 3 : Passed. User reached #{$story_name} Story Page successfully!!"
			rescue Test::Unit::AssertionFailedError
				puts "Step 3 : Failed. Problem in reaching the Project Story page."
			end 
		rescue Test::Unit::AssertionFailedError
			puts "@@@@@@@@@ FAILED @@@@@@@@@. Newly created Project is not displayed in the search screen."
			$browser.click "css=img[alt=\"Your profile picture\"]"
			$browser.wait_for_page_to_load 
			$browser.click "link=My Profile"
			$browser.wait_for_page_to_load 
			begin
				assert $browser.is_element_present("link=#{$story_name}")
				puts "Pass. #{$story_name} story link is present in the Profile screen."
				$browser.click "link=#{$story_name}"
				$browser.wait_for_page_to_load 
			rescue Test::Unit::AssertionFailedError
				puts "Fail. #{$story_name} story link is not present in the Profile screen."
			end
		end
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Exception thrown in the search screen."
		$browser.go_back()
		sleep 2
		$browser.click "css=img[alt=\"Your profile picture\"]"
		$browser.wait_for_page_to_load 
		$browser.click "link=My Profile"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_element_present("link=#{$story_name}")
			puts "Pass. #{$story_name} story link is present in the Profile screen."
			$browser.click "link=#{$story_name}"
			$browser.wait_for_page_to_load 
		rescue Test::Unit::AssertionFailedError
			puts "Fail. #{$story_name} story link is not present in the Profile screen."
		end
	end	
		
	puts "************** END : Search PROJECT ****************"
end


#-------------------------------------------------------------------------#
# Description:  This method allows the user to search Fundraise.
# -------------------------------------------------------------------------#

def searchFR(fundraise_name)
	
	$story_name = fundraise_name
	puts "************** START: Search FR ****************"
	$browser.click "//input[@type='image']"
	$browser.wait_for_page_to_load
	$browser.click "link=see all causes"
	$browser.wait_for_page_to_load
	begin
		assert $browser.is_element_present("preferredNposOnly")
		$browser.click "preferredNposOnly"
		sleep 5
	rescue Test::Unit::AssertionFailedError
	end
	$browser.click "orgScope"
	sleep 3
	puts "Step 1 : Type #{$story_name} in the Search Field"
	$browser.type "parametricKeyword", fundraise_name
	$browser.click "//button[@type='submit']"
	sleep 6
	puts "Step 2 : Click on #{$story_name} link"
	$browser.click "//a[contains(text(),'#{$story_name}')]"
	$browser.wait_for_page_to_load
	begin
		assert_equal "#{$story_name} - Razoo", $browser.get_title
		puts "Step 3 : Passed. User reached #{$story_name} Story Page successfully!!"
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Newly created FR is not displayed in the search screen."
		$browser.click "css=img[alt=\"Your profile picture\"]"
		$browser.wait_for_page_to_load 
		$browser.click "link=My Profile"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_element_present("link=#{$story_name}")
			puts "Pass. #{$story_name} story link is present in the Profile screen."
			$browser.click "link=#{$story_name}"
			$browser.wait_for_page_to_load 
		rescue Test::Unit::AssertionFailedError
			puts "Fail. #{$story_name} story link is not present in the Profile screen."
		end
	end
	puts "************** END : Search FR ****************"
end

#-------------------------------------------------------------------------------------------------------------------#
# Description:  This method allows the user to reach the Donation Form screen and Click on 'Sign Up' link.
# ------------------------------------------------------------------------------------------------------------------#

def gotoDonFormClickSignup(donation_amount)
	
	puts "************** START : Goto Donation Form Screen & Click Signup link ****************"
	
	$donation_amount_retain =donation_amount
	puts "Enter donation amount - $#{donation_amount}"
	$browser.type "name=donation[amount]", donation_amount
	$browser.click "id=donate_button"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Security")
		puts "Step 1 : User reached Donation Form page successfully!!"
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Step 1 : Failed. Problem in reaching the Donation Form page."
	end
	
	puts "************** END : Goto Donation Form Screen & Click Signup link ****************"

end


#-------------------------------------------------------------------------------------------------------------------#
# Description:  This method allows the user to reach the Donation Form screen and Click on 'Login' link.
# ------------------------------------------------------------------------------------------------------------------#

def gotoDonFormClickLogin(donation_amount, email_id, pass_word)
	
	puts "************** START : Goto Donation Form Screen & Click Login link ****************"
	
	$donation_amount_retain =donation_amount
	puts "Enter donation amount - $#{donation_amount}"
	sleep 2
	$browser.type "name=donation[amount]", donation_amount
	$browser.click "id=donate_button"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Security")
		puts "Step 1 : User reached Donation Form page successfully!!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 : Failed. Problem in reaching the Donation Form page."
	end
	sleep 2
	begin
		assert $browser.is_text_present("Already Have an Account?")
		puts "Step 2 : Enter valid user credentials - #{email_id} and #{pass_word} "
		$browser.type "user_session_email", email_id 
		$browser.type "user_session_password", pass_word
		#***************** Button position check *****************#
		@loginbutton_topposition = $browser.get_element_position_top "css=div.submit > button[type=\"submit\"]"
		puts "Login button Top position : #{@loginbutton_topposition}"
		if @loginbutton_topposition == '613'
			puts "UI Check : Pass. Login button is present at the correct position in DonationForm screen."
		else
			puts "UI Check : Fail. Login button is not present at the correct position in DonateForm screen."
		end
		$browser.click "css=div.submit > button[type=\"submit\"]"
		$browser.wait_for_page_to_load 
		sleep 10
		begin
			assert $browser.is_text_present("Login successful!")
			puts "Step 3 : Passed. Login was Successful!!!"
		rescue Test::Unit::AssertionFailedError
			puts "Step 3 : Failed. Login Failed."
		end
	rescue
		puts "@@@@@@@@@ FAILED @@@@@@@@@. 'Already Have an Account?' frame is not available."		
	end
	
	puts "************** END : Goto Donation Form Screen & Click Login link ****************"

end

#------------------------------------------------------------------------------------------#
# Description:  This method allows the user to make a donation by using new Card
# -----------------------------------------------------------------------------------------#

def donateUsingNewCard(donation_amount, name_on_card, street, city, state, pin_code, card_number, sec_code, email_id)
	
	puts "************** START : Make a donation using New Card ****************"	
	$email_id = email_id
	sleep 5
	begin
		assert $browser.is_text_present("Your account has been created.")
		begin
			assert $browser.is_text_present($donation_amount_retain)
			puts "Step 1 : Entered amount $#{$donation_amount_retain} gets displayed in the DF screen."
		rescue Test::Unit::AssertionFailedError
			puts "Step 1 : Failed. Incorrect donation amount gets displayed."
		end
		
	rescue Test::Unit::AssertionFailedError
	
		begin
		puts "111"
			sleep 4
			assert $browser.is_text_present("Login successful!")
			assert $browser.is_text_present($donation_amount_retain)
			puts "Step 1 : Entered amount $#{$donation_amount_retain} gets displayed in the DF screen."
		rescue Test::Unit::AssertionFailedError
			sleep 4
			puts "Step 1 : Enter donation amount - $#{donation_amount}"
			$browser.type "name=donation[amount]", donation_amount
			sleep 2
			$browser.click "id=donate_button"
			$browser.wait_for_page_to_load 
			begin
				assert $browser.is_text_present("Security")
				puts "User reached Donation Form page successfully!!"
			rescue Test::Unit::AssertionFailedError
				puts "Failed. Problem in reaching the Donation Form page."
			end
		
			begin
				assert_equal "#{donation_amount}", $browser.get_value("donation_amount")
				puts "Entered amount $#{donation_amount} gets displayed in the DF screen."
			rescue Test::Unit::AssertionFailedError
				puts "Failed. Incorrect donation amount gets displayed."
			end
		end
	end
	sleep 5
	begin
		assert_equal "#{$user_name}", $browser.get_value("order_user_order_credit_card_attributes_full_name")
		puts "Passed. User First name & Last name gets displayed in Name on Card field."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. User First name & Last name doesn't get displayed in Name on Card field."
	end
	begin
		assert $browser.is_element_present("tip_amount_0")
		puts "Failed. Tip section gets displayed in the Donation Form screen."
	rescue
		puts "Passed. Tip section is not displayed in the Donation Form screen."
	end
	$browser.click "add_dedication"
	$browser.type "order_user_order_donations_attributes_0_dedication", "With Dedication"
	sleep 2
	puts "Step 2 : Entering Card Details : User Name - #{$user_name}, Name on Card - #{name_on_card}, #{card_number}, #{$email_id}"
	$browser.type "order_user_order_credit_card_attributes_full_name", name_on_card
	$browser.type "order_user_order_credit_card_attributes_address1", street
	$browser.type "order_user_order_credit_card_attributes_city", city
	$browser.select  "card_state_select", "label=#{state}"
	$browser.type "order_user_order_credit_card_attributes_postal_code", pin_code
	$browser.type "cardNumber", card_number
	$browser.type "order_user_order_credit_card_attributes_security_code", sec_code
	#~ $browser.type "id=order_user_order_email", email_id
	begin
	#GUEST USER AC CREATION 
		assert $browser.is_text_present("Also create an account on ")
		$browser.click "id=create_account"
		$browser.type "order_user_order_email", $email_id
		$browser.click "create_account"
	rescue Test::Unit::AssertionFailedError
		begin
		assert $browser.is_text_present("Store my card and create account for future use")
		$browser.type "order_user_order_email", $email_id
		$browser.click "create_account"
		rescue Test::Unit::AssertionFailedError
		puts "Pass. I'm Logged in user! 'Store my card and create account for future use' checkbox is not present."
		end
	end
	begin
		assert $browser.is_text_present("Your card will be charged $#{donation_amount}")
		puts "Step 3 : Passed. Correct Total amount gets displayed under 'Your card will be charged' section"
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Failed. Incorrect Total amount gets displayed under 'Your card will be charged' section"
	end
	#***************** Button position check *****************#
	@donatenowbutton_topposition = $browser.get_element_position_top "//p[@id='donationSubmit']/button"
	puts "DonateNow button Top position : #{@donatenowbutton_topposition}"
	if @donatenowbutton_topposition == '1305' or @donatenowbutton_topposition == '1256' or @donatenowbutton_topposition == '1222'
		puts "UI Check : Pass. DonateNow button is present at the correct position in DF screen."
	else
		puts "UI Check : Fail. DonateNow button is not present at the correct position in DF screen."
	end
	begin
		assert $browser.is_text_present("I accept the terms of use and privacy policy")
		puts "Pass. 'Terms of use' checkbox is present in the Donation Form screen."
		$browser.click "id=order_user_order_terms_of_use"
	rescue Test::Unit::AssertionFailedError
		puts "Fail. 'Terms of use' checkbox is not present in the Donation Form screen."
	end
	$browser.click "//p[@id='donationSubmit']/button"
	begin
		assert $browser.is_text_present("Processing donation...")
		puts "Processing donation... processing icon Success!!"
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Processing Donation... processing icon is missing."
	end
	$browser.wait_for_page_to_load
	sleep 2
	begin
		assert $browser.is_text_present("Your donation was successful! We'll send you a confirmation email receipt shortly")
		puts "Step 4 : Passed. Donation was Successful! and User reached the Thank You screen."
	rescue Test::Unit::AssertionFailedError
		begin
			assert $browser.is_text_present("Your donation was successful and your account has been created. We'll send you a confirmation receipt shortly.")
			puts "Step 4 : Passed. Donation was Successful! and Guest User Account created and landed in Thank You screen."
		rescue
			puts "@@@@@@@@@ FAILED @@@@@@@@@. Step 4 : Donation is Failed!"
		end
	end
	
	puts "************** END : Make a donation using New Card ****************"	
	
end

#---------------------------------------------------------------------------------------#
# Description:  This method allows the user to make a donation by using new Card
# ---------------------------------------------------------------------------------------#

def donateUsingSavedCard(donation_amount, tip_amount)
	
	puts "************** START : Make a donation using saved Card ****************"	
	sleep 5
	puts "Step 1 : Select donation amount"
	$browser.type "name=donation[amount]", donation_amount
	sleep 2
	$browser.click "id=donate_button"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Security")
		puts "Passed. User reached Donation Form page successfully!!"
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Problem in reaching the Donation Form page."
	end
	begin
		assert_equal donation_amount, $browser.get_value("donation_amount")
		puts "$#{donation_amount} gets displayed in the DF screen."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Incorrect donation amount gets displayed."
	end
	sleep 5
	puts "Step 2 : Provide tip amount of $#{tip_amount}"
	begin
		assert $browser.is_element_present("tip_amount_other")
		puts "Failed. Tip section gets displayed in the Donation Form screen."
	rescue
		puts "Passed. Tip section is not displayed in the Donation Form screen."
	end
	sleep 3	
	begin
		assert $browser.is_text_present("Your card will be charged $#{donation_amount}")
		puts "Step 3 : Passed. Correct Total amount gets displayed under 'Your card will be charged' section"
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Failed. Incorrect Total amount gets displayed under 'Your card will be charged' section"
	end
	begin
		assert $browser.is_text_present("I accept the terms of use and privacy policy")
		puts "Pass. 'Terms of use' checkbox is present in the Donation Form screen."
		$browser.click "id=order_user_order_terms_of_use"
	rescue Test::Unit::AssertionFailedError
		puts "Fail. 'Terms of use' checkbox is not present in the Donation Form screen."
	end
	$browser.click "//p[@id='donationSubmit']/button"
	begin
		assert $browser.is_text_present("Processing donation...")
		puts "Processing donation... processing icon Success!!"
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Processing Donation... processing icon is missing!!!"
	end
	$browser.wait_for_page_to_load
	begin
		assert $browser.is_text_present("Your donation was successful! We'll send you a confirmation email receipt shortly")
		puts "Step 4 : Passed. Donation was Successful! and User reached the Thank You screen."
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Step 4 : Donation is Failed!"
	end

	$browser.click "css=em"
	$browser.wait_for_page_to_load
	$browser.click "css=a.button > em"
	$browser.wait_for_page_to_load 
	
	puts "************** END : Make a donation using Saved Card ****************"	
end

#------------------------------------------------------------------------------------------------------#
# Description:  This method allows the user to make a donation by using Add a new saved Card
# -----------------------------------------------------------------------------------------------------#

def donateUsingAddCreditCard(donation_amount, street, city, state, pin_code,  card_number, sec_code)
	
	puts "************** START : Make a donation using Add Credit Card ****************"	
	sleep 5
	begin
		assert $browser.is_element_present("id=recurring_donation")
		puts "Passed. Recurring donation option gets displayed in the Story page."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Recurring donation option is not displayed in the Story page."
	end
	puts "Step 1 : Enter donation amount - $#{donation_amount}"
	$browser.type "name=donation[amount]", donation_amount
	sleep 2
	$browser.click "id=donate_button"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Security")
		puts "Passed. User reached Donation Form page successfully!!"
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Problem in reaching the Donation Form page."
	end

	begin 
		assert_equal donation_amount, $browser.get_value("donation_amount")
		puts "Step 2 : Selected suggested amount $#{donation_amount} gets displayed in the DF screen."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. Incorrect donation amount gets displayed."
	end
	sleep 5
	puts "Step 3 : Selected a recurring donation in the Donation Form screen"
	$browser.select "id=order_user_order_recurring_donation", "label=Weekly"
	$browser.click "new_credit_card"
	
	begin
		assert_equal "#{$user_name}", $browser.get_value("order_user_order_credit_card_attributes_full_name")
		puts "Passed. User First name & Last name gets displayed in Name on Card field."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. User First name & Last name doesn't get displayed in Name on Card field."
	end
		
	begin
		assert $browser.is_element_present("tip_amount_0")
		puts "Failed. Tip section gets displayed in the Donation Form screen."
	rescue
		puts "Passed. Tip section is not displayed in the Donation Form screen."
	end
	$browser.click "add_designation"
	$browser.type "order_user_order_donations_attributes_0_designation", "With Designation"
	$browser.click "add_dedication"
	$browser.type "order_user_order_donations_attributes_0_dedication", "With Dedication"
	
	puts "Step 4 : Entering New Card Details : #{$user_name}, #{card_number}"
	$browser.type "order_user_order_credit_card_attributes_address1", street
	$browser.type "order_user_order_credit_card_attributes_city", city
	$browser.select "card_state_select", "label=#{state}"
	$browser.type "order_user_order_credit_card_attributes_postal_code", pin_code
	$browser.type "cardNumber", card_number
	$browser.type "order_user_order_credit_card_attributes_security_code", sec_code
	$browser.click "order_user_order_donations_attributes_0_disclosure"
	
	begin
		assert $browser.is_text_present("Your card will be charged $#{donation_amount}")
		puts "Step 5 : Passed. Correct Total amount gets displayed under 'Your card will be charged' section"
	rescue Test::Unit::AssertionFailedError
		puts "Step 5 : Failed. Incorrect Total amount gets displayed under 'Your card will be charged' section"
	end
	begin
		assert $browser.is_text_present("I accept the terms of use and privacy policy")
		puts "Pass. 'Terms of use' checkbox is present in the Donation Form screen."
		$browser.click "id=order_user_order_terms_of_use"
	rescue Test::Unit::AssertionFailedError
		puts "Fail. 'Terms of use' checkbox is not present in the Donation Form screen."
	end
	$browser.click "//p[@id='donationSubmit']/button"
	begin
		assert $browser.is_text_present("Processing donation...")
		puts "Processing donation... processing icon Success!!"
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Processing Donation... processing icon is missing."
	end
	$browser.wait_for_page_to_load
	begin
		assert $browser.is_text_present("Your donation was successful! We'll send you a confirmation email receipt shortly")
		puts "Step 6 : Passed. Donation was Successful! and User reached the Thank You screen."
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Step 6 : Donation is Failed!"
	end
		
	puts "************** END : Make a donation using Saved Card ****************"
end

# -------------------------------------------------------------------------------------------------------------#
# Description:  This method allows the User to verify his donation under 'My Donation' screen and 
#								verify category icons in Profile screen.
# -------------------------------------------------------------------------------------------------------------#
  
def checkMydonation(donation_amount, org_name)
	
	puts "************** START : Check My Donation ****************"
	
	#***************** Link position check *****************#
	@myaccountlink_topposition = $browser.get_element_position_top "//img[@alt='Your profile picture']"
	puts "My Account link Top position : #{@myaccountlink_topposition}"
	if @myaccountlink_topposition == '7'
		puts "UI Check : Pass. MyAccount link is present at the correct position in Home screen."
	else
		puts "UI Check : Fail. MyAccount link is not present at the correct position in Home screen."
	end
	sleep 3
	$browser.click "//img[@alt='Your profile picture']"
	$browser.wait_for_page_to_load 
	begin
		puts "Step 1 : Verify ORG category icons in the Profile screen."
		assert $browser.is_element_present("css=img[alt=\"Animals\"]")
		puts "Pass. Animals category icon is displayed in the Profile screen."
		
		$browser.click "css=img[alt='Animals']"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_text_present("Animals")
			puts "Pass. Animal heading is displayed under 'supported the following causes' section."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. Animal heading is not displayed under 'supported the following causes' section."
		end
		begin
			assert $browser.is_element_present("link=#{org_name}")
			puts "Pass. #{org_name} link is present under 'supported the following causes' section."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. #{org_name} link is not present under 'supported the following causes' section."
		end
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@ Animals category icon is not displayed for #{org_name} ORG in Profile screen."
	end
	$browser.click "link=My Profile"
	$browser.wait_for_page_to_load 
	begin
		puts "Step 2 : Verify Default help text in the Profile screen."
		assert $browser.is_text_present("Your profile is currently blank. Click here to update your profile.")
		puts "Pass. 'Your profile is currently blank...' help text is displayed in the Profile screen for this user."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. 'Your profile is currently blank...' help text is not displayed in the Profile screen for this user."
	end
	puts "Step 3 : Verify donation details under Recent Activity Recent Activity section."
	begin
		assert $browser.is_text_present("Donated by me")
		puts "Success!. My donation record gets displayed under 'Recent Activity' section."
	rescue Test::Unit::AssertionFailedError
		puts "Failure!. My donation record is not displayed under 'Recent Activity' section."
	end
	begin
		assert $browser.is_text_present("$#{donation_amount}")
		puts "Success!. My donation Amount gets displayed under 'Recent Activity' screen."
	rescue Test::Unit::AssertionFailedError
		puts "Failure!. My donation Amount doesn't get displayed under 'Recent Activity' screen."
	end
	#***************** Link position check *****************#
	@mydonationslink_topposition = $browser.get_element_position_top "link=My Donations"
	puts "Mydonations link Top position : #{@mydonationslink_topposition}"
	if @mydonationslink_topposition == '185'
		puts "UI Check : Pass. Mydonations link is present at the correct position in Account screen."
	else
		puts "UI Check : Fail. Mydonations link is not present at the correct position in Account screen."
	end
	puts "Step 4 : Verify donation details under Donation History section."
	$browser.click "link=My Donations"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("$#{donation_amount}.00")
		puts "Success!. My donation Amount gets displayed under 'My Donation' screen."
	rescue Test::Unit::AssertionFailedError
		puts "Failure!. My donation Amount doesn't get displayed under 'My Donation' screen."
	end
	
	puts "************** END : Check My Donation ****************"

end

# ------------------------------------------------------------------------------------------------#
# Description:  This method allows the User to verify his saved credit card.
# ------------------------------------------------------------------------------------------------#

def verifyGuestUserSavedCard()
	
	puts "************** START : Check Guest User Saved Card ****************"
	begin
		assert $browser.is_element_present("link=My Saved Cards")
		$browser.click "link=My Saved Cards"
		$browser.wait_for_page_to_load
		begin
			assert $browser.is_text_present("XXXX   XXXX   XXXX   1111")
			puts "Pass. Ending with 1111 Visa card is present in the Saved Card list."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. Ending with 1111 Visa card is not present in the Saved Card list."
		end
		begin
			assert $browser.is_element_present("css=img[alt=\"Visa\"]")
			puts "Pass. Visa logo image is present on the Saved Card."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. Visa logo image is not present on the Saved Card."
		end
	rescue
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Guest User's Card is not stored in Profile screen."
	end
	puts "************** END : Check Guest User Saved Card ****************"
	
end

#------------------------------------------------------------------------------------------------------#
# Description:  This method allows the user to make a donation through Donation Widget.
# -----------------------------------------------------------------------------------------------------#

def donationWidget(donation_amount, widget_emailid, widget_fullname, widget_street, widget_city, widget_state, widget_pcode, card_number, sec_code, tip_amount)
	
	puts "************** START : Donation Widget ****************"
	$browser.click "link=Share"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_element_present("link=Customize the Donation Widget")
		puts "Pass. 'Customize the Donation Widget' link is present in the DW screen."
		$browser.click "link=Customize the Donation Widget"
		sleep 2
		$browser.click "link=add another amount"
		$browser.type "name=story[donation_suggestion_levels][3]", "12"
		$browser.type "name=story[donation_suggestion_descriptions][3]", "Suggested Description"
		$browser.click "link=add another amount"
		$browser.type "name=story[donation_suggestion_levels][4]", "13"
		$browser.type "name=story[donation_suggestion_descriptions][4]", "Suggested Description"
		$browser.click "link=add another amount"
		$browser.type "name=story[donation_suggestion_levels][5]", "14"
		$browser.type "name=story[donation_suggestion_descriptions][5]", "Suggested Description"
		$browser.click "link=add another amount"
		$browser.type "name=story[donation_suggestion_levels][6]", "15"
		$browser.type "name=story[donation_suggestion_descriptions][6]", "Suggested Description"
		$browser.click "css=button[type=\"submit\"]"
		sleep 1
	rescue
		puts "@@@@@@@@@ FAILED @@@@@@@@@. 'Customize the Donation Widget' link is not present in the DW screen."
	end	
		
	puts "Step 1 : Enter donation amount in the First screen."
	$browser.click "id=amount_other"
	$browser.click "id=option_other"
	$browser.type "id=amount_other", donation_amount
	#***************** Button position check *****************#
	@donatenowbutton_topposition = $browser.get_element_position_top "css=#donation > a.button > em"
	puts "DonateNow button Top position : #{@donatenowbutton_topposition}"
	if @donatenowbutton_topposition == '442'
		puts "UI Check : Pass. DonateNow button is present at the correct position in DonateAnywhere screen."
	else
		puts "UI Check : Fail. DonateNow button is not present at the correct position in DonateAnywhere screen."
	end
	$browser.click "css=#donation > a.button > em"
	sleep 2
	puts "Step 2 : Enter Billing details in the Second screen."
	begin
		assert $browser.is_element_present("order_user_order_email")
		$browser.type "order_user_order_email", widget_emailid
		puts "Fail. EmailId field is present in the Donation Widget screen for a loggedin user."
	rescue
		puts "Pass. EmailId field is not present in the Donation Widget screen for a loggedin user."
	end	
	$browser.type "order_user_order_credit_card_attributes_full_name", widget_fullname
	$browser.type "order_user_order_credit_card_attributes_address1", widget_street
	$browser.type "order_user_order_credit_card_attributes_city", widget_city
	$browser.select "order_user_order_credit_card_attributes_state", widget_state
	$browser.type "order_user_order_credit_card_attributes_postal_code", widget_pcode
	#***************** Button position check *****************#
	@carddetailsbutton_topposition = $browser.get_element_position_top "//div[@id='billing']/a[2]/em"
	puts "CardDetails button Top position : #{@carddetailsbutton_topposition}"
	if @carddetailsbutton_topposition == '442'
		puts "UI Check : Pass. CardDetails button is present at the correct position in DonateAnywhere screen."
	else
		puts "UI Check : Fail. CardDetails button is not present at the correct position in DonateAnywhere screen."
	end
	$browser.click "//div[@id='billing']/a[2]/em"
	sleep 2
	
	puts "Step 3 : Enter Card details in the Third screen."
	$browser.type "order_user_order_credit_card_attributes_card_number", card_number
	$browser.type "order_user_order_credit_card_attributes_security_code", sec_code
	begin
		assert $browser.is_element_present("tip_amount_other")
		$browser.click "tip_amount_other"
		$browser.type "tip_other_amount", tip_amount
		$browser.click "tip_amount_0"
		$browser.click "tip_amount_other"
		$browser.type "tip_other_amount", tip_amount
		total_amount = (donation_amount.to_i)+(tip_amount.to_i)
		begin
			assert $browser.is_text_present("#{total_amount}")
			puts "Correct total amount(including Tip) - $#{total_amount} gets displayed."
		rescue Test::Unit::AssertionFailedError
			puts "Incorrect total amount(including Tip) gets displayed."
		end
	rescue Test::Unit::AssertionFailedError
		puts "Tip option is not displayed in the donation widget."
	end
	#***************** Button position check *****************#
	@paynowbutton_topposition = $browser.get_element_position_top "//button[@type='submit']"
	puts "PayNow button Top position : #{@paynowbutton_topposition}"
	if @paynowbutton_topposition == '1338' or @paynowbutton_topposition == '1361'
		puts "UI Check : Pass. PayNow button is present at the correct position in DonateAnywhere screen."
	else
		puts "UI Check : Fail. PayNow button is not present at the correct position in DonateAnywhere screen."
	end
	$browser.click "id=order_user_order_terms_of_use"
	$browser.click "//button[@type='submit']"
	sleep 1
	begin
		assert_equal "Facebook", $browser.get_text("link=Facebook")
		puts "Step 4 : Donation was successful. Thank you screen gets displayed."
	rescue Test::Unit::AssertionFailedError
		puts "Step 4 : Donation was Failed."
	end
	begin
		assert_equal "Facebook", $browser.get_text("link=Facebook")
		puts "Passed. Facebook link is present in the Thank You screen."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Facebook link is missing in the Thank You screen."
	end
	begin
		assert_equal "Twitter", $browser.get_text("link=Twitter")
		puts "Passed. Twitter link is present in the Thank You screen."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Twitter link is missing in the Thank You screen."
	end
	
	
	puts "************** END : Donation Widget ****************"

end


# --------------------------------------------------------------------------------------------------------#
# Description:  This method allows the story admin to create an Offline donation to story page.
# --------------------------------------------------------------------------------------------------------#
  
def createOfflineDonation(offline_donorname, offline_donoremail, offline_donoramount)
	
	puts "************** START : Create Offline donation ****************"
	puts "Click on Offline Donations link in the Story page."
	$browser.click "link=Donations"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_element_present("link=Offline Donations")
		#***************** Link position check *****************#
		@offlinelink_topposition = $browser.get_element_position_top "link=Offline Donations"
		puts "Offline link Top position : #{@offlinelink_topposition}"
		if @offlinelink_topposition == '291' or @offlinelink_topposition == '289' or @offlinelink_topposition == '287'
			puts "UI Check : Pass. Offline link is present at the correct position in Story screen."
		else
			if @offlinelink_topposition == '244'
				puts "UI Check : Pass. Offline link is present at the correct position in Story screen(Team)."
			else
				puts "UI Check : Fail. Offline link is not present at the correct position in Story screen(Team)."
			end
		end
		$browser.click "link=Offline Donations"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_text_present("Offline Donations")
			puts "Step 1 : User has successfully reached the Offline donations screen."
		rescue Test::Unit::AssertionFailedError
			puts "Step 1 : User has failed to reach the Offline donations screen."
		end
		$browser.type "offline_donation_name", offline_donorname
		$browser.type "offline_donation_email", offline_donoremail
		$browser.type "offline_donation_amount", offline_donoramount
		#***************** Button position check *****************#
		@addonationbutton_topposition = $browser.get_element_position_top "//button[@type='submit']"
		puts "Addonation button Top position : #{@addonationbutton_topposition}"
		if @addonationbutton_topposition == '601' or @addonationbutton_topposition == '599' or @addonationbutton_topposition == '293'
			puts "UI Check : Pass. Add donation button is present at the correct position in Offline screen."
		else
			if @addonationbutton_topposition == '554' or @addonationbutton_topposition == '575'
				puts "UI Check : Pass. Add donation button is present at the correct position in Offline screen(Team)."
			else
				puts "UI Check : Fail. Add donation button is not present at the correct position in Offline screen(Team)."
			end
		end
		$browser.click "//button[@type='submit']"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_text_present("The donation has been added.")
			puts "Step 2 : Passed. Offline donations gets successfully added."
		rescue Test::Unit::AssertionFailedError
			puts "@@@@@@@@@ FAILED @@@@@@@@@. Step 2 : Offline donations doesn't get added successfully."
		end
		#***************** Link position check *****************#
		@viewlink_topposition = $browser.get_element_position_top "link=View"
		puts "View link Top position : #{@viewlink_topposition}"
		if @viewlink_topposition == '313' or @viewlink_topposition == '311' or @viewlink_topposition == '308'
			puts "UI Check : Pass. View link is present at the correct position in Story screen."
		else
			puts "UI Check : Fail. View link is not present at the correct position in Story screen."
			
		end
		$browser.click "link=View"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_text_present("$#{offline_donoramount} offline")
			puts "Step 3 : Passed. Offline donations gets displayed under Thermometer frame."
		rescue Test::Unit::AssertionFailedError
			puts "Step 3 : Failed. Offline donations doesn't get displayed under Thermometer frame."
		end
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Offline link is not available for this story page."
	end
	
	puts "************** END : Create Offline donation ****************"
	
end

# ------------------------------------------------------------------------------------------------------------#
# Description:  This method allows the Team admin to create an Team Offline donation to story page.
# ------------------------------------------------------------------------------------------------------------#
  
def createTeamOfflineDonation(modified_camp_url, normal2_firstname, normal2_lastname, camp_title, offline_donorname, offline_donoremail, offline_donoramount)
	
	puts "************** START : Create Team Offline donation ****************"
	$browser.open modified_camp_url
	$browser.wait_for_page_to_load 
	puts "Click on Offline Donations link in the Story page."
	$browser.click "link=Donations"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_element_present("link=Offline Donations")
		#***************** Link position check *****************#
		@offlinelink_topposition = $browser.get_element_position_top "link=Offline Donations"
		puts "Offline link Top position : #{@offlinelink_topposition}"
		if @offlinelink_topposition == '291' or @offlinelink_topposition == '289' or @offlinelink_topposition == '287'
			puts "UI Check : Pass. Offline link is present at the correct position in Story screen."
		else
			if @offlinelink_topposition == '244'
				puts "UI Check : Pass. Offline link is present at the correct position in Story screen(Team)."
			else
				puts "UI Check : Fail. Offline link is not present at the correct position in Story screen(Team)."
			end
		end
		$browser.click "link=Offline Donations"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_text_present("Manage Offline Donations for:")
			puts "Step 1 : User has successfully reached the Team Offline donations screen."
		rescue Test::Unit::AssertionFailedError
			puts "Step 1 : User has failed to reach the Team Offline donations screen."
		end
		sleep 2
		begin
			assert $browser.is_element_present("link=#{normal2_firstname}"+" "+"#{normal2_lastname},"+" "+"#{normal2_firstname}"+" "+"#{normal2_lastname} fundraising for #{camp_title}")
			puts "Pass. #{normal2_firstname}"+" "+"#{normal2_lastname},"+" "+"#{normal2_firstname}"+" "+"#{normal2_lastname} fundraising for #{camp_title} link is present in the Team Offline page."
			$browser.click "link=#{normal2_firstname}"+" "+"#{normal2_lastname},"+" "+"#{normal2_firstname}"+" "+"#{normal2_lastname} fundraising for #{camp_title}"
			$browser.wait_for_page_to_load
			begin
				assert $browser.is_element_present("link=#{normal2_firstname}"+" "+"#{normal2_lastname} fundraising for #{camp_title}")
				puts "Pass. Used has reached the Team FR page successfully."
			rescue
				puts "Fail. Used had failed to reach the Team FR page successfully."
			end
			$browser.type "offline_donation_name", offline_donorname
			$browser.type "offline_donation_email", offline_donoremail
			$browser.type "offline_donation_amount", offline_donoramount
			#***************** Button position check *****************#
			@addonationbutton_topposition = $browser.get_element_position_top "//button[@type='submit']"
			puts "Addonation button Top position : #{@addonationbutton_topposition}"
			if @addonationbutton_topposition == '601' or @addonationbutton_topposition == '599' or @addonationbutton_topposition == '293'
				puts "UI Check : Pass. Addonation button is present at the correct position in Offline screen."
			else
				if @addonationbutton_topposition == '554' or @addonationbutton_topposition == '575'
					puts "UI Check : Pass. Add donation button is present at the correct position in Offline screen(Team)."
				else
					puts "UI Check : Fail. Add donation button is not present at the correct position in Offline screen(Team)."
				end
			end
			$browser.click "//button[@type='submit']"
			$browser.wait_for_page_to_load 
			begin
				assert $browser.is_text_present("The donation has been added.")
				puts "Step 2 : Passed. Offline donations gets successfully added."
			rescue Test::Unit::AssertionFailedError
				puts "@@@@@@@@@ FAILED @@@@@@@@@. Step 2 : Offline donations doesn't get added successfully."
			end
			#***************** Link position check *****************#
			@viewlink_topposition = $browser.get_element_position_top "link=View"
			puts "View link Top position : #{@viewlink_topposition}"
			if @viewlink_topposition == '313' or @viewlink_topposition == '311' or @viewlink_topposition == '308'
				puts "UI Check : Pass. View link is present at the correct position in Story screen."
			else
				puts "UI Check : Fail. View link is not present at the correct position in Story screen."
				
			end
			$browser.click "link=View"
			$browser.wait_for_page_to_load 
			begin
				assert $browser.is_text_present("$#{offline_donoramount} offline")
				puts "Step 3 : Passed. Offline donations gets displayed under Thermometer frame of Team page."
			rescue Test::Unit::AssertionFailedError
				puts "Step 3 : Failed. Offline donations doesn't get displayed under Thermometer frame of Team page."
			end
		rescue
		puts "Fail. Correct Team FR link is not available for this Team page."
		end
	rescue Test::Unit::AssertionFailedError
	puts "@@@@@@@@@ FAILED @@@@@@@@@. Offline link is not available for this story page (Team)."
	end
	
	puts "************** END : Create Team Offline donation ****************"
	
end


# ------------------------------------------------------------------------------------------------#
# Description:  This method allows the Normal User to share the story page thorugh Email.
# ------------------------------------------------------------------------------------------------#
  
def normalUserSharePage()
	
	puts "************** START : Share page - Normal User ****************"	
	
	begin
		assert $browser.is_text_present("Thank you for your generosity!")
		puts "Passed. User has successfully reached the Comment page."
	rescue Test::Unit::AssertionFailedError
		puts "Failed to reach the Comment page."
	end
	#***************** Link position check *****************#
	@imdonelink_topposition = $browser.get_element_position_top "css=a.button > em"
	puts "Mydonations link Top position : #{@imdonelink_topposition}"
	if @imdonelink_topposition == '583' or @imdonelink_topposition == '548' or @imdonelink_topposition == '585'
		puts "UI Check : Pass. Imdone link is present at the correct position in Share screen."
	else
		puts "UI Check : Fail. Imdone link is not present at the correct position in Share screen."
	end
	sleep 2
	$browser.click "css=a.button > em"
	$browser.wait_for_page_to_load 
	
	puts "************** END : Share page - Normal User ****************"	
end


# --------------------------------------------------------------------------------------#
# Description:  This method allows the user to post and verify the comments.
# --------------------------------------------------------------------------------------#
  
def postComments(donor_comment)
	
	puts "************** START : Post Comment ****************"	
	sleep 2
	begin
		assert $browser.is_text_present("exact:What's worth sharing?")
		puts "Passed. User has successfully reached the Share page."
	rescue Test::Unit::AssertionFailedError
		puts "Failed to reach the Share page."
	end
	
	begin
		assert $browser.is_text_present("A share on Facebook generates another $18 in donations on average.")
		puts "Passed. $18 content is displayed in the Share page."
	rescue Test::Unit::AssertionFailedError
		puts "Failed to displaye the $18 content in the Share page."
	end
	
	$browser.click "css=em"
	$browser.wait_for_page_to_load 
	sleep 2
	$browser.type "comment_body", donor_comment
	#***************** Button position check *****************#
	@postbutton_topposition = $browser.get_element_position_top "comment_form_submit"
	puts "Post button Top position : #{@postbutton_topposition}"
	if @postbutton_topposition == '322' or @postbutton_topposition == '804' or @postbutton_topposition == '310' or @postbutton_topposition == '335'
		puts "UI Check : Pass. Post button is present at the correct position in ThankYou screen."
	else
		puts "UI Check : Fail. Post button is not present at the correct position in ThankYou screen."
	end
	$browser.click "comment_form_submit"
	sleep 4
	begin
		assert $browser.is_text_present("Thank you, your message has been posted")
		puts "Step 1 : Passed. Donor's comment posted Successfully."
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Step 1 : Failed while posting the comment."
	end
	
	begin
		assert $browser.is_text_present("(Warning: your name will be posted with your comment.)")
		puts "Passed. User has successfully reached the Comment page."
	rescue Test::Unit::AssertionFailedError
		puts "Failed to reach the Comment page."
	end
	
	$browser.click "css=a.button > em"
	$browser.wait_for_page_to_load
	
	begin
		assert $browser.is_element_present("//img[@alt='Your profile picture']")
		$browser.click "//img[@alt='Your profile picture']"
		$browser.wait_for_page_to_load
		sleep 5
		$browser.click "link=My Profile"
		$browser.wait_for_page_to_load
		begin
			assert $browser.is_text_present(donor_comment)
			puts "Step 2 : Passed. Posted comment is displayed successfully in My Profile screen."
		rescue Test::Unit::AssertionFailedError
			puts "Step 2 : Failed. Posted comment doesn't get displayed in My Profile screen."
		end
	rescue
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Profile picture icon is not displayed at the header."
	end
	puts "************** END : Post Comment ****************"	
end

# --------------------------------------------------------------------------------------#
# Description:  This method allows the user to delete the comments.
# --------------------------------------------------------------------------------------#


def deleteComments(donor_comment)
	
	puts "************** START : Delete Comment ****************"	
	#***************** Link position check *****************#
	@nothankslink_topposition = $browser.get_element_position_top "css=em"
	puts "No Thanks link Top position : #{@nothankslink_topposition}"
	if @nothankslink_topposition == '688' or @nothankslink_topposition == '661'
		puts "UI Check : Pass. NoThanks link is present at the correct position in ThankYou screen."
	else
		puts "UI Check : Fail. NoThanks link is not present at the correct position in ThankYou screen."
	end
	$browser.click "css=em"
	$browser.wait_for_page_to_load 
	$browser.click "css=a.button > em"
	$browser.wait_for_page_to_load 
	sleep 2
	$browser.type "comment_body", "Link Comment"
	$browser.click "link=Link"
	sleep 2
	$browser.type "comment_link", "http://www.youtube.com/watch?v=giIWXZbyT1o"
	$browser.click "comment_form_submit"
	sleep 15
	begin
		assert $browser.is_text_present("Thank you, your message has been posted")
		puts "Step 1 : Passed. Donor's comment posted Successfully!!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 : Failed in posting the comment."
	end
	
	begin
		assert $browser.is_text_present("exact:http://www.youtube.com/watch?v=giIWXZbyT1o")
		puts "Step 2 : Passed. Posted link gets displayed successfully under comment section."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. Posted link doesn't get displayed successfully under comment section."
	end
	
	$browser.type "comment_body", donor_comment
	$browser.click "link=Video"
	sleep 2
	$browser.type "comment_new_video_url", "http://www.youtube.com/watch?v=giIWXZbyT1o"
	begin
		assert $browser.is_element_present("//img[@alt='Youtube']")
		puts "Pass. Youtube image icon is displayed."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. Youtube image icon is not displayed."
	end
	begin
		assert $browser.is_element_present("//img[@alt='Vimeo']")
		puts "Pass. Vimeo image icon is displayed."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. Vimeo image icon is not displayed."
	end
	$browser.click "comment_form_submit"
	sleep 15
	$browser.click "//div[@id='comments']/div/ol/li[1]/div[2]/a/img"
	assert /^Are you sure you want to delete this comment[\s\S]$/ =~ $browser.get_confirmation
	sleep 10
	begin
		assert $browser.is_text_present("Your comment has been deleted.")
		puts "Step 3: Passed. Successfully deleted the posted comment."
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Step 3 : Couldnt able to delete the posted comment."
	end
	sleep 5
	$browser.click "//img[@alt='Your profile picture']"
	$browser.wait_for_page_to_load
	sleep 5
	$browser.click "link=My Profile"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present(donor_comment)
		puts "Step 4 : Failed. Deleted comment gets displayed in My Account screen."
	rescue Test::Unit::AssertionFailedError
		puts "Step 4 : Passed. Deleted comment doesn't gets displayed in My Account screen."
	end

	puts "************** END : Delete Comment ****************"	
end


# -------------------------------------------------------------------------------------------#
# Description:  This method allows the user to cancel the recurring donation.
# -------------------------------------------------------------------------------------------#
  
def cancelRecurringDonation()
	
	puts "************** START : Cancel the Recurring Donation ****************"
	$browser.click "//img[@alt='Your profile picture']"
	$browser.wait_for_page_to_load
	#***************** Link position check *****************#
	@savedcardlink_topposition = $browser.get_element_position_top "link=My Saved Cards"
	puts "SavedCards link Top position : #{@savedcardlink_topposition}"
	if @savedcardlink_topposition == '185'
		puts "UI Check : Pass. SavedCards link is present at the correct position in Account screen."
	else
		puts "UI Check : Fail. SavedCards link is not present at the correct position in Account screen."
	end
	sleep 5
	$browser.click "link=My Saved Cards"
	$browser.wait_for_page_to_load 
	sleep 5
	begin
		assert $browser.is_element_present("link=cancel the donation")
		$browser.click "link=cancel the donation"
		$browser.wait_for_page_to_load 
		sleep 5
		$browser.click "link=stop donations"
		$browser.wait_for_page_to_load 
		assert /^Are you sure you want to delete this recurring donation[\s\S]$/ =~ $browser.get_confirmation
		sleep 5
		begin
			assert $browser.is_text_present("The scheduled donation was canceled.")
			puts "Passed. The scheduled donation was successfully canceled."
		rescue Test::Unit::AssertionFailedError
			puts "Failed. The scheduled donation was not canceled."
		end
	rescue Test::Unit::AssertionFailedError
	
	end
	
	puts "************** END : Cancel the Recurring Donation ****************"	
	
end

# -------------------------------------------------------------------------------------------#
# Description:  This method allows the user to delete the .
# -------------------------------------------------------------------------------------------#
  
def deleteStoredCard()
	
	puts "************** START : Delete my Stored Card ****************"	
	
	$browser.click "link=My Saved Cards"
	$browser.wait_for_page_to_load 
	sleep 5
	$browser.click "commit"
	$browser.wait_for_page_to_load 
	assert /^Delete this credit card[\s\S]$/ =~ $browser.get_confirmation
	sleep 5
	begin
		assert $browser.is_text_present("Your credit card has been deleted.")
		puts "Passed. My 1st Credit card has been deleted successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. My 1st Credit card is not deleted successfully."
	end
	begin
		assert $browser.is_text_present("You do not have any saved credit cards.")
	rescue Test::Unit::AssertionFailedError
		sleep 5
		$browser.click "commit"
		$browser.wait_for_page_to_load 
		assert /^Delete this credit card[\s\S]$/ =~ $browser.get_confirmation
		sleep 5
		begin
			assert $browser.is_text_present("Your credit card has been deleted.")
			puts "Passed. My 2nd Credit card has been deleted successfully."
		rescue Test::Unit::AssertionFailedError
			puts "Failed. My 2nd Credit card is not deleted successfully."
		end
	end
	sleep 5
	begin
		assert $browser.is_text_present("You do not have any saved credit cards.")
		puts "Passed. There is no saved credit cards in Saved Card screen."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. There is still deleted credit cards displayed in Saved Card screen."
	end

	puts "************** END : Delete my Stored Card ****************"	
end

# --------------------------------------------------------------------------------------#
# Description:  This method allows the Normal user to create a Story page.
# --------------------------------------------------------------------------------------#

def createStoryPage(ein_number, org_name, story_name, story_summary, page_story, youtube_url, desig_value, goal_amount,  goal_date, admin_links, sug_amount, sug_desc)
	
	puts "************** START : Create Story Page ****************"	
	#------------CREATING PROJECT PAGE-------------------------------#
	begin
		assert $browser.is_element_present("link=My organization")
		begin
			assert $browser.is_text_present("My organization")
			puts "Pass. My organization link is displayed at the header."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. My organization link is not displayed at the header."
		end
		#***************** Link position check *****************#
		@mynpolink_topposition = $browser.get_element_position_top "link=My organization"
		puts "MyORG link Top position : #{@mynpolink_topposition}"
		if @mynpolink_topposition == '12'
			puts "UI Check : Pass. My organization link is present at the correct position in Home screen."
		else
			puts "UI Check : Fail. My organization link is not present at the correct position in Home screen."
		end
		$browser.click "link=My organization"
		$browser.wait_for_page_to_load 
		sleep 3
		$browser.click "link=Get Started!"
		$browser.wait_for_page_to_load
		begin
			assert $browser.is_element_present("id=charity_fundraiser_button")
			puts "Pass. charity_fundraiser_button is displayed in the story new page"
			$browser.click "id=charity_fundraiser_button"
		rescue Test::Unit::AssertionFailedError
			puts "Fail. charity_fundraiser_button is not displayed in the story new page"
		end
		
	rescue
	#------------CREATING FUNDRAISING PAGE-------------------------------#
		sleep 5
		$browser.click "link=Get Started!"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_element_present("id=charity_fundraiser_button")
			puts "Pass. charity_fundraiser_button is displayed in the story new page"
			$browser.click "id=charity_fundraiser_button"
		rescue Test::Unit::AssertionFailedError
			puts "Fail. charity_fundraiser_button is not displayed in the story new page"
		end
	end
	puts "Step 1 : Entering valid details for creating Story page"
	$browser.type "xpath=(//input[@id='story_title'])[2]", story_name
	$browser.click "css=#storyForm > div.submit > p > button[type=\"submit\"]"
	begin
		assert $browser.is_text_present("Creating page...")
		puts "Creating page... processing icon Success!!"
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Creating page... processing icon is missing."
	end
	$browser.wait_for_page_to_load
	begin
		assert $browser.is_text_present("This title is already being used by another nonprofit, project, or fundraiser")
		puts "Failed. #{story_name} is already being used by another nonprofit, project, or fundraiser. Try using a different name."
	rescue Test::Unit::AssertionFailedError
	end
	begin
		assert $browser.is_text_present("Congratulations, your page has been created!")
		puts "Step 2 : Passed. #{story_name} created successfully!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. #{story_name} creation failed!"
	end
	
	begin
		assert $browser.is_element_present("link=Tell Your Story")
		puts "Step 3 : Passed. Tell Your Story link is displayed under FR/PRO Completion Steps section."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Failed. Tell Your Story link is not displayed under FR/PRO Completion Steps section."
	end
	begin
		assert $browser.is_element_present("link=Illustrate Your Story")
		puts "Step 4 : Passed. Illustrate Your Story link is displayed under FR/PRO Completion Steps section."
	rescue Test::Unit::AssertionFailedError
		puts "Step 4 : Failed. Illustrate Your Story link is not displayed under FR/PRO Completion Steps section."
	end
	begin
		assert $browser.is_element_present("link=Set Your Goals")
		puts "Step 5 : Passed. Set Your Goals link is displayed under FR/PRO Completion Steps section."
	rescue Test::Unit::AssertionFailedError
		puts "Step 5 : Failed. Set Your Goals link is not displayed under FR/PRO Completion Steps section."
	end
	begin
		assert $browser.is_element_present("link=Share It With Others")
		puts "Step 6 : Passed. Share It With Others link is displayed under FR/PRO Completion Steps section."
	rescue Test::Unit::AssertionFailedError
		puts "Step 6 : Failed. Share It With Others link is not displayed under FR/PRO Completion Steps section."
	end
	
	$browser.click "link=Edit"
	$browser.wait_for_page_to_load 
	sleep 5
	$browser.type "story_short_description", story_summary	
	$browser.type "tinymce", page_story
	$browser.click "//a[@id='story_long_description_numlist']/span"
	#$browser.type "story_designation", desig_value
	begin
		assert $browser.is_text_present("Admin Note:")
		$browser.type "story[donation_suggestion_levels][0]", sug_amount
		$browser.type "story[donation_suggestion_descriptions][0]", sug_desc
		$browser.click "link=add another amount"
		$browser.type "story[donation_suggestion_levels][1]", "11.50"
		$browser.type "story[donation_suggestion_descriptions][1]", sug_desc
		$browser.click "link=add another amount"
		$browser.type "story[donation_suggestion_levels][2]", "15"
		$browser.type "story[donation_suggestion_descriptions][2]", sug_desc
		$browser.click "link=add another amount"
		$browser.type "story[donation_suggestion_levels][3]", "13"
		$browser.type "story[donation_suggestion_descriptions][3]", sug_desc
		$browser.click "link=add another amount"
		$browser.type "story[donation_suggestion_levels][4]", sug_amount
		$browser.type "story[donation_suggestion_descriptions][4]", sug_desc
		$browser.click "css=button[type=submit]"
		$browser.wait_for_page_to_load 
	rescue
		@createstorybutton_topposition = $browser.get_element_position_top "css=button[type=submit]"
		puts "CreateStory button Top position : #{@createstorybutton_topposition}"
		if @createstorybutton_topposition == '1641' or @createstorybutton_topposition == '1617' or @createstorybutton_topposition == '1625'
			puts "UI Check : Pass. CreateStory button is present at the correct position in Createstory screen."
		else
			puts "UI Check : Fail. CreateStory button is not present at the correct position in Createstory screen."
		end
		$browser.click "css=button[type=submit]"
		$browser.wait_for_page_to_load 
	end
		
	$browser.click "link=View"
	$browser.wait_for_page_to_load
	
	begin
		assert $browser.is_element_present("link=Set Your Goals")
		#***************** Link position check *****************#
		@setgoalslink_topposition = $browser.get_element_position_top "link=Set Your Goals"
		puts "SetYourGoals link Top position : #{@setgoalslink_topposition}"
		if @setgoalslink_topposition == '404' or @setgoalslink_topposition == '425' or @setgoalslink_topposition == '380' or @setgoalslink_topposition == '420'
			puts "UI Check : Pass. SetGoals link is present at the correct position in Story screen."
		else
			puts "UI Check : Fail. SetGoals link is not present at the correct position in Story screen."
		end
		sleep 3
		$browser.click "link=Set Your Goals"
		$browser.wait_for_page_to_load 
		sleep 5
		$browser.type "story_goal", goal_amount
		$browser.click "story_end_date"
		$browser.click goal_date
		begin
			assert $browser.is_text_present("Admin Note:")
			$browser.click "css=button[type=submit]"
			$browser.wait_for_page_to_load 
		rescue
			$browser.click "css=button[type=submit]"
			$browser.wait_for_page_to_load 
		end
		begin
			assert $browser.is_text_present("Your page has been saved.")
			puts "Passed. Thank donor message and video gets saved successfully."
		rescue Test::Unit::AssertionFailedError
			puts "Failed. Thank donor message and video gets is not saved successfully."
		end
		
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Set Your Goals link is not present."
	end

	$browser.click "link=View"
	$browser.wait_for_page_to_load
	
	begin
		assert $browser.is_element_present("link=Customize Donor Thank-You's")
		#***************** Link position check *****************#
		@thankdonorlink_topposition = $browser.get_element_position_top "link=Customize Donor Thank-You's"
		puts "ThankDonor link Top position : #{@thankdonorlink_topposition}"
		if @thankdonorlink_topposition == '404' or @thankdonorlink_topposition == '425' or @thankdonorlink_topposition == '380' or @thankdonorlink_topposition == '420'
			puts "UI Check : Pass. ThankDonor link is present at the correct position in Story screen."
		else
			puts "UI Check : Fail. ThankDonor link is not present at the correct position in Story screen."
		end
		$browser.click "link=Customize Donor Thank-You's"
		$browser.wait_for_page_to_load 
		sleep 5
		$browser.type "story_new_video_url", "http://www.youtube.com/watch?v=giIWXZbyT1o"
		$browser.type "story_thank_you_message", "Thank donor email message"
		$browser.click "css=button[type=submit]"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_text_present("Save successful!")
			puts "Passed. Thank donor message and video gets saved successfully."
		rescue Test::Unit::AssertionFailedError
			puts "Failed. Thank donor message and video gets is not saved successfully."
		end
		
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Customize Donor Thank-You's link is not present."
	end

	$browser.click "link=View"
	$browser.wait_for_page_to_load
	
	begin
		assert $browser.is_element_present("link=Illustrate Your Story")
		#***************** Link position check *****************#
		@imagevideolink_topposition = $browser.get_element_position_top "link=Images/Videos"
		puts "Illustrate link Top position : #{@imagevideolink_topposition}"
		if @imagevideolink_topposition == '231' or @imagevideolink_topposition == '252' or @imagevideolink_topposition == '207' or @imagevideolink_topposition == '250'
			puts "UI Check : Pass. Illustrate link is present at the correct position in Story screen."
		else
			puts "UI Check : Fail. Illustrate link is not present at the correct position in Story screen."
		end
		$browser.click "link=Illustrate Your Story"
		$browser.wait_for_page_to_load 
		sleep 5
		puts "Step 7.1 : Upload valid youtube and vimeo video."
		$browser.type "new_video_urls", "http://www.youtube.com/watch?v=HNVSI_r9SVg\nhttp://www.youtube.com/watch?v=giIWXZbyT1o"
		#***************** Button position check *****************#
		@savebutton_topposition = $browser.get_element_position_top "css=button[type=submit]"
		puts "Save button Top position : #{@savebutton_topposition}"
		if @savebutton_topposition == '745' or @savebutton_topposition == '766' or @savebutton_topposition == '721' or @savebutton_topposition == '767'
			puts "UI Check : Pass. Save button is present at the correct position in Imagevideo screen."
		else
			puts "UI Check : Fail. Save button is not present at the correct position in Imagevideo screen."
		end
		puts "Step 7.2 : Upload valid image"
		sleep 2
		#$browser.type "name=images[]", "C:\\Users\\Public\\Pictures\\Sample Pictures\\Koala.jpg"
		$browser.click "css=button[type=\"submit\"]"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_text_present("Save successful!")
			puts "Step 8 : Passed. Uploaded video gets saved successfully!"
		rescue Test::Unit::AssertionFailedError
			puts "Step 8 : Failed. Uploaded video is not saved successfully!"
		end
		#***************** Link position check *****************#
		@viewlink_topposition = $browser.get_element_position_top "link=View"
		puts "View link Top position : #{@viewlink_topposition}"
		if @viewlink_topposition == '290' or @viewlink_topposition == '311' or @viewlink_topposition == '266' or @viewlink_topposition == '308'
			puts "UI Check : Pass. View link is present at the correct position in Story screen."
		else
			puts "UI Check : Fail. View link is not present at the correct position in Story screen."
		end
		$browser.click "link=View"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_element_present("//li[2]/a/img")
			puts "Step 9 : Passed. Uploaded video gets displayed successfully in Thumbnail section of Story page."
		rescue Test::Unit::AssertionFailedError
			puts "Step 9 : Failed. Uploaded video is not displayed successfully in Thumbnail section of Story page."
		end
		
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Illustrate Your Story link is not present."
	end

	begin
		assert $browser.is_element_present(admin_links)
		puts "Step 10 : Passed. Admin links are available in the Created #{story_name} page"
	rescue 
	end
	begin
		assert $browser.is_text_present("Your page is 80% complete.")
		puts "Step 11 : Passed. 80% complete label gets displayed in Fundraiser completion steps progress bar."
	rescue Test::Unit::AssertionFailedError
		puts "Step 11 : Failed. Incorrect percent is displayed in Fundraiser completion steps progress bar."
	end
	begin
		assert $browser.is_element_present("css=img[alt=\"Add image or video\"]")
		puts "Pass. 'Add image or video' image is displayed under gallery section of story page."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. 'Add image or video' image is not displayed under gallery section of story page."
	end
	
	puts "************** END : Create Story Page ****************"
end

def createPersonalCausePage(story_name, story_summary, page_story, youtube_url, desig_value, admin_links, stripe_email, stripe_password)
	
	puts "************** START : Create Personal Cause page ****************"	
	
	$browser.open "/story/new"
	$browser.wait_for_page_to_load
	sleep 2
	
	begin
		assert $browser.is_element_present("id=personal_fundraiser_button")
		puts "Pass. personal_fundraiser_button is displayed in the story new page"
		
		$browser.click "id=personal_fundraiser_button"
		puts "Step 1 : Entering valid details for creating Story page"
		$browser.type "id=story_title", story_name
		$browser.click "css=button[type=\"submit\"]"
		begin
			assert $browser.is_text_present("Creating page...")
			puts "Creating page... processing icon Success!!"
		rescue Test::Unit::AssertionFailedError
			puts "Failed. Creating page... processing icon is missing."
		end
		$browser.wait_for_page_to_load
		begin
			assert $browser.is_text_present("This title is already being used by another nonprofit, project, or fundraiser")
			puts "Failed. #{story_name} is already being used by another nonprofit, project, or fundraiser. Try using a different name."
		rescue Test::Unit::AssertionFailedError
		end
		begin
			assert $browser.is_text_present("Congratulations, your page has been created!")
			puts "Step 2 : Passed. #{story_name} created successfully!"
		rescue Test::Unit::AssertionFailedError
			puts "Step 2 : Failed. #{story_name} creation failed!"
		end
		#--------------------------- START : Setting up Strip Account ------------------------------------------#
		begin
			assert $browser.is_element_present("link=Payment Set-Up")
			puts "Passed. Payment Setup link is present in the Story page."
			$browser.click "link=Payment Set-Up"
			$browser.wait_for_page_to_load
			begin
				assert $browser.is_element_present("link=Set it UP!")
				puts "Passed. Set it up link is present in the Payment page."
				$browser.click "link=Set it UP!"
				$browser.wait_for_page_to_load
			rescue Test::Unit::AssertionFailedError
				puts "Failed. Set it up link is not present in the Payment page."
			end
			puts "Step 3 : Entering Stripe credentials on Stripe.com"
			begin
			assert $browser.is_element_present("link=Sign in")
				$browser.click "link=Sign in"
				$browser.wait_for_page_to_load 
				$browser.type "id=email", stripe_email
				$browser.type "id=password", stripe_password
				$browser.click "css=button.button.blue"
				$browser.wait_for_page_to_load
				begin
					assert $browser.is_element_present("name=allow")
					$browser.click "name=allow"
					$browser.wait_for_page_to_load
				rescue Test::Unit::AssertionFailedError
				end
			rescue
				puts "Failed. You are already logged into Stripe account."
			end
			
			begin
				assert $browser.is_element_present("link=Modify")
				puts "Passed. Success! Modify link is present in the Payment Razoo page."
			rescue Test::Unit::AssertionFailedError
				puts "Failed. Modify link is not present in the Payment Razoo page."
			end
		rescue Test::Unit::AssertionFailedError
			puts "Failed. Payment Setup link is present in the Story page."
		end
		#--------------------------- END : Setting up Strip Account ------------------------------------------#
		
		$browser.click "link=Edit"
		$browser.wait_for_page_to_load 
		sleep 5
		$browser.type "story_short_description", story_summary	
		$browser.type "tinymce", page_story
		$browser.click "//a[@id='story_long_description_numlist']/span"
		#$browser.type "story_designation", desig_value
		$browser.click "css=button[type=submit]"
		$browser.wait_for_page_to_load 

		$browser.click "link=View"
		$browser.wait_for_page_to_load
		
		#~ begin
			#~ assert $browser.is_element_present("link=Customize Donor Thank-You's")
			#~ #***************** Link position check *****************#
			#~ @thankdonorlink_topposition = $browser.get_element_position_top "link=Customize Donor Thank-You's"
			#~ puts "ThankDonor link Top position : #{@thankdonorlink_topposition}"
			#~ if @thankdonorlink_topposition == '404' or @thankdonorlink_topposition == '425' or @thankdonorlink_topposition == '380' or @thankdonorlink_topposition == '420'
				#~ puts "UI Check : Pass. ThankDonor link is present at the correct position in Story screen."
			#~ else
				#~ puts "UI Check : Fail. ThankDonor link is not present at the correct position in Story screen."
			#~ end
			#~ $browser.click "link=Customize Donor Thank-You's"
			#~ $browser.wait_for_page_to_load 
			#~ sleep 5
			#~ $browser.type "story_new_video_url", "http://www.youtube.com/watch?v=giIWXZbyT1o"
			#~ $browser.type "story_thank_you_message", "Thank donor email message"
			#~ $browser.click "css=button[type=submit]"
			#~ $browser.wait_for_page_to_load 
			#~ begin
				#~ assert $browser.is_text_present("Save successful!")
				#~ puts "Passed. Thank donor message and video gets saved successfully."
			#~ rescue Test::Unit::AssertionFailedError
				#~ puts "Failed. Thank donor message and video gets is not saved successfully."
			#~ end
			
		#~ rescue Test::Unit::AssertionFailedError
			#~ puts "@@@@@@@@@ FAILED @@@@@@@@@. Customize Donor Thank-You's link is not present."
		#~ end

		$browser.click "link=View"
		$browser.wait_for_page_to_load
		
		begin
			assert $browser.is_element_present("link=Illustrate Your Story")
			#***************** Link position check *****************#
			@imagevideolink_topposition = $browser.get_element_position_top "link=Images/Videos"
			puts "Illustrate link Top position : #{@imagevideolink_topposition}"
			if @imagevideolink_topposition == '231' or @imagevideolink_topposition == '252' or @imagevideolink_topposition == '207' or @imagevideolink_topposition == '250'
				puts "UI Check : Pass. Illustrate link is present at the correct position in Story screen."
			else
				puts "UI Check : Fail. Illustrate link is not present at the correct position in Story screen."
			end
			$browser.click "link=Illustrate Your Story"
			$browser.wait_for_page_to_load 
			sleep 5
			puts "Upload valid youtube and vimeo video."
			$browser.type "new_video_urls", "http://www.youtube.com/watch?v=HNVSI_r9SVg\nhttp://www.youtube.com/watch?v=giIWXZbyT1o"
			#***************** Button position check *****************#
			@savebutton_topposition = $browser.get_element_position_top "css=button[type=submit]"
			puts "Save button Top position : #{@savebutton_topposition}"
			if @savebutton_topposition == '745' or @savebutton_topposition == '766' or @savebutton_topposition == '721' or @savebutton_topposition == '767'
				puts "UI Check : Pass. Save button is present at the correct position in Imagevideo screen."
			else
				puts "UI Check : Fail. Save button is not present at the correct position in Imagevideo screen."
			end
			puts "Upload valid image"
			sleep 2
			#$browser.type "name=images[]", "C:\\Users\\Public\\Pictures\\Sample Pictures\\Koala.jpg"
			$browser.click "css=button[type=\"submit\"]"
			$browser.wait_for_page_to_load 
			begin
				assert $browser.is_text_present("Save successful!")
				puts "Passed. Uploaded video gets saved successfully!"
			rescue Test::Unit::AssertionFailedError
				puts "Failed. Uploaded video is not saved successfully!"
			end
			#***************** Link position check *****************#
			@viewlink_topposition = $browser.get_element_position_top "link=View"
			puts "View link Top position : #{@viewlink_topposition}"
			if @viewlink_topposition == '290' or @viewlink_topposition == '311' or @viewlink_topposition == '266' or @viewlink_topposition == '308'
				puts "UI Check : Pass. View link is present at the correct position in Story screen."
			else
				puts "UI Check : Fail. View link is not present at the correct position in Story screen."
			end
			$browser.click "link=View"
			$browser.wait_for_page_to_load 
			begin
				assert $browser.is_element_present("//li[2]/a/img")
				puts "Passed. Uploaded video gets displayed successfully in Thumbnail section of Story page."
			rescue Test::Unit::AssertionFailedError
				puts "Failed. Uploaded video is not displayed successfully in Thumbnail section of Story page."
			end
			
		rescue Test::Unit::AssertionFailedError
			puts "@@@@@@@@@ FAILED @@@@@@@@@. Illustrate Your Story link is not present."
		end

		begin
			assert $browser.is_element_present(admin_links)
			puts "Passed. Admin links are available in the Created #{story_name} page"
		rescue 
		end
		begin
			assert $browser.is_text_present("Your page is 80% complete.")
			puts "Passed. 80% complete label gets displayed in Personal Cause completion steps progress bar."
		rescue Test::Unit::AssertionFailedError
			puts "Failed. Incorrect percent is displayed in Personal Cause completion steps progress bar."
		end
		begin
			assert $browser.is_element_present("css=img[alt=\"Add image or video\"]")
			puts "Pass. 'Add image or video' image is displayed under gallery section of story page."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. 'Add image or video' image is not displayed under gallery section of story page."
		end
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. personal_fundraiser_button is not displayed in the story new page"
	end
	
	puts "************** END : Create Personal Cause Page ****************"
end

# --------------------------------------------------------------------------------------#
# Description:  This method allows the Normal user to create a Story page.
# --------------------------------------------------------------------------------------#

def createThemedFundraiser(normal1_firstname, normal1_lastname, story_summary, page_story, sug_desc, donation_amount)
	
	puts "************** START : Create Themed Fundraiser ****************"
	sleep 2
	begin
		assert $browser.is_text_present("Make a Wish")
		$browser.click "link=Make a Holiday Wish"
		$browser.wait_for_page_to_load
		puts "Step 1 : Select theme in the Themed Fundraiser page"
		$browser.click "id=story_theme_urn_0"
		$browser.click "css=button[type='submit']"
		$browser.wait_for_page_to_load
		begin
			assert $browser.is_text_present("Congratulations, your page has been created!")
			puts "Step 2 : Passed. FR page has been created successfully from the Themed Fundraiser."
		rescue Test::Unit::AssertionFailedError
			puts "@@@@@@@@@ FAILED @@@@@@@@@. Step 2 : FR page is not created successfully from the Themed Fundraiser."
		end
		@storypage_admin = normal1_firstname+" "+ normal1_lastname
		begin
			assert $browser.is_text_present("#{@storypage_admin}'s Holiday Wish")
			puts "Pass. FR title contains #{@storypage_admin}'s Holiday Wish"
		rescue Test::Unit::AssertionFailedError
			puts "Fail. FR title doesn't contains #{@storypage_admin}'s My Holiday Wish"
		end
		begin
			assert $browser.is_text_present("Project Setup")
			puts "Pass. User gets directed to Story View page after theme FR creation."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. User is not directed to Story View page after theme FR creation."
		end
		begin
			assert $browser.is_text_present("Your project is 80% complete.")
			puts "Pass. 80% complete label gets displayed in completion steps progress bar."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. Incorrect percent is displayed in completion steps progress bar."
		end
		sleep 2
		begin
			assert $browser.is_element_present("css=img[alt=\"Size_550x415_koala\"]")
			puts "Pass. Theme Gallery item gets displayed in the FR page."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. Theme Gallery item is not displayed in the FR page."
		end
		begin
			assert $browser.is_text_present(story_summary)
			puts "Pass. Theme Summary gets displayed in the FR page."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. Theme Summary gets displayed in the FR page."
		end
		begin
			assert $browser.is_text_present(page_story)
			puts "Pass. Theme Tell your story gets displayed in the FR page."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. Theme Tell your story is not displayed in the FR page."
		end
		begin
			assert $browser.is_text_present("$ 10 #{sug_desc}")
			puts "Pass. Theme Suggested Amount gets displayed in the FR page."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. Theme Suggested Amount is not displayed in the FR page."
		end
		$browser.click "link=Thank Donors"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_element_present("css=img[alt=\"Size_150x150_story_video\"]")
			puts "Pass. Theme Thankdonor video gets displayed in the FR page."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. Theme Thankdonor video is not displayed in the FR page."
		end
		$browser.click "link=View"
		$browser.wait_for_page_to_load 
		$browser.type "name=donation[amount]", donation_amount
		$browser.click "css=p.action > button[type='submit']"
		$browser.wait_for_page_to_load
		begin
			assert $browser.is_text_present("General Fund")
			puts "Pass. Theme designation gets displayed in the Donation Form page."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. Theme designation is not displayed in the Donation Form page."
		end
		begin
			assert $browser.is_text_present("I accept the terms of use and privacy policy")
			puts "Pass. 'Terms of use' checkbox is present in the Donation Form screen."
			$browser.click "id=order_user_order_terms_of_use"
		rescue Test::Unit::AssertionFailedError
			puts "Fail. 'Terms of use' checkbox is not present in the Donation Form screen."
		end
		$browser.click "css=button[type='submit']"
		$browser.wait_for_page_to_load
		begin
			assert $browser.is_text_present("Your donation was successful! We'll send you a confirmation email receipt shortly")
			puts "Pass. Theme FR donation has been successful."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. Theme FR donation is not success."
		end
		$browser.click "css=em"
		$browser.wait_for_page_to_load 
		$browser.click "css=a.button > em"
		$browser.wait_for_page_to_load 
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Make a Wish section is not present in the Story page."
	end
	puts "************** END : Create Themed Fundraiser ****************"	

end


# ----------------------------------------------------------------------------------------------------------------#
# Description:  This method allows the user to purchase the giving card of 10 dollars worth.
# ----------------------------------------------------------------------------------------------------------------#

def purchaseGivingCard (recipient_name, recipient_emailid, recipient_deliverydate, givingcard_amount, givingcard_url)
	
	puts "************** START : Purchase Giving Card ****************"	
	$browser.open givingcard_url
	$browser.wait_for_page_to_load
	sleep 10
	begin
		#assert $browser.is_text_present("It's easy.")
		puts "Pass. User has reached the 1st page of the Giving Card purchase screen."
		puts "Step 1 : Entering all valid details in the Giving Card purchase screen."
		$browser.type "id=order_gift_card_purchase_attributes_recipient_name", recipient_name
		$browser.type "id=order_gift_card_purchase_attributes_recipient_email", recipient_emailid
		$browser.click "id=next-button1"
		sleep 2
		begin
			assert $browser.is_text_present("exact:How do you want to pay?")
			puts "Pass. User has reached the 2nd page of the Giving Card purchase screen."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. User has failed to reach the 2nd page of the Giving Card purchase screen."
		end
		sleep 5
		@giftcardpurchasebutton1_topposition = $browser.get_element_position_top "next-button1"
		puts "GiftCardPurchase1 button Top position : #{@createpurchasebutton1_topposition}"
		$browser.highlight("next-button1")
		$browser.click "next-button1"
		sleep 5
		begin
			assert $browser.is_text_present("Please note all gift card sales are final. There will be no refunds.")
			puts "Pass. 'Please note all gift card sales are final. There will be no refunds' content is present."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. 'Please note all gift card sales are final. There will be no refunds' content is not present."
		end
		$browser.click "id=order_terms_of_use"
		sleep 5
		$browser.click "//button[@type='submit']"
		sleep 5
		$browser.click "//button[@id='submit-button1']"
		sleep 5
		$browser.mouse_over("//button[@id='submit-button1']") 
		sleep 5
		$browser.click "xpath=(//div[@id='giving-card-form-wizard'])/button"
		sleep 5
		@giftcardpurchasebutton_topposition = $browser.get_element_position_top "//button[@id='submit-button1']"
		puts "GiftCardPurchase button Top position : #{@createpurchasebutton_topposition}"
		sleep 5
		@giftcardpurchasebutton1_topposition = $browser.get_element_position_top "next-button1"
		puts "GiftCardPurchase1 button Top position : #{@createpurchasebutton1_topposition}"
		sleep 5
		@giftcardpurchasebutton2_topposition = $browser.get_element_position_top "xpath=(//div[@id='giving-card-form-wizard'])/button"
		puts "GiftCardPurchase2 button Top position : #{@createpurchasebutton2_topposition}"
		sleep 5
		@giftcardpurchasebutton3_topposition = $browser.get_element_position_top "prev-button1"
		puts "GiftCardPurchase3 button Top position : #{@createpurchasebutton3_topposition}"
		sleep 5
		$browser.highlight("next-button1")
		sleep 5
		$browser.highlight("prev-button1")
		begin
			assert $browser.is_text_present("Processing...")
			puts "Processing... processing icon Success!!"
		rescue Test::Unit::AssertionFailedError
			puts "Failed. Processing... processing icon is missing."
		end
		sleep 3
		begin
			assert $browser.is_text_present("Thank you for\nyour order!")
			puts "Step 2 : Pass. User has reached the Thank You screen successfully."
		rescue Test::Unit::AssertionFailedError
			puts "@@@@@@@@@ FAILED @@@@@@@@@. Step 2 : User has failed to reach the Thank You screen successfully."
		end
		begin
			assert $browser.is_text_present("Your purchase was successful! We'll send you a confirmation email receipt shortly.")
			puts "Pass. Correct information flash text is displayed in the 'Thank You' screen."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. Incorrect information flash text is displayed in the 'Thank You' screen."
		end
		begin
			assert $browser.is_text_present(givingcard_amount)
			puts "Pass. #{givingcard_amount} giving card purchase amount successfully displayed in the Thank You screen."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. #{givingcard_amount} giving card purchase amount is not displayed in the Thank You screen."
		end
		begin
			assert $browser.is_text_present(recipient_emailid)
			puts "Pass. #{recipient_emailid} recipient emailId is displayed in the Thank You screen."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. #{recipient_emailid} recipient emailId is not displayed in the Thank You screen."
		end
		begin
			assert $browser.is_text_present("Recipient Name")
			puts "Pass. #{recipient_name} successfully displayed in the Thank You screen."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. #{recipient_name} is not displayed in the Thank You screen."
		end
		#~ $browser.click "link=Back to Homepage"
		#~ $browser.wait_for_page_to_load 
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Giving Card purchase screen is not available to this user, since there is no theme/collection is available."
	end
	

	puts "************** END : Purchase Giving Card ****************"	
	
end


# ----------------------------------------------------------------------------------------------------------------#
# Description:  This method allows the Team Captain to create a Team Campaign page for Specific Cause.
# ----------------------------------------------------------------------------------------------------------------#

def createTeamCampaignSpecificCause(teamcampaign_url, camp_org, camp_title, camp_story, camp_goalamount, camp_goaldate)
	
	puts "************** START : Create Team Campaign Page ****************"	
	$camp_org = camp_org
	$camp_title = camp_title
	$browser.open teamcampaign_url
	$browser.wait_for_page_to_load 
	puts "Step 1 : Entering valid details for creating Team Campaign page"
	$browser.type "id=org_picker_kw", $camp_org
	sleep 3
	$browser.type_keys("id=org_picker_kw", "\32") #Enter space at the end of org
	sleep 3
	$browser.mouse_over("xpath=(//li[@role='menuitem'])[1]/a/strong") #Mouse over on element
	sleep 5
	$browser.click "id=ui-active-menuitem"
	$browser.type "campaign_title", $camp_title
	$browser.type "campaign_intro", camp_story
	sleep 2
	$browser.type "tinymce", camp_story
	sleep 2
	$browser.click "//a[@id='campaign_about_numlist']/span"
	sleep 2
	$browser.click "css=span.mceIcon.mce_indent"
	$browser.click "css=span.mceIcon.mce_indent"
	$browser.click "css=span.mceIcon.mce_indent"
	$browser.click "css=span.mceIcon.mce_indent"
	$browser.click "css=span.mceIcon.mce_bold"
	$browser.click "css=span.mceIcon.mce_bold"
	$browser.click "css=span.mceIcon.mce_italic"
	$browser.click "css=span.mceIcon.mce_bullist"
	$browser.click "css=span.mceIcon.mce_numlist"
	$browser.type "campaign_goal_amount", camp_goalamount
	$browser.click "campaign_start_at"
	$browser.click camp_goaldate
	$browser.click "campaign_end_at"
	$browser.click camp_goaldate
	$browser.click "campaign_enable_offline_donations"
	#***************** Button position check *****************#
	@createteambutton_topposition = $browser.get_element_position_top "//button[@type='submit']"
	puts "CreateTeam button Top position : #{@createteambutton_topposition}"
	if @createteambutton_topposition == '1676' or @createteambutton_topposition == '1645'
		puts "UI Check : Pass. CreateTeam button is present at the correct position in CreateTeam screen."
	else
		puts "UI Check : Fail. CreateTeam button is not present at the correct position in CreateTeam screen."
	end
	$browser.click "//button[@type='submit']"
	begin
		assert $browser.is_text_present("Creating team...")
		puts "Creating team... processing icon Success!!"
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Creating team... processing icon is missing."
	end
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Congratulations! Your team has been created.")
		puts "Step 2 : Passed. Team Campaign for #{$camp_org} was created successfully."
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Step 2 : Team Campaign for #{$camp_org} was not created successfully."
	end
	begin
		assert $browser.is_text_present("of $1,001")
		puts "Step 3 : Passed. Entered Campaign goal amount gets displayed in Story page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Failed. Incorrect Campaign goal amount gets displayed in Story page."
	end
	begin
		assert $browser.is_text_present("#{$camp_title}")
		puts "Step 4 : Passed. Entered Campaign title gets displayed in Story page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 4 : Failed. Incorrect Campaign title gets displayed in Story page."
	end
	begin
		assert $browser.is_text_present("left")
		puts "Step 5 : Passed. Count says 'left' label."
	rescue Test::Unit::AssertionFailedError
		puts "Step 5 : Failed. Count doesn't say 'left' label."
	end
	
	puts "************** END : Create Team Campaign Page ****************"	
	
end

# -------------------------------------------------------------------------------------------#
# Description:  This method allows the Team Captain to create a Team Campaign page.
# -------------------------------------------------------------------------------------------#

def createTeamCampaignMultipleCause(teamcampaign_url, camp_title, camp_story, camp_goalamount, camp_goaldate)
	
	puts "************** START : Create Team Campaign Page ****************"	
	$camp_title = camp_title
	$browser.open teamcampaign_url
	$browser.wait_for_page_to_load 
	puts "Step 1 : Entering valid details for creating Team Campaign page"
	sleep 2
	$browser.click "campaign_fundraise_for_any_org_true"
	$browser.type "campaign_title", $camp_title
	$browser.type "campaign_intro", camp_story
	$browser.type "tinymce", camp_story
	$browser.click "css=span.mceIcon.mce_indent"
	$browser.click "css=span.mceIcon.mce_indent"
	$browser.click "css=span.mceIcon.mce_indent"
	$browser.click "css=span.mceIcon.mce_indent"
	$browser.click "css=span.mceIcon.mce_bold"
	$browser.click "css=span.mceIcon.mce_bold"
	$browser.click "css=span.mceIcon.mce_italic"
	$browser.click "css=span.mceIcon.mce_bullist"
	$browser.click "css=span.mceIcon.mce_numlist"
	$browser.type "campaign_goal_amount", camp_goalamount
	$browser.click "campaign_start_at"
	$browser.click camp_goaldate
	$browser.click "campaign_end_at"
	$browser.click camp_goaldate
	$browser.click "campaign_enable_offline_donations"
	$browser.click "//button[@type='submit']" 
	begin
		assert $browser.is_text_present("Creating team...")
		puts "Creating team... processing icon Success!!"
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Creating team... processing icon is missing."
	end
	$browser.wait_for_page_to_load
	begin
		assert $browser.is_text_present("Congratulations! Your team has been created.")
		puts "Step 2 : Passed. Team Campaign for multiple causes was created successfully."
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Step 2 : Team Campaign for multiple causes was not created successfully."
	end
	begin
		assert $browser.is_text_present("of $1,001")
		puts "Step 3 : Passed. Entered Campaign goal amount gets displayed in Story page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Failed. Incorrect Campaign goal amount gets displayed in Story page."
	end
	begin
		assert $browser.is_text_present("#{$camp_title}")
		puts "Step 4 : Passed. Entered Campaign title gets displayed in Story page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 4 : Failed. Incorrect Campaign title gets displayed in Story page."
	end
	begin
		assert $browser.is_text_present("left")
		puts "Step 5 : Passed. Count says 'left' label."
	rescue Test::Unit::AssertionFailedError
		puts "Step 5 : Failed. Count doesn't say 'left' label."
	end
	
	puts "************** END : Create Team Campaign Page ****************"	
	
end


# -------------------------------------------------------------------------------------------#
# Description:  This method allows the Team Captain to Edit theTeam Campaign page.
# -------------------------------------------------------------------------------------------#

def editTeamCampaign(leaderboard_order, camp_url)
	
	puts "************** START : Edit Team Campaign Page ****************"	
	#***************** Link position check *****************#
	@editpagelink_topposition = $browser.get_element_position_top "link=Edit"
	puts "Edit link Top position : #{@editpagelink_topposition}"
	if @editpagelink_topposition == '322'
		puts "UI Check : Pass. Edit link is present at the correct position in EditTeam screen."
	else
		puts "UI Check : Fail. Edit link is not present at the correct position in EditTeam screen."
	end
	$browser.click "link=Edit"
	$browser.wait_for_page_to_load 
	puts "Step 1 : Start updating the Team Campaign page."
	sleep 8
	$browser.click "css=span.mceIcon.mce_indent"
	$browser.click "css=span.mceIcon.mce_indent"
	$browser.click "css=span.mceIcon.mce_indent"
	$browser.click "css=span.mceIcon.mce_indent"
	$browser.click "css=span.mceIcon.mce_bold"
	$browser.click "css=span.mceIcon.mce_bold"
	$browser.click "css=span.mceIcon.mce_italic"
	$browser.click "css=span.mceIcon.mce_bullist"
	$browser.click "css=span.mceIcon.mce_numlist"
	$browser.select "campaign_leaderboard_order", leaderboard_order
	sleep 1
	$browser.click "link=here"
	$browser.type "campaign_new_url", camp_url
	#***************** Button position check *****************#
	@updatebutton_topposition = $browser.get_element_position_top "//button[@type='submit']"
	puts "UpdateInformation button Top position : #{@updatebutton_topposition}"
	if @updatebutton_topposition == '1793'
		puts "UI Check : Pass. UpdateInformation button is present at the correct position in EditTeam screen."
	else
		puts "UI Check : Fail. UpdateInformation button is not present at the correct position in EditTeam screen."
	end
	$browser.click "//button[@type='submit']"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Your team has been updated.")
		puts "Step 2 : Team Campaign page gets updated successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Team Campaign page doesn't get updated successfully."
	end
	
	puts "************** END : Edit Team Campaign Page ****************"	
end

# -------------------------------------------------------------------------------------------#
# Description:  This method allows the Team Captain to post comment in Team page.
# -------------------------------------------------------------------------------------------#

def postTeamComments(team_comment)
	
	puts "************** START : Post Team Comment ****************"	
	
	$browser.type "comment_body", team_comment
	#***************** Button position check *****************#
	@postbutton_topposition = $browser.get_element_position_top "comment_form_submit"
	puts "Post button Top position : #{@postbutton_topposition}"
	if @postbutton_topposition == '542'
		puts "UI Check : Pass. Post button is present at the correct position in Team screen."
	else
		puts "UI Check : Fail. Post button is not present at the correct position in Team screen."
	end
	$browser.click "comment_form_submit"
	sleep 10
	begin
		assert $browser.is_text_present("Thank you, your message has been posted")
		puts "Passed. Team comment gets successfully posted."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Team comment is not successfully posted."
	end
	begin
		assert $browser.is_text_present("#{team_comment}")
		puts "Passed. Team comment gets successfully displayed in the Team page."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Team comment doesn't get displayed in the Team page."
	end

	puts "************** END : Post Team Comment ****************"	
end

# -------------------------------------------------------------------------------------------------------#
# Description:  This method allows the Team Captain to Create FR using Fundaiser Template.
# -------------------------------------------------------------------------------------------------------#

def createTeamFundraiserTemplate(story_summary, camp_goalamount)
	
	puts "************** START : Create FR using Fundraiser Template ****************"	
	
	#***************** Link position check *****************#
	@createtemplink_topposition = $browser.get_element_position_top "link=Fundraiser Template"
	puts "CreateTemplate link Top position : #{@createtemplink_topposition}"
	if @createtemplink_topposition == '322'
		puts "UI Check : Pass. CreateTemplate link is present at the correct position in Team screen."
	else
		puts "UI Check : Fail. CreateTemplate link is not present at the correct position in Team screen."
	end
	$browser.click "link=Fundraiser Template"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("The Basics")
		puts "Passed. User has successfully reached the Fundraiser Template screen."
	rescue Test::Unit::AssertionFailedError
		puts "Failed in reaching the Fundraiser Template screen."
	end
	sleep 5
	$browser.type "fundraiser_template_short_description", story_summary
	$browser.type "tinymce", story_summary
	$browser.click "css=span.mceIcon.mce_indent"
	$browser.click "css=span.mceIcon.mce_indent"
	$browser.click "css=span.mceIcon.mce_indent"
	$browser.click "css=span.mceIcon.mce_indent"
	$browser.click "css=span.mceIcon.mce_bold"
	$browser.click "css=span.mceIcon.mce_bold"
	$browser.click "css=span.mceIcon.mce_italic"
	$browser.click "css=span.mceIcon.mce_bullist"
	$browser.click "css=span.mceIcon.mce_numlist"
	$browser.type "fundraiser_template_goal_amount", camp_goalamount
	
	#***************** Button position check *****************#
	@createtempbutton_topposition = $browser.get_element_position_top "//button[@type='submit']"
	puts "CreateTemplate button Top position : #{@createtempbutton_topposition}"
	if @createtempbutton_topposition == '797'
		puts "UI Check : Pass. CreateTemplate button is present at the correct position in Team screen."
	else
		puts "UI Check : Fail. CreateTemplate button is not present at the correct position in Team screen."
	end
	$browser.click "//button[@type='submit']"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Your fundraiser template has been created")
		puts "Step 1 : Passed. Fundraiser Template gets created successfully!"
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Step 1 : Fundraiser Template creation failed!"
	end
	$browser.click "id=joinTeam"
	begin
		assert $browser.is_text_present("Creating fundraiser...")
		puts "Pass. 'Creating fundraiser...' loading icon is displayed under Join This Team section."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. 'Creating fundraiser...' loading icon is not displayed under Join This Team section."
	end
	$browser.wait_for_page_to_load 
	
	begin
		assert $browser.is_text_present("1st place")
		puts "Step 2 : Passed. FR gets created successfully!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. FR creation failed!"
	end
	begin
		assert $browser.is_element_present("css=img[alt=\"team\"]")
		puts "Step 3 : Passed. Team Campaign icon present in the FR story page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Failed. Team Campaign icon is not present in the FR story page."
	end
	begin
		assert $browser.is_text_present("1st place")
		puts "Step 4 : Passed. 1st Rank gets displayed in the Story page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 4 : Failed. 1st Rank doesn't get displayed in the Story page."
	end
	
	puts "************** END : Create FR using Fundraiser Template ****************"	
	
end

# ------------------------------------------------------------------------------------------------#
# Description:  This method allows the Team Captain to Create FR for Team Campaign page.
# ------------------------------------------------------------------------------------------------#

def createTeamCampFundraiser(teamcamp_fr, story_summary, story_name, youtube_url, sug_amount, sug_desc, camp_goalamount)
	
	puts "************** START : Create FR for Team Camp ****************"	
	$browser.click "css=#joinTeam > em"
	#~ $browser.click "id=joinTeam"
	#$browser.click "css=a.button > em"
	begin
		assert $browser.is_text_present("Creating fundraiser...")
		puts "Pass. 'Creating fundraiser...' loading icon is displayed under Join This Team section."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. 'Creating fundraiser...' loading icon is not displayed under Join This Team section."
	end
	$browser.wait_for_page_to_load
		begin
			assert $browser.is_element_present("id=charity_fundraiser_button")
			puts "Pass. charity_fundraiser_button is displayed in the story new page"
			$browser.click "id=charity_fundraiser_button"
		rescue Test::Unit::AssertionFailedError
			puts "Fail. charity_fundraiser_button is not displayed in the story new page"
		end
	
	puts "Step 1 : Entering valid details for creating FR page for Team Campaign."
	sleep 3
	$browser.type "id=org_picker_kw", $camp_org
	sleep 3
	$browser.type_keys("id=org_picker_kw", "\32") #Enter space at the end of org
	sleep 3
	$browser.mouse_over("xpath=(//li[@role='menuitem'])[1]/a/strong") #Mouse over on element
	sleep 3
	$browser.click "id=ui-active-menuitem"
	$browser.type "xpath=(//input[@id='story_title'])[2]", teamcamp_fr
	$browser.click "css=#storyForm > div.submit > p > button[type=\"submit\"]"
	$browser.wait_for_page_to_load 
	sleep 2
	begin
		assert $browser.is_text_present("Congratulations, your page has been created!")
		puts "Step 2 : Passed. FR gets created successfully!"
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Step 2 : FR creation failed!"
	end
	begin
		assert $browser.is_element_present("link=View")
		$browser.click "link=View"
		$browser.wait_for_page_to_load 
	rescue Test::Unit::AssertionFailedError
	end
	begin
		assert $browser.is_element_present("link=#{$camp_title}")
		puts "Step 3 : Passed. Team Campaign link present in the FR story page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Failed. Team Campaign link is not present in the FR story page."
	end
	begin
		assert $browser.is_element_present("//img[@alt='team fundraiser']")
		puts "Step 4 : Passed. Team Campaign icon present in the FR story page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 4 : Failed. Team Campaign icon is not present in the FR story page."
	end
	begin
		assert $browser.is_text_present("1st place")
		puts "Step 5 : Passed. 1st Rank gets displayed in the Story page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 5 : Failed. 1st Rank doesn't get displayed in the Story page."
	end
	
	puts "************** END : Create Team Campaign Page ****************"	
	
end


# ------------------------------------------------------------------------------------------------#
# Description:  This method allows the Team Captain to view the Single cause Leaderboard.
# ------------------------------------------------------------------------------------------------#

def verifySingleCauseLeaderboard(modified_camp_url)
	
	puts "************** START : View Campaign Leaderboard ****************"	
	$browser.open modified_camp_url
	sleep 5
	puts "Step 1 : Verify Offline donation amount raised in the Thermometer."
	begin
		assert $browser.is_text_present("($10 online, $10 offline)")
		puts "Step 1 is passed."
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 is failed."
	end
	
	puts "Step 2 : Verify Total amount raised (Offline + Online) at the title Header and Leaderboard."
	begin
		assert $browser.is_text_present("$20")
		puts "Step 2 is passed."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 is failed."
	end
	puts "Step 3 : Verify donor's count at the title header."
	begin
		assert_equal "2", $browser.get_text("//li[2]/div/div[1]")
		puts "Step 3 is passed."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 is failed."
	end
	puts "Step 4 : Verify fundraiser's count at the title header."
	begin
		assert_equal "1", $browser.get_text("//li[3]/div/div[1]")
		puts "Step 4 is passed."
	rescue Test::Unit::AssertionFailedError
		puts "Step 4 is failed."
	end
	puts "Step 5 : Verify donors in the Leaderboard."
	begin
		assert_equal "2", $browser.get_text("//td[3]")
		puts "Step 5 is passed."
	rescue Test::Unit::AssertionFailedError
		puts "Step 5 is failed."
	end
	puts "Step 6 : Verify Create your own Team section in Leaderboard"
	begin
		assert $browser.is_text_present("exact:Have an Idea for a Team?")
		puts "Step 6 is failed."
	rescue Test::Unit::AssertionFailedError
		puts "Step 6 is passed."
	end
	puts "Step 7 : Verify Create your own Team button in Leaderboard"
	begin
		assert $browser.is_text_present("Create your own team")
		puts "Step 7 is failed."
	rescue Test::Unit::AssertionFailedError
		puts "Step 7 is passed."
	end
		
	puts "************** END : View Campaign Leaderboard ****************"	
end

# --------------------------------------------------------------------------------------------------#
# Description:  This method allows the Team Captain to view the Multiple cause Leaderboard.
# --------------------------------------------------------------------------------------------------#

def verifyMulitpleCauseLeaderboard(modified_camp_url, sug_amount, teamcamp_fr)
	
	puts "************** START : View Campaign Leaderboard ****************"	
	$browser.open modified_camp_url
	sleep 5
	puts "Step 1 : Verify amount raised in the Thermometer."
	begin
		assert_equal "$#{sug_amount} raised", $browser.get_text("//p[1]/strong")
		puts "Step 1 is passed."
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 is failed."
	end
	
	puts "Step 2 : Verify amount raised at the title header."
	begin
		assert_equal "$#{sug_amount}", $browser.get_text("//li[1]/div/div[1]")
		puts "Step 2 is passed."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 is failed."
	end
	puts "Step 3 : Verify donor's count at the title header."
	begin
		assert_equal "1", $browser.get_text("//li[2]/div/div[1]")
		puts "Step 3 is passed."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 is failed."
	end
	puts "Step 4 : Verify fundraiser's count at the title header."
	begin
		assert_equal "1", $browser.get_text("//li[3]/div/div[1]")
		puts "Step 4 is passed."
	rescue Test::Unit::AssertionFailedError
		puts "Step 4 is failed."
	end
	puts "Step 5 : Verify dollars in the Leaderboard."
	begin
		assert_equal "$#{sug_amount}", $browser.get_text("//td[4]")
		puts "Step 5 is passed."
	rescue Test::Unit::AssertionFailedError
		puts "Step 5 is failed."
	end
	puts "Step 6 : Verify donors in the Leaderboard."
	begin
		assert_equal "1", $browser.get_text("//td[3]")
		puts "Step 6 is passed."
	rescue Test::Unit::AssertionFailedError
		puts "Step 6 is failed."
	end
	puts "Step 7 : Verify FR link in the Leaderboard."
	begin
		assert $browser.is_element_present("link=#{teamcamp_fr}")
		puts "Step 7 is passed."
	rescue Test::Unit::AssertionFailedError
		puts "Step 7 is failed."
	end
	puts "Step 8 : Verify FR link under 'Most Recent Donations' frame."
	begin
		assert_equal teamcamp_fr, $browser.get_text("//div/span/a")
		puts "Step 8 is passed."
	rescue Test::Unit::AssertionFailedError
		puts "Step 8 is failed."
	end
	puts "Step 9 : Verify Create your own Team section in Leaderboard"
	begin
		assert $browser.is_text_present("exact:Have an Idea for a Team?")
		puts "Step 9 is failed."
	rescue Test::Unit::AssertionFailedError
		puts "Step 9 is passed."
	end
	puts "Step 10 : Verify Create your own Team button in Leaderboard"
	begin
		assert $browser.is_text_present("Create your own team")
		puts "Step 10 is failed."
	rescue Test::Unit::AssertionFailedError
		puts "Step 10 is passed."
	end
		
	puts "************** END : View Campaign Leaderboard ****************"	
end


# ------------------------------------------------------------------------------------------------#
# Description:  This method allows the Team Captain to remove the FR from the Team.
# ------------------------------------------------------------------------------------------------#

def removeFundraiserFromTeam(modified_camp_url,teamcamp2_fr)
	
	puts "************** START : Remove FR from Leaderboard ****************"
	sleep 5
	$browser.open modified_camp_url
	$browser.click "//img[@alt='Thumb_unfollow']"
	assert /^Are you sure you want to remove this fundraiser from your team[\s\S] This cannot be undone\.$/ =~ $browser.get_confirmation
	sleep 15
	begin
		assert $browser.is_text_present("This fundraiser has been removed.")
		puts "Passed. Fundraiser is successfully removed from the Team."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Fundraiser is not successfully removed from the Team."
	end
	
	puts "************** END : Remove FR from Leaderboard ****************"
end


# -----------------------------------------------------------------------------------------------#
# Description:  This method allows to create a Matching Grant for a Story page.
# -----------------------------------------------------------------------------------------------#

def createMatchingGrant(mgcreator_name, mg_email, mg_totalamount, mg_date)

	puts "************** START : Create Matching Grant ****************"
	$mgcreator_name = mgcreator_name
	$mg_totalamount = mg_totalamount
	
	#***************** Link position check *****************#
	@mglink_topposition = $browser.get_element_position_top "link=Matching Grants"
	puts "MG link Top position : #{@mglink_topposition}"
	if @mglink_topposition == '252' or @mglink_topposition == '228' or @mglink_topposition == '249'
		puts "UI Check : Pass. MG link is present at the correct position in Story screen."
	else
		puts "UI Check : Fail. MG link is not present at the correct position in Story screen."
	end
	$browser.click "link=Matching Grants"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_element_present("link=Create a Matching Grant")
		$browser.click "link=Create a Matching Grant"
		$browser.wait_for_page_to_load 
	rescue Test::Unit::AssertionFailedError
	end
	sleep 2
	$browser.type "matching_grant_name", $mgcreator_name
	$browser.type "matching_grant_email", mg_email
	$browser.type "matching_grant_amount", $mg_totalamount
	$browser.click "matching_grant_start_at"
	$browser.click mg_date
	$browser.click "matching_grant_end_at"
	$browser.click mg_date
	#***************** Button position check *****************#
	@addmgbutton_topposition = $browser.get_element_position_top "//button[@type='submit']"
	puts "AddMG button Top position : #{@addmgbutton_topposition}"
	if @addmgbutton_topposition == '790' or @addmgbutton_topposition == '766' or @addmgbutton_topposition == '803'
		puts "UI Check : Pass. AddMG button is present at the correct position in MG screen."
	else
		puts "UI Check : Fail. AddMG button is not present at the correct position in MG screen."
	end
	$browser.click "//button[@type='submit']"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Your matching grant has been created")
		puts "Step 1 : MG gets created successfully."
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Step 1 : MG creation failed."
	end
	begin
		assert $browser.is_element_present("//img[@alt='X2_money']")
		puts "Step 2 : MG icon displayed in the story page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : MG icon is not displayed in the story page."
	end
	begin
		assert $browser.is_text_present("$100 left")
		puts "Step 3 : Correct MG amount - $100 displayed in the MG page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Incorrect MG amount displayed in the MG page."
	end
	begin
		assert $browser.is_text_present("#{$mgcreator_name}")
		puts "Step 4 : Correct MG creator name displayed in the MG page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 4 : Incorrect MG creator name displayed in the MG page."
	end
	$browser.click "link=View"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("$100 left")
		puts "Step 5 : Correct MG amount - $#{$mg_totalamount} displayed in the Story page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 5 : Incorrect MG amount displayed in the story page."
	end
	begin
		assert $browser.is_text_present("$100 left of this $100 matching grant from #{$mgcreator_name}")
		puts "Step 6 : Correct MG creator name displayed in the Story page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 6 : Incorrect MG creator name displayed in the Story page."
	end
	
	puts "************** END : Create Matching Grant ****************"
end

# -----------------------------------------------------------------------------------------------#
# Description:  This method allows to close the created Matching Grant for a Story page.
# -----------------------------------------------------------------------------------------------#

def closeMatchingGrant(mg_donationamount)

	puts "************** START : Close Matching Grant ****************"
	sleep 2
	$browser.click "css=em"
	$browser.wait_for_page_to_load 
	$browser.click "css=a.button > em"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("$#{$mg_totalamount} left")
		puts "Pass. MG amount is not reached; MG amount is still displayed in the Story page."
	rescue Test::Unit::AssertionFailedError
		puts "Pass. MG amount is achieved; Thus, MG amount is not displayed in the Story page."
	end
	begin
		assert $browser.is_text_present("#{$mgcreator_name}")
		puts "MG amount is not reached; MG Creator Name is still displayed in the Story page."
	rescue Test::Unit::AssertionFailedError
		puts "MG amount is achieved; Thus, MG Creator Name is not displayed in the Story page."
	end
	sleep 2
	$browser.click "link=Matching Grants"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("$0.00 left of this $#{mg_donationamount} matching grant, provided by #{$mgcreator_name}.")
		puts "Pass. $0.00 left of this $#{mg_donationamount} matching grant, provided by #{$mgcreator_name} is displayed in MG screen."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. Donated Amount is not displayed in the MG screen."
	end
	puts "Click on 'Close Grant' button in the MG screen."
	sleep 2
	#***************** Link position check *****************#
	@mgcloselink_topposition = $browser.get_element_position_top "link=Close Grant"
	puts "MGClose link Top position : #{@mgcloselink_topposition}"
	if @mgcloselink_topposition == '303' or @mgcloselink_topposition == '279'
		puts "UI Check : Pass. MGClose link is present at the correct position in MG screen."
	else
		puts "UI Check : Fail. MGClose link is not present at the correct position in MG screen."
	end
	begin
		assert $browser.is_text_present("exact:Note: Only one matching grant may be active at a time. To create a new grant, first close this grant.")
		puts "Pass. Exact Note content is displayed under 'Add New Matching Grant' section."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. Exact Note content is not displayed under 'Add New Matching Grant' section."
	end
	$browser.click "link=Close Grant"
	assert /^Are you sure you want to close this Matching Grant[\s\S] This cannot be undone\.$/ =~ $browser.get_confirmation
	sleep 15
	begin
		assert $browser.is_text_present("This matching grant has been closed")
		puts "Pass. MG was successfully closed."
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. MG is not successfully closed."
	end
	sleep 2
	begin
		assert $browser.is_text_present($mgcreator_name)
		puts "Pass. Matching Grant name gets displayed successfully in the Grant History section."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. Matching Grant name is not displayed successfully in the Grant History section."
	end
	begin
		assert $browser.is_text_present("$#{$mg_totalamount}")
		puts "Pass. Total Amount gets displayed successfully in the Grant History section."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. Total Amount is not displayed successfully in the Grant History section."
	end
	begin
		assert $browser.is_text_present("$#{mg_donationamount}")
		puts "Pass. Correct donation amount gets displayed successfully in the Grant History section."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. Incorrect donation amount gets displayed successfully in the Grant History section."
	end

	puts "************** END : Close Matching Grant ****************"

end


# -----------------------------------------------------------------------------------------------#
# Description:  This method allows to Add/Update a Meetup for a Story page.
# -----------------------------------------------------------------------------------------------#

def addMeetup(meetup_title, meetup_date, meetup_location, meetup_updatedlocation)
	
	puts "************** START : Add/Update a Meetup ****************"
	
	begin
		assert $browser.is_text_present("Add a Meetup")
		puts "Step 1 : Adding a Meetup"
		$browser.click "link=Add a Meetup"
		$browser.wait_for_page_to_load
		$browser.type "id=story_meetup_attributes_meetup_title", meetup_title
		$browser.click "id=story_meetup_attributes_date"
		$browser.click meetup_date
		$browser.type "id=story_meetup_attributes_location", meetup_location
		$browser.click "css=button[type=\"submit\"]"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_text_present("Your page has been saved.")
			puts "Pass. Your meetup has been added successfully."
		rescue Test::Unit::AssertionFailedError
			puts "@@@@@@@@@ FAILED @@@@@@@@@. Your meetup is not added successfully."
		end
		$browser.click "link=show"
		sleep 2
		begin
			assert_equal meetup_title, $browser.get_value("id=story_meetup_attributes_meetup_title")
			puts "Pass. Added #{meetup_title} gets displayed in the Edit page."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. Added #{meetup_title} is not displayed in the Edit page."
		end
		begin
			assert_equal meetup_location, $browser.get_value("id=story_meetup_attributes_location")
			puts "Pass. Added #{meetup_location} gets displayed in the Edit page."
		rescue Test::Unit::AssertionFailedError
			puts "Pass. Added #{meetup_location} is not displayed in the Edit page."
		end
		sleep 1
		puts "Step 2 : Update my Meetup Location"
		$browser.type "id=story_meetup_attributes_location", meetup_updatedlocation
		$browser.click "css=button[type=\"submit\"]"
		$browser.wait_for_page_to_load
		begin
			assert $browser.is_text_present("Your page has been saved.")
			puts "Pass. Your meetup has been saved successfully."
		rescue Test::Unit::AssertionFailedError
			puts "@@@@@@@@@ FAILED @@@@@@@@@. Your meetup is not saved successfully."
		end
		$browser.click "link=show"
		sleep 2
		begin
			assert_equal meetup_updatedlocation, $browser.get_value("id=story_meetup_attributes_location")
			puts "Pass. Updated #{meetup_updatedlocation} gets displayed in the Meetup section."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. Updated #{meetup_updatedlocation} is not displayed in the Meetup section."
		end
		begin
			assert $browser.is_text_present("Your page is 100% complete.")
			puts "Pass. Project Setup section with 100% gets displayed in the story page even after it reaches 100% and other things section is ON."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. Project Setup section with 100% is not displayed in the story page even after it reaches 100% and other things section is ON."
		end
	rescue
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Meetup link is not present in the Story page."
	end
	puts "************** END : Add/Update a Meetup ****************"
end

# -----------------------------------------------------------------------------------------------#
# Description:  This method allows to Clear my Meetup from Story page.
# -----------------------------------------------------------------------------------------------#

def clearMeetup()
	
	puts "************** START : Clear a Meetup ****************"
	
	begin
		puts "Step 1 : Clear my Meetup section"
		assert $browser.is_text_present("Your Meetup")
		$browser.click "css=img[alt=\"clear\"]"
		$browser.wait_for_page_to_load
		sleep 2
		begin
			assert $browser.is_text_present("Your meetup has been cleared")
			puts "Pass. Your meetup has been cleared successfully."
		rescue Test::Unit::AssertionFailedError
			puts "@@@@@@@@@ FAILED @@@@@@@@@. Your meetup is not cleared successfully."
		end
		begin
			assert $browser.is_element_present("link=Add a Meetup")
			puts "Fail. Meetup link again gets displayed under Project Setup section."
		rescue Test::Unit::AssertionFailedError
			puts "Pass. Meetup link again is not displayed under Project Setup section."
		end
	rescue
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Your Meetup section is not displayed in the Edit story page."
	end
	puts "************** END : Clear a Meetup ****************"
end


# --------------------------------------------------------------------------------------#
# Description:  This method allows to grant the Admin rights to the Normal User.
# --------------------------------------------------------------------------------------#

def grantOrgAdminRights(admin_url, email_id, ein_number)
	
	puts "************** START : Grant ORG Admin rights ****************"	
	$browser.open admin_url
	sleep 2
	$browser.open "admin/org_admins"
	$browser.wait_for_page_to_load
	sleep 2
	$browser.type "email", email_id
	$browser.type "ein", ein_number
	#***************** Button position check *****************#
	@createadminbutton_topposition = $browser.get_element_position_top "name=commit"
	puts "CreateAdmin button Top position : #{@createadminbutton_topposition}"
	if @createadminbutton_topposition == '512' or @createadminbutton_topposition == '523'
		puts "UI Check : Pass. CreateAdmin button is present at the correct position in NewOrgAdmins screen."
	else
		puts "UI Check : Fail. CreateAdmin button is not present at the correct position in NewOrgAdmins screen."
	end
	sleep 2
	$browser.click "name=commit"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Org Admin successfully created!")
		puts "Passed. Org Admin successfully created for #{email_id} user"
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Org Admin has not created successfully for #{email_id} user"
	end
	
	puts "************** END : Grant ORG Admin rights ****************"	
	
end


# --------------------------------------------------------------------------------------------#
# Description:  This method allows to remove the Admin rights from the Org Admin.
# ---------------------------------------------------------------------------------------------#

def removeOrgAdminRights(org_url, email_id)
	
	puts "************** START : Remove ORG Admin rights ****************"	
        begin
	assert $browser.is_text_present("Raz Admin Tools")
	$browser.open "organizations/#{org_url}/admins"
	$browser.wait_for_page_to_load 
	$browser.type "email", email_id
	#***************** Button position check *****************#
	@createadminbutton_topposition = $browser.get_element_position_top "commit"
	puts "CreateAdmin button Top position : #{@createadminbutton_topposition}"
	if @createadminbutton_topposition == '430' or @createadminbutton_topposition == '434'
		puts "UI Check : Pass. CreateAdmin button is present at the correct position in Story screen."
	else
		puts "UI Check : Fail. CreateAdmin button is not present at the correct position in Story screen."
	end
	$browser.click "commit"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Org Admin successfully created!")
		puts "Passed. Org Admin successfully created for #{email_id} user"
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Org Admin has not created successfully for #{email_id} user"
	end
	#***************** Link position check *****************#
	@deleteadminlink_topposition = $browser.get_element_position_top "link=Delete"
	puts "DeleteAdmin link Top position : #{@deleteadminlink_topposition}"
	if @deleteadminlink_topposition == '653' or @deleteadminlink_topposition == '651'
		puts "UI Check : Pass. DeleteAdmin link is present at the correct position in Story screen."
	else
		puts "UI Check : Fail. DeleteAdmin link is not present at the correct position in Story screen."
	end
	$browser.click "link=Delete"
	assert /^Are you sure you want to delete this admin[\s\S]$/ =~ $browser.get_confirmation
	sleep 10
	begin
		assert $browser.is_text_present("The Org Admin was deleted")
		puts "Step 1 : Passed. Successful error text is displayed."
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 : Failed. Successful error text is not displayed."
	end
	begin
		assert $browser.is_text_present(email_id)
		puts "Step 2 : Failed. #{email_id} user still gets displayed under Org Admins section."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Passed. #{email_id} user is not displayed under Org Admins section."
	end
	rescue Test::Unit::AssertionFailedError
        puts "@@@@@@@@@ FAILED @@@@@@@@@. Admins link is not visible to #{email_id} User."
	end
	
	puts "************** END : Remove ORG Admin rights ****************"	
	
end

	
# --------------------------------------------------------------------------------------#
# Description:  This method allows the Razoo global Admin to create an ORG.
# --------------------------------------------------------------------------------------#

def createOrg(admin_url, ein_number, neworg_name, org_city, org_state)	
	
	puts "************** START : Create a New ORG ****************"	
	$ein_number = ein_number
	$neworg_name = neworg_name
	
	$browser.open admin_url
	$browser.wait_for_page_to_load 
	sleep 3
	$browser.open "admin/organizations/new"
	$browser.wait_for_page_to_load 
	sleep 3
	$browser.type "//input[@id='org_name']", $neworg_name
	$browser.type "//input[@id='org_city']", org_city
	$browser.select "//select[@id='org_state']", org_state
	$browser.type "//input[@id='org_ein']", $ein_number
	#***************** Button position check *****************#
	@createorgbutton_topposition = $browser.get_element_position_top "css=button[type=submit]"
	puts "CreateORG button Top position : #{@createorgbutton_topposition}"
	if @createorgbutton_topposition == '501' or @createorgbutton_topposition == '523'
		puts "UI Check : Pass. CreateORG button is present at the correct position in Create ORG screen."
	else
		puts "UI Check : Fail. CreateORG button is not present at the correct position in Create ORG screen."
	end
	$browser.click "css=button[type=\"submit\"]"
	$browser.wait_for_page_to_load
	begin
		assert $browser.is_text_present("New organization created")
		puts "Passed. New ORG : #{neworg_name} successfully created."
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Failed in creating a New ORG."
	end

	puts "************** END : Create a New ORG ****************"	
end

# ---------------------------------------------------------------------------------------------#
# Description:  This method allows the Razoo global Admin to create an  EIN-lessORG.
# ---------------------------------------------------------------------------------------------#

def createEinLessOrg(admin_url, new_einlessorgname, org_city, org_state)	
	
	puts "************** START : Create a New ORG with No EIN ****************"	
	$new_einlessorgname = new_einlessorgname
	sleep 3
	$browser.open admin_url
	$browser.wait_for_page_to_load 
	sleep 3
	$browser.open "admin/organizations/new"
	$browser.wait_for_page_to_load 
	sleep 3
	$browser.type "org_name", $new_einlessorgname
	$browser.type "org_city", org_city
	$browser.select "org_state", org_state
	$browser.click "css=button[type=submit]"
	$browser.wait_for_page_to_load
	begin
		assert $browser.is_text_present("New organization created")
		puts "Passed. New ORG successfully created."
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Failed in creating a New ORG."
	end
	puts "************** END : Create a New ORG with No EIN ****************"	
end


# -----------------------------------------------------------------------------------------#
# Description:  This method allows the Razoo global Admin to Edit the ORG Details.
# -----------------------------------------------------------------------------------------#

def editNpoDetails(org_url, first_name, last_name, add_1, add_2, org_emailid, phone_num)	
	
	puts "************** START: Edit ORG Details ****************"
	$add_1 = add_1
	$add_2 = add_2
	$phone_num = phone_num
	sleep 5
	puts "Step 1 : Modify the ORG details"
	$browser.click "link=show"
	$browser.type "id=story_new_url", org_url
	$browser.type "story_contact_first_name", first_name
	$browser.type "story_contact_last_name", last_name
	$browser.type "story_address1", $add_1
	$browser.type "story_address2", $add_2
	$browser.type "story_contact_email", org_emailid
	$browser.type "story_contact_phone", $phone_num
	$browser.select "id=org_razoo_group_1", "label=Animals"
	#***************** Button position check *****************#
	@savebutton_topposition = $browser.get_element_position_top "css=button[type=submit]"
	puts "Save button Top position : #{@savebutton_topposition}"
	if @savebutton_topposition == '2915' or @savebutton_topposition == '2895'
		puts "UI Check : Pass. Save button is present at the correct position in EditORG screen."
	else
		puts "UI Check : Fail. Save button is not present at the correct position in EditORG screen."
	end
	$browser.click "css=button[type=submit]"
	$browser.wait_for_page_to_load 
	sleep 5
	begin
		assert $browser.is_text_present("Your page has been saved.")
		puts "Step 2 : Passed. ORG Details was successfully changed and saved."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed in updating the ORG Details."
	end
	
	puts "************** END: Edit ORG Details ****************"
end


# -----------------------------------------------------------------------------------------#
# Description:  This method allows the Razoo global Admin to Edit the ORG Details.
# -----------------------------------------------------------------------------------------#

def verifyNpoDetails()	
	
	puts "************** START: Verify ORG Details ****************"
	$browser.click "link=View"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present($phone_num)
		puts "Updated Phone Number gets diplayed in the Story page."
	rescue Test::Unit::AssertionFailedError
		puts "Phone number is not updated."
	end
	begin
		assert $browser.is_text_present($ein_number)
		puts "Updated EIN Number gets diplayed in the Story page."
	rescue Test::Unit::AssertionFailedError
		puts "EIN number is not updated."
	end
	begin
		assert $browser.is_text_present($add_1)
		puts "Updated Address 1 gets diplayed in the Story page."
	rescue Test::Unit::AssertionFailedError
		puts "Address 1is not updated."
	end
	begin
		assert $browser.is_text_present($add_2)
		puts "Updated Address 2 gets diplayed in the Story page."
	rescue Test::Unit::AssertionFailedError
		puts "Address 2 is not updated."
	end
	begin
		assert $browser.is_element_present("link=Tell Your Story")
		puts "Passed. Tell Your Story link is displayed under ORG Completion Steps section."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Tell Your Story link is not displayed under ORG Completion Steps section."
	end
	begin
		assert $browser.is_element_present("link=Illustrate Your Story")
		puts "Passed. Illustrate Your Story link is displayed under ORG Completion Steps section."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Illustrate Your Story link is not displayed under ORG Completion Steps section."
	end
	begin
		assert $browser.is_element_present("link=Share It With Others")
		puts "Passed. Share It With Others link is displayed under ORG Completion Steps section."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Share It With Others link is not displayed under ORG Completion Steps section."
	end
		
	puts "************** END: Verify ORG Details ****************"
end


# -----------------------------------------------------------------------------------------#
# Description:  This method allows the Razoo global Admin to verify the Audit.
# -----------------------------------------------------------------------------------------#

def auditVerifyOrg(audit_notes, org_url)
	
	puts "************** START: Verify the Audit ****************"
	$browser.open "organizations/#{org_url}/audits"
	$browser.wait_for_page_to_load 
	sleep 5
	#***************** Link position check *****************#
	@verifyauditlink_topposition = $browser.get_element_position_top "link=Verify"
	puts "VerifyAudit link Top position : #{@verifyauditlink_topposition}"
	if @verifyauditlink_topposition == '427' or @verifyauditlink_topposition == '426'
		puts "UI Check : Pass. VerifyAudit link is present at the correct position in Audits screen."
	else
		puts "UI Check : Fail. VerifyAudit link is not present at the correct position in Audits screen."
	end
	$browser.click "link=Verify"
	$browser.wait_for_page_to_load 
	$browser.type "audit_details", audit_notes
	#***************** Button position check *****************#
	@createauditbutton_topposition = $browser.get_element_position_top "css=button[type=submit]"
	puts "CreateAudit button Top position : #{@createauditbutton_topposition}"
	if @createauditbutton_topposition == '764' or @createauditbutton_topposition == '749'
		puts "UI Check : Pass. CreateAudit button is present at the correct position in VerifyAudit screen."
	else
		puts "UI Check : Fail. CreateAudit button is not present at the correct position in VerifyAudit screen."
	end
	$browser.click "css=button[type=submit]"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Audit created.")
		puts "Audit created successfully"
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Audit not created successfully"
	end
	begin
		assert $browser.is_element_present("//img[@alt='Org_verified']")
		puts "Passed. Now, ORG is Verified."
	rescue Test::Unit::AssertionFailedError
		puts "Failed in verifying the ORG."
	end
	puts "************** END: Verify the Audit ****************"

end

def createSchool(admin_url,school_nces_id, school_name, school_city, school_state)	
	
	puts "************** START : Create a New School ****************"	
	$school_nces_id = school_nces_id
	$school_name = school_name
	sleep 3
	$browser.open admin_url
	$browser.wait_for_page_to_load 
	sleep 3
	$browser.open "admin/organizations/new"
	$browser.wait_for_page_to_load 
	sleep 3
	$browser.click "id=kind_school"
	sleep 10 
	$browser.type "//input[@id='org_name']", $school_name
	$browser.type "//input[@id='org_city']", school_city
	$browser.select "//select[@id='org_state']", school_state
	$browser.type "id=org_nces_id", $school_nces_id
	#***************** Button position check *****************#
	@createorgbutton_topposition = $browser.get_element_position_top "css=button[type=submit]"
	puts "CreateORG button Top position : #{@createorgbutton_topposition}"
	if @createorgbutton_topposition == '501' or @createorgbutton_topposition == '523'
		puts "UI Check : Pass. CreateORG button is present at the correct position in Create ORG screen."
	else
		puts "UI Check : Fail. CreateORG button is not present at the correct position in Create ORG screen."
	end
	$browser.click "css=button[type=\"submit\"]"
         #~ $browser.wait_for_page_to_load 
	#~ begin
		#~ assert $browser.is_text_present("New organization created")
		#~ puts "Passed. New ORG : #{neworg_name} successfully created."
	#~ rescue Test::Unit::AssertionFailedError
		#~ puts "@@@@@@@@@ FAILED @@@@@@@@@. Failed in creating a New ORG."
	#~ end
	puts "************** END : Create a New School ****************"	
end

def editSchoolDetails(org_url, first_name, last_name, add_1, add_2, org_emailid, phone_num)	
	
	puts "************** START: Edit School Details ****************"
		
	$add_1 = add_1
	$add_2 = add_2
	$phone_num = phone_num
	
	sleep 10
	puts "Old School ID is : #{$school_url}"
	$browser.click "link=show"
	$browser.type "//input[@id='story_new_url']", $school_url
	$browser.type "id=story_contact_first_name", first_name
	$browser.type "id=story_contact_last_name", last_name
	$browser.type "id=story_address1", $add_1
	$browser.type "id=story_address2", $add_2
	$browser.type "id=story_contact_email", org_emailid
	$browser.type "id=story_contact_phone", $phone_num
	$browser.select "id=org_razoo_group_1", "label=- Christian"
	#***************** Button position check *****************#
	@savebutton_topposition = $browser.get_element_position_top "css=button[type=submit]"
	puts "Save button Top position : #{@savebutton_topposition}"
	if @savebutton_topposition == '2915' or @savebutton_topposition == '2895'
		puts "UI Check : Pass. Save button is present at the correct position in EditORG screen."
	else
		puts "UI Check : Fail. Save button is not present at the correct position in EditORG screen."
	end
	$browser.click "css=button[type=submit]"
	$browser.wait_for_page_to_load 
	sleep 5
	begin
		assert $browser.is_text_present("Your page has been saved.")
		puts "Step 2 : Passed. ORG Details was successfully changed and saved."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed in updating the ORG Details."
	end
	
	puts "************** END: Edit School Details ****************"
end


# -------------------------------------------------------------------------------------------------#
# Description:  This method allows the user to become a Fan without making any donation.
# -------------------------------------------------------------------------------------------------#
def becomeFan()

	puts "************** START: Become a Fan - Explicit ****************"
	
	#***************** Link position check *****************#
	@becomefanlink_topposition = $browser.get_element_position_top "css=button.link.message"
	puts "BecomeFan link Top position : #{@becomefanlink_topposition}"
	if @becomefanlink_topposition == '1050' or @becomefanlink_topposition == '1039'
		puts "UI Check : Pass. BecomeFan link is present at the correct position in ORGStory screen."
	else
		puts "UI Check : Fail. BecomeFan link is not present at the correct position in ORGStory screen."
	end
	$browser.click "css=button.link.message"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("You are now a fan!")
		puts "Passed. I'm a Fan of #{$neworg_name} story :)"
	rescue Test::Unit::AssertionFailedError
		puts "Failed while becoming a Fan of #{$neworg_name} story."
	end
	
	puts "************** END: Become a Fan - Explicit ****************"
	
end

# -------------------------------------------------------------------------------------------------#
# Description:  This method allows the user to follow the other user's profile.
# -------------------------------------------------------------------------------------------------#
def followUser(einlessorg_url)

	puts "************** START: Follow User ****************"
	
	$browser.open einlessorg_url
	$browser.wait_for_page_to_load
	begin
		assert $browser.is_element_present("css=a > span.fn")
		puts "Pass. User Profile Name is displayed under 'Fans' section."
		$browser.click "css=a > span.fn"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_element_present("css=button.follow.ctrl")
			puts "Pass. Follow button is displayed in the Profile screen."
			$browser.click "css=button.follow.ctrl"
			sleep 2
			$browser.click "css=img.profile"
			$browser.wait_for_page_to_load
			$browser.click "link=My Profile"
			$browser.wait_for_page_to_load
			begin
				assert $browser.is_text_present("You followed Rajkumar Sithavan")
				puts "Pass. 'You followed Rajkumar Sithavan' text is displayed under My Activity section."
			rescue Test::Unit::AssertionFailedError
				puts "Fail. 'You followed Rajkumar Sithavan' text is not displayed under My Activity section."
			end
			begin
				assert $browser.is_text_present("Rajkumar Sithavan donated")
				puts "Pass. 'Rajkumar Sithavan donated' text is displayed under Follow section."
			rescue Test::Unit::AssertionFailedError
				puts "Fail. 'Rajkumar Sithavan donated' text is not displayed under Follow section."
			end
			$browser.click "link=Rajkumar Sithavan"
			$browser.wait_for_page_to_load
			$browser.click "xpath=(//button[@type='submit'])[2]"
			sleep 2
			begin
				assert $browser.is_element_present("css=button.follow.ctrl")
				puts "Pass. Unfollowed successfully. Follow button is back again :)"
			rescue Test::Unit::AssertionFailedError
				puts "Fail. Unfollowing is not successful. Follow button is still present."
			end
			$browser.click "css=img.profile"
			$browser.wait_for_page_to_load
			$browser.click "link=My Profile"
			$browser.wait_for_page_to_load
			begin
				assert $browser.is_text_present("No recent activity found.")
				puts "Pass. Unfollowed successfully. 'No recent activity found.' is displayed under Follow section."
			rescue Test::Unit::AssertionFailedError
				puts "Fail. Unfollowing is not successful. 'No recent activity found.' is not displayed under Follow section."
			end
			begin
				assert $browser.is_text_present("I followed Rajkumar Sithavan")
				puts "Fail. 'I followed Rajkumar Sithavan' text is displayed under My Activity section."
			rescue Test::Unit::AssertionFailedError
				puts "Pass. 'I followed Rajkumar Sithavan' text is removed from My Activity section."
			end
		rescue Test::Unit::AssertionFailedError
			puts "Fail. Follow button is not displayed in the Profile screen."
		end
	rescue Test::Unit::AssertionFailedError
		puts "Fail. User Profile Name is not displayed under 'Fans' section."
	end
	
	puts "************** END: Follow User ****************"
	
end


# -------------------------------------------------------------------------------------------------#
# Description:  This method allows the Razoo Admin to Impersonate Permission.
# -------------------------------------------------------------------------------------------------#
def impersonatePermission(admin_url, email_id, first_name, last_name)
	
	puts "************** START: Impersonate Permission ****************"
	
	$browser.click "//img[@alt='Your profile picture']"
	$browser.wait_for_page_to_load
	begin
		assert $browser.is_element_present("link=Permissions")
		#***************** Link position check *****************#
		@permissionslink_topposition = $browser.get_element_position_top "link=Permissions"
		puts "Permissions link Top position : #{@permissionslink_topposition}"
		if @permissionslink_topposition == '98' or @permissionslink_topposition == '95'
			puts "UI Check : Pass. Permissions link is present at the correct position in Account screen."
		else
			puts "UI Check : Fail. Permissions link is not present at the correct position in Account screen."
		end
		$browser.click "link=Permissions"
		$browser.wait_for_page_to_load 
		begin
			assert_equal "on", $browser.get_value("roles_impersonator")
		rescue Test::Unit::AssertionFailedError
			$browser.click "roles_impersonator"
		end
		puts "Activated the Impersonate checkbox."
		$browser.click "//button[@type='submit']"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_text_present("Permissions updated successfully!")
			puts "Step 1 : Passed. Impersonate Permissions updated successfully!"
		rescue Test::Unit::AssertionFailedError
			puts "Step 1 : Failed. Impersonate Permissions not updated successfully!"
		end
		
		$browser.open admin_url
		$browser.open "admin/impersonate"
		$browser.wait_for_page_to_load 
		sleep 5
		begin
			assert $browser.is_text_present("(you can also use email or the profile short token)")
			puts "Step 2 : Passed. Impersonate option gets displayed in the Admin screen."
		rescue Test::Unit::AssertionFailedError
			puts "Step 2 : failed. Impersonate option doesn't get displayed in the Admin screen."
		end
		$browser.type "email", ""
		$browser.type "email", email_id
		#***************** Button position check *****************#
		@impersonatebutton_topposition = $browser.get_element_position_top "//input[@value='impersonate']"
		puts "Impersonate button Top position : #{@impersonatebutton_topposition}"
		if @impersonatebutton_topposition == '363' or @impersonatebutton_topposition == '369'
			puts "UI Check : Pass. Impersonate button is present at the correct position in Impersonate screen."
		else
			puts "UI Check : Fail. Impersonate button is not present at the correct position in Impersonate screen."
		end
		$browser.click "//input[@value='impersonate']"
		$browser.wait_for_page_to_load 
		begin
			@user_name = first_name+" "+last_name
			assert $browser.is_text_present("#{@user_name}")
			puts "Step 3 : Passed. Razoo Admin successfully impersonated as #{@user_name}."
		rescue Test::Unit::AssertionFailedError
			puts "@@@@@@@@@ FAILED @@@@@@@@@. Step 3 : Razoo Admin failed impersonating as #{@user_name}."
		end
	rescue
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Permissions Access is not available for this User."
	end
	
	puts "************** END: Impersonate Permission ****************"
	
end

# ----------------------------------------------------------------------------------------------------------#
# Description:  This method allows the user to view the causes and ppl i like in Profile screen.
# ----------------------------------------------------------------------------------------------------------#
def causesAndPersonIlike(org2_url, org3_url, new_orgname3, first_name1, last_name, email_id1, first_name2, email_id2, pass_word)
	
	puts "************** START: Causes and Person i like ****************"
	
	puts "*************** User 1 creation *******************"
	# User 1 creation
	createRazooAccountSignupModal(first_name1, last_name, email_id1, pass_word)
	$browser.open org2_url
	$browser.wait_for_page_to_load 
	donation_amount = "10"; street = "Street"; city = "city"; state = "Kansas"; pin_code = "95008"; 
	card_number = "4111111111111111"; sec_code = "123"; 
	card_name = first_name1+" "+ last_name
	
	donateUsingNewCard(donation_amount, card_name, street, city, state, pin_code, card_number, sec_code, email_id1)
	sleep 2
	$browser.click "css=em"
	$browser.wait_for_page_to_load
	$browser.click "css=a.button > em"
	$browser.wait_for_page_to_load
	sleep 2
	$browser.click "link=Log out"
	$browser.wait_for_page_to_load
	# User 2 creation
	puts "*************** User 2 creation *******************"
	createRazooAccountSignupModal(first_name2, last_name, email_id2, pass_word)
	$browser.open org2_url
	$browser.wait_for_page_to_load 
	card_name = first_name2+" "+ last_name
	
	donateUsingNewCard(donation_amount, card_name, street, city, state, pin_code, card_number, sec_code, email_id2)
	sleep 2
	$browser.click "css=em"
	$browser.wait_for_page_to_load
	$browser.click "css=a.button > em"
	$browser.wait_for_page_to_load
	# User 2 makes a donation for ORG2
	puts "*************** User 2 makes a donation for ORG2 *******************"
	$browser.open org3_url
	$browser.wait_for_page_to_load 
	
	donateUsingNewCard(donation_amount, card_name, street, city, state, pin_code, card_number, sec_code, email_id2)
	sleep 2
	$browser.click "css=em"
	$browser.wait_for_page_to_load
	$browser.click "css=a.button > em"
	$browser.wait_for_page_to_load
	# Verify User1 details in User2 Profile screen
	puts "*************** Verify User1 details in User2 Profile screen *******************"
	sleep 2
	$browser.click "css=img[alt=\"Your profile picture\"]"
	$browser.wait_for_page_to_load 
	sleep 2
	$browser.click "link=My Profile"
	$browser.wait_for_page_to_load 
	puts "********** Verifying data under 'Person I May Know' section *********"
	begin
		assert $browser.is_element_present("//img[@alt='#{first_name1} Last Name']")
		puts "Pass. #{first_name1} image is displayed under User2 Profile screen."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. #{first_name1} is not displayed under User2 Profile screen."
	end
	begin
		assert $browser.is_element_present("link=#{first_name1} Last Name")
		puts "Pass. #{first_name1} is displayed under User2 Profile screen."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. #{first_name1} is not displayed under User2 Profile screen."
	end
	begin
		assert $browser.is_element_present("css=img.snapshot.photo")
		puts "Pass. Person I May Know image is displayed under User1 Profile screen."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. Person I May Know image is not displayed under User1 Profile screen."
	end
	sleep 2
	$browser.click "link=Log out"
	$browser.wait_for_page_to_load
	# Verify User2 details in User1 Profile screen
	puts "*************** Verify User2 details in User1 Profile screen *******************"
	login(email_id1, pass_word)
	puts "********** Verifying data under 'Cause I May Know' section ************"
	begin
		assert $browser.is_element_present("//img[@alt='#{first_name2} Last Name']")
		puts "Pass. #{first_name2} image is displayed under User1 Profile screen."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. #{first_name2} image is not displayed under User1 Profile screen."
	end
	begin
		assert $browser.is_element_present("link=#{first_name2} Last Name")
		puts "Pass. #{first_name2} is displayed under User1 Profile screen."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. #{first_name2} is not displayed under User1 Profile screen."
	end
	
	begin
		assert $browser.is_element_present("css=img.snapshot.photo")
		puts "Pass. Person I May Know image is displayed under User1 Profile screen."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. Person I May Know image is not displayed under User1 Profile screen."
	end
	begin
		assert $browser.is_element_present("//img[@alt='Gold_size_36x36']")
		puts "Pass. Cause I May Like image is displayed under User1 Profile screen."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. Cause I May Like image is not displayed under User1 Profile screen."
	end
	begin
		assert $browser.is_element_present("link=#{new_orgname3}")
		puts "Pass. #{new_orgname3} ORG is displayed under User1 Cause I May Know section."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. #{new_orgname3} ORG is not displayed under User1 Cause I May Know section."
	end
	puts "************** END: Causes and Person i like ****************"
end

# ---------------------------------------------------------------------------------------------------------#
# Description:  This method allows the story page visitor to embed the FB widget on FB page.
# ---------------------------------------------------------------------------------------------------------#

def installWidget(fb_emailId, fb_password)
	
	puts "************** START: Install Widget on Facebook ****************"
	
	begin
		assert $browser.is_element_present("css=div.facebook_button")
		puts "Pass. Install Widget button is present in the story page."
		$browser.click "css=div.facebook_button"
		$browser.wait_for_page_to_load 
		$browser.type "id=email", fb_emailId
		$browser.type "id=pass", fb_password
		begin
			assert $browser.is_text_present("Facebook Login")
			puts "Pass. User has reached the Facebook Login screnn."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. User has failed to reach the Facebook Login screnn."
		end
		$browser.click "login"
		$browser.wait_for_page_to_load
		begin
			assert $browser.is_element_present("id=u89vmw_1")
			puts "Pass. 'Goto Razoo App' button is present."
			$browser.click "id=u89vmw_1"
			$browser.wait_for_page_to_load
		rescue Test::Unit::AssertionFailedError
			puts "Fail. 'Goto Razoo App' button is not present."
		end
		begin
			assert $browser.is_element_present("id=u8a6ly_1")
			puts "Pass. 'Allow' button is present."
			$browser.click "id=u8a6ly_1"
			$browser.wait_for_page_to_load
		rescue Test::Unit::AssertionFailedError
			puts "Pass. 'Allow' button is not present."
		end
		begin
			assert $browser.is_text_present("Congratulations! Installation was successful.")
			puts "Pass. Success Widget installation."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. Widget Installation Failure"
		end
		begin
			assert $browser.is_element_present("link=Visit your facebook app")
			puts "Pass. Visit your facebook app button is present in the Congratulations screen."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. Visit your facebook app button is not present in the Congratulations screen."
		end
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Install Widget button is not present in the story page."
	end
	
	puts "************** END: Install Widget on Facebook ****************"
end


# -------------------------------------------------------------------------------------------------#
# Description:  This method allows the Story Admin to delete his story page from Razoo.
# -------------------------------------------------------------------------------------------------#

def deleteMyStoryPage(pro_name)
	
	puts "************** START: Delete My Story page ****************"
	
	$browser.click "css=img[alt=\"Your profile picture\"]"
	$browser.wait_for_page_to_load 
	$browser.click "link=My Profile"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_element_present("xpath=(//a[contains(text(),'donate')])[2]")
		puts "Pass. #{pro_name} story link is present in the Profile screen."
		$browser.click "xpath=(//a[contains(text(),'donate')])[2]"
		$browser.wait_for_page_to_load 
		$browser.click "link=Edit"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_element_present("link=Delete this project")
			puts "Pass. 'Delete this project' link is present in the Edit page."
			$browser.click "link=Delete this project"
			$browser.wait_for_page_to_load
		rescue Test::Unit::AssertionFailedError
			puts "Pass. 'Delete this project' link is not present in the Edit page."
		end
		begin
			assert $browser.is_text_present("exact:#{pro_name}?")
			puts "Pass. User has reached delete confirmation screen."
			$browser.click "name=commit"
			$browser.wait_for_page_to_load 
		rescue Test::Unit::AssertionFailedError
			puts "Fail. User has failed to reach delete confirmation screen."
		end
		begin
			assert $browser.is_text_present("#{pro_name} was successfully deleted.")
			puts "Pass. #{pro_name} story page has been deleted sucessfully from the application."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. #{pro_name} story page has not deleted sucessfully from the application."
		end	
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. #{pro_name} story link is not present in the Profile screen."
	end
	
	puts "************** END: Delete My Story page ****************"
end


# -------------------------------------------------------------------------------------------------#
# Description:  This method allows the User to login via Google Account.
# -------------------------------------------------------------------------------------------------#
def loginViaGmail(gmail_emailId, gmail_password)
	
	puts "************** START: Login Via Gmail ****************"
	$browser.click "link=Sign up"
	sleep 2
	$browser.click "link=Sign up with Google"
	$browser.wait_for_page_to_load 
	$browser.type "Email", gmail_emailId
	$browser.type "Passwd", gmail_password
	$browser.click "signIn"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_element_present("approve_button")
		$browser.click "approve_button"
		$browser.wait_for_page_to_load 
	rescue Test::Unit::AssertionFailedError
	end

	begin
		assert $browser.is_text_present("Login successful!")
		puts "Step 1 : Passed. User gets logged in successfully into Razoo via Gmail."
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Step 1 : User failed to log in successfully into Razoo via Gmail."
	end
	$browser.click "//img[@alt='Your profile picture']"
	$browser.wait_for_page_to_load
	$browser.click "link=Account Settings"
	$browser.wait_for_page_to_load
	begin
		assert_equal gmail_emailId, $browser.get_value("user_email")
		puts "Step 2 : Passed. Gmail emailId gets successfully displayed in the Account Settings screen."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. Gmail emailId doesn't get displayed in the Account Settings screen."
	end
	begin
		assert $browser.is_element_present("//img[@alt='Google_64']")
		puts "Step 3 : Passed. Google image gets displayed under connection section."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Failed. Google image is not displayed successfully under connection section."
	end
	
	begin
		assert $browser.is_element_present("link=(Remove)")
		$browser.click "link=(Remove)"
		sleep 5
		assert /^Are you sure you want to remove the connection with Google[\s\S]$/ =~ $browser.get_confirmation
		sleep 5
		begin
			assert $browser.is_text_present("Successfully disconnected Google from your account")
			puts "Step 4 : Passed. Successfully disconnected Google from Razoo account."
		rescue Test::Unit::AssertionFailedError
			puts "Step 4 : Failed in disconnecting Google from Razoo account."
		end
	rescue Test::Unit::AssertionFailedError
	end
	puts "************** End: Login Via Gmail ****************"
end

# -------------------------------------------------------------------------------------------------#
# Description:  This method allows the User to login via FB Account.
# -------------------------------------------------------------------------------------------------#
def loginViaFacebook(fb_emailId, fb_password)
	
	puts "************** START: Login Via FB ****************"
	$browser.click "link=Sign up"
	sleep 2
	#$browser.click "css=div.gutter > a > img[alt=\"Facebook\"]"
	$browser.click "id=modal-signup-fb"
	sleep 15
	$browser.type "email", fb_emailId
	$browser.type "pass", fb_password
	$browser.click "login"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_element_present("approve_button")
		$browser.click "approve_button"
		$browser.wait_for_page_to_load 
	rescue Test::Unit::AssertionFailedError
	end
	begin
		assert $browser.is_text_present("Login successful!")
		puts "Step 1 : Passed. User gets logged in successfully into Razoo via Gmail."
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Step 1 : User failed to log in successfully into Razoo via Gmail."
	end
	$browser.click "//img[@alt='Your profile picture']"
	$browser.wait_for_page_to_load
	$browser.click "link=Account Settings"
	$browser.wait_for_page_to_load
	begin
		assert_equal fb_emailId, $browser.get_value("user_email")
		puts "Step 2 : Passed. Facebook emailId gets successfully displayed in the Account Settings screen."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. Facebook emailId doesn't get displayed in the Account Settings screen."
	end
	begin
		assert $browser.is_element_present("//img[@alt='Facebook_64']")
		puts "Step 3 : Passed. Facebook image gets displayed under connection section."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Failed. Facebook image is not displayed successfully under connection section."
	end
	begin
		assert $browser.is_element_present("link=(Remove)")
		$browser.click "link=(Remove)"
		sleep 5
		assert /^Are you sure you want to remove the connection with Facebook[\s\S]$/ =~ $browser.get_confirmation
		sleep 5
		begin
			assert $browser.is_text_present("Successfully disconnected Facebook from your account")
			puts "Step 4 : Passed. Successfully disconnected Facebook from Razoo account."
		rescue Test::Unit::AssertionFailedError
			puts "Step 4 : Failed in disconnecting Facebook from Razoo account."
		end
	rescue Test::Unit::AssertionFailedError
	end
	puts "************** End: login Via FB ****************"
end

# --------------------------------------------------------------------------------------#
# Description:  This method allows the user to logout from the Razoo application.
# --------------------------------------------------------------------------------------#
def logout()
	
	puts "************** START : Log out from Razoo ****************"
	sleep 2
	#***************** Link position check *****************#
	@logoutlink_topposition = $browser.get_element_position_top "link=Log out"
	puts "Logout link Top position : #{@logoutlink_topposition}"
	if @logoutlink_topposition == '12' or @logoutlink_topposition == '11'
		puts "UI Check : Pass. Logout link is present at the correct position in Team screen."
	else
		puts "UI Check : Fail. Logout link is not present at the correct position in Team screen."
	end
	$browser.click "link=Log out"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_element_present("link=Log in")
		puts "Passed. Logged out Successfully from the Application!"
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Logout is Failed."
	end
	puts "************** END : Log out from Razoo ****************"
	
end

# --------------------------------------------------------------------------------------#
# Description:  This method allows the Razoo Admin to run Hack URL.
# --------------------------------------------------------------------------------------#
def runHackURL(reindex_hack, reindexall_hack, memcache_hack, regstats_hack)
	
	puts "************** START : Run Hack URL ****************"
	$browser.open reindexall_hack
	$browser.wait_for_page_to_load 
	sleep 5
	$browser.go_back()
	puts "Reindex_all Hack URL is finished running."
	$browser.open memcache_hack
	$browser.wait_for_page_to_load 
	sleep 5
	$browser.go_back()
	puts "Memcache Hack URL is finished running."
	$browser.open regstats_hack
	$browser.wait_for_page_to_load 
	sleep 5
	$browser.open "/"
	puts "Regenerate Stats Hack URL is finished running."
	puts "************** END : Run Hack URL ****************"
	
end


# --------------------------------------------------------------------------------------#
# Description:  This method will stop the running browser.
# --------------------------------------------------------------------------------------#
def stopBrowser()
	
	#$browser.close_current_browser_session()
	$browser.stop
	
end