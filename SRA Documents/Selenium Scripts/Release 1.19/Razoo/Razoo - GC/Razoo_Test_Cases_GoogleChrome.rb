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
		:timeout_in_second => 60

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
		assert $browser.is_text_present("Already a Member?")
		puts "Click on 'Sign Up' link in the donation form screen."
		#***************** Link position check *****************#
		@createaccountlink_topposition = $browser.get_element_position_top "link=create an account"
		puts "Create acount link Top position : #{@createaccountlink_topposition}"
		if @createaccountlink_topposition == '250'
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
		if @signuplink_topposition == '9'
			puts "UI Check : Pass. Signup link is present at the correct position in Home screen."
		else
			puts "UI Check : Fail. Signup link is not present at the correct position in Home screen."
		end
		$browser.click "link=Sign up"
		$browser.wait_for_page_to_load
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
	#***************** Button position check *****************#
	@createaccountbutton_topposition = $browser.get_element_position_top "//button[@type='submit']"
	puts "Create Account button Top position : #{@createaccountbutton_topposition}"
	if @createaccountbutton_topposition == '642'
		puts "UI Check : Pass. CreateAccount button is present at the correct position in Signup screen."
	else
		puts "UI Check : Fail. CreateAccount button is not present at the correct position in Signup screen."
	end
	$browser.click "//button[@type='submit']"
	$browser.wait_for_page_to_load
		 
	begin
		assert $browser.is_text_present("Donors")
		begin
			assert $browser.is_text_present("Your account has been created.")
			$user_name = first_name+" "+ last_name
			puts "Step 2 : Passed. Account has been created successfully! and retained in the Donation Form screen."
		rescue Test::Unit::AssertionFailedError
		begin
			assert $browser.is_text_present("Email is already in use by another account (if it's yours, you can recover your account password from the login screen)")
			puts "Step 2 : Failed. #{email_id} has already been taken."
		rescue Test::Unit::AssertionFailedError
			puts "Step 2 : Failed. Account not created successfully!"
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
			puts "Step 2 : Failed. Account not created successfully!"
		end
		end
		begin
			assert $browser.is_element_present("//img[@alt='Your profile picture']")
			$browser.click "//img[@alt='Your profile picture']"
			$browser.wait_for_page_to_load 
			$browser.click "link=My Profile"
			$browser.wait_for_page_to_load 
			begin
				$user_name = first_name+" "+ last_name
				assert $browser.is_text_present($user_name)
				puts "Step 3 : Passed. #{$user_name} gets displayed in Account screen."
			rescue Test::Unit::AssertionFailedError
				puts "Step 3 : Failed. #{$user_name} doesn't get displayed in Account screen."
			end
		rescue Test::Unit::AssertionFailedError
			puts "No header links displayed in the Thank you screen."
			$browser.click "link=No Thanks"
			$browser.wait_for_page_to_load
		end
		
	end
	puts "************** END : Create a Razoo Account ****************"	
end

# ------------------------------------------------------------------------------#
# Description:  This method allows the user to login to Razoo application.
# ------------------------------------------------------------------------------#
def login(email_id, pass_word)
	
	puts "************** START : Login to Razoo ****************"	
	sleep 5
	#***************** Link position check *****************#
	@loginlink_topposition = $browser.get_element_position_top "link=Log in"
	puts "Login link Top position : #{@loginlink_topposition}"
	if @loginlink_topposition == '9'
		puts "UI Check : Pass. Login link is present at the correct position in Home screen."
	else
		puts "UI Check : Fail. Login link is not present at the correct position in Home screen."
	end
	$browser.click "link=Log in"
	$browser.wait_for_page_to_load 
	sleep 5
	puts "Step 1 : Entering valid User credintials - User Name as #{email_id} and Password as #{pass_word}"
	$browser.type "user_session_email", email_id 
	$browser.type "user_session_password", pass_word
	#***************** Button position check *****************#
	@loginbutton_topposition = $browser.get_element_position_top "//button[@type='submit']"
	puts "Login button Top position : #{@loginbutton_topposition}"
	if @loginbutton_topposition == '397'
		puts "UI Check : Pass. Login button is present at the correct position in Login screen."
	else
		puts "UI Check : Fail. Login button is not present at the correct position in Login screen."
	end
	$browser.click "//button[@type='submit']"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Login successful!")
		puts "Step 2 : Passed. Login was Successful!!!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. Login Failed"
	end
	puts "************** END : Login to Razoo ****************"	
end


# ------------------------------------------------------------------------------#
# Description:  This method allows the user to Reset the password.
# ------------------------------------------------------------------------------#
def changeMyPassword(new_password)
	
	puts "************** START : Reset my password ****************"	
	
	$browser.click "//img[@alt='Your profile picture']"
	$browser.wait_for_page_to_load 
	sleep 2
	#***************** Link position check *****************#
	@accountsettingslink_topposition = $browser.get_element_position_top "link=Account Settings"
	puts "Account Settings link Top position : #{@accountsettingslink_topposition}"
	if @accountsettingslink_topposition == '258'
		puts "UI Check : Pass. AccountSettings link is present at the correct position in MyAccount screen."
	else
		puts "UI Check : Fail. AccountSettings link is not present at the correct position in MyAccount screen."
	end
	$browser.click "link=Account Settings" 
	$browser.wait_for_page_to_load 
	puts "Step 1: Enter password and password confirmation"
	$browser.type "user_password", new_password
	$browser.type "user_password_confirmation", new_password
	#***************** Button position check *****************#
	@savechangesbutton_topposition = $browser.get_element_position_top "//button[@type='submit']"
	puts "Save Changes button Top position : #{@savechangesbutton_topposition}"
	if @savechangesbutton_topposition == '499'
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
	end
 
	puts "************** END : Reset my password ****************"	
end


#-------------------------------------------------------------------------#
# Description:  This method allows the user to search ORG
# -------------------------------------------------------------------------#

def searchOrg(org_name)
	
	$story_name = org_name
	puts "************** START: Search ORG ****************"
	$browser.highlight "//input[@type='image']"
	#***************** Button position check *****************#
	@donatebutton_topposition = $browser.get_element_position_top "//input[@type='image']"
	puts "Donate button Top position : #{@donatebutton_topposition}"
	if @donatebutton_topposition == '54'
		puts "UI Check : Pass. Donate button is present at the correct position in Home screen."
	else
		puts "UI Check : Fail. Donate button is not present at the correct position in Home screen."
	end
	$browser.click "//input[@type='image']"
	$browser.wait_for_page_to_load
	sleep 2
	#***************** Checkbox position check *****************#
	@procheckbox_topposition = $browser.get_element_position_top "projectScope"
	puts "Project checkbox Top position : #{@procheckbox_topposition}"
	if @procheckbox_topposition == '262'
		puts "UI Check : Pass. Project checkbox is present at the correct position in Search screen."
	else
		puts "UI Check : Fail. Project checkbox is not present at the correct position in Search screen."
	end
	$browser.click "projectScope"
	sleep 3
	#***************** Checkbox position check *****************#
	@frcheckbox_topposition = $browser.get_element_position_top "widgetScope"
	puts "FR checkbox Top position : #{@frcheckbox_topposition}"
	if @frcheckbox_topposition == '9'
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
	if @searchbutton_topposition == '215'
		puts "UI Check : Pass. Search button is present at the correct position in Search screen."
	else
		puts "UI Check : Fail. Search button is not present at the correct position in Search screen."
	end
	$browser.click "//button[@type='submit']"
	sleep 10
	puts "Step 2 : Click on #{$story_name} link"
	$browser.click "//a[contains(text(),'#{$story_name}')]"
	$browser.wait_for_page_to_load
	begin
		assert_equal "#{$story_name} - Razoo", $browser.get_title
		puts "Step 3 : Passed. User reached #{$story_name} Story Page successfully!!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Failed. Problem in reaching the ORG Story page."
	end
	puts "************** END : Search ORG ****************"
end

#-------------------------------------------------------------------------#
# Description:  This method allows the user to search Project.
# -------------------------------------------------------------------------#

def searchProject(project_name)
	
	$story_name = project_name
	begin
		assert $browser.is_element_present("link=No Thanks")
		$browser.click "link=No Thanks"
		$browser.wait_for_page_to_load
	rescue Test::Unit::AssertionFailedError
	end
	puts "************** START: Search PROJECT ****************"
	$browser.click "//input[@type='image']"
	$browser.wait_for_page_to_load
	sleep 2
	#***************** Checkbox position check *****************#
	@orgcheckbox_topposition = $browser.get_element_position_top "orgScope"
	puts "ORG checkbox Top position : #{@orgcheckbox_topposition}"
	if @orgcheckbox_topposition == '262'
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
	$browser.click "//a[contains(text(),'#{$story_name}')]"
	$browser.wait_for_page_to_load
	begin
		assert_equal "#{$story_name} - Razoo", $browser.get_title
		puts "Step 3 : Passed. User reached #{$story_name} Story Page successfully!!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Failed. Problem in reaching the Project Story page."
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
		puts "Step 3 : Failed. Problem in reaching the Project Story page."
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
	#***************** Button position check *****************#
	@donatebutton_topposition = $browser.get_element_position_top "//p/button[@type='submit']/em"
	puts "Donate button Top position : #{@donatebutton_topposition}"
	if @donatebutton_topposition == '54'
		puts "UI Check : Pass. Donate button is present at the correct position in Story screen."
	else
		puts "UI Check : Fail. Donate button is not present at the correct position in Story screen."
	end
	$browser.click "//p/button[@type='submit']/em"
	$browser.wait_for_page_to_load 
	begin
		assert_equal "Raise Money for Nonprofits and Charities Online - Razoo", $browser.get_title
		puts "Step 1 : User reached Donation Form page successfully!!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 : Failed. Problem in reaching the Donation Form page."
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
	$browser.type "name=donation[amount]", donation_amount
	$browser.click "//p/button[@type='submit']/em"
	$browser.wait_for_page_to_load 
	begin
		assert_equal "Raise Money for Nonprofits and Charities Online - Razoo", $browser.get_title
		puts "Step 1 : User reached Donation Form page successfully!!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 : Failed. Problem in reaching the Donation Form page."
	end
	
	begin
		assert $browser.is_text_present("Already a Member?")
		puts "Step 2 : Enter valid user credentials - #{email_id} and #{pass_word} "
		$browser.type "user_session_email", email_id 
		$browser.type "user_session_password", pass_word
		#***************** Button position check *****************#
		@loginbutton_topposition = $browser.get_element_position_top "//div[@id='authPortable']/div/form/div[1]/button"
		puts "Login button Top position : #{@loginbutton_topposition}"
		if @loginbutton_topposition == '397'
			puts "UI Check : Pass. Login button is present at the correct position in DonationForm screen."
		else
			puts "UI Check : Fail. Login button is not present at the correct position in DonateForm screen."
		end
		$browser.click "//div[@id='authPortable']/div/form/div[1]/button"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_text_present("Login successful!")
			puts "Step 3 : Passed. Login was Successful!!!"
		rescue Test::Unit::AssertionFailedError
			puts "Step 3 : Failed. Login Failed"
		end
	rescue
		puts "Failed. 'Already a Member?' frame is not available."		
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
		assert $browser.is_text_present($story_name)
		puts "Passed. Story Header gets displayed in the Donation Form screen."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Story Header is not displayed in the Donation Form screen."
	end
	
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
			assert $browser.is_text_present("Login successful!")
			assert $browser.is_text_present($donation_amount_retain)
			puts "Step 1 : Entered amount $#{$donation_amount_retain} gets displayed in the DF screen."
		rescue Test::Unit::AssertionFailedError
			
			puts "Step 1 : Enter donation amount - $#{donation_amount}"
			$browser.type "name=donation[amount]", donation_amount
			$browser.click "//p/button[@type='submit']/em"
			$browser.wait_for_page_to_load 
			begin
				assert_equal "Raise Money for Nonprofits and Charities Online - Razoo", $browser.get_title
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
	
	puts "Step 2 : Entering Card Details : User Name - #{$user_name}, Name on Card - #{name_on_card}, #{card_number}, #{$email_id}"
	$browser.type "order_user_order_credit_card_attributes_full_name", name_on_card
	$browser.type "order_user_order_credit_card_attributes_address1", street
	$browser.type "order_user_order_credit_card_attributes_city", city
	$browser.select  "order_user_order_credit_card_attributes_state", "label=#{state}"
	$browser.type "order_user_order_credit_card_attributes_postal_code", pin_code
	$browser.type "cardNumber", card_number
	$browser.type "order_user_order_credit_card_attributes_security_code", sec_code
	begin
	#GUEST USER DONATION
		assert $browser.is_text_present("Also create an account on GiveMN")
		$browser.type "order_user_order_email", $email_id
	rescue Test::Unit::AssertionFailedError
	end

	begin
		assert $browser.is_element_present("create_account")
		$browser.click "create_account"
	rescue Test::Unit::AssertionFailedError
		puts "I'm Logged in user! Create an account checkbox is not present."
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
	if @donatenowbutton_topposition == '1560'
		puts "UI Check : Pass. DonateNow button is present at the correct position in DF screen."
	else
		puts "UI Check : Fail. DonateNow button is not present at the correct position in DF screen."
	end
	$browser.click "//p[@id='donationSubmit']/button"
	begin
		assert $browser.is_text_present("Processing Donation...")
		puts "Processing Donation... Success!!"
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Processing Donation... failed"
	end
	$browser.wait_for_page_to_load
	begin
		assert $browser.is_text_present("Your donation was successful! We'll send you a confirmation email receipt shortly.")
		puts "Step 4 : Passed. Donation was Successful! and User reached the Thank You screen."
	rescue Test::Unit::AssertionFailedError
		puts "Step 4 : Failed. Donation was Failed!"
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
	$browser.click "//p/button[@type='submit']/em"
	$browser.wait_for_page_to_load 
	begin
		assert_equal "Raise Money for Nonprofits and Charities Online - Razoo", $browser.get_title
		puts "Passed. User reached Donation Form page successfully!!"
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Problem in reaching the Donation Form page."
	end
	
	begin
		assert $browser.is_text_present($story_name)
		puts "Passed. Story Header gets displayed in the Donation Form screen."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Story Header is not displayed in the Donation Form screen."
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
	
	$browser.click "//p[@id='donationSubmit']/button"
	begin
		assert $browser.is_text_present("Processing Donation...")
		puts "Processing Donation... Success!!"
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Processing Donation...!!!"
	end
	$browser.wait_for_page_to_load
	begin
		assert $browser.is_text_present("Your donation was successful! We'll send you a confirmation email receipt shortly.")
		puts "Step 4 : Passed. Donation was Successful! and User reached the Thank You screen."
	rescue Test::Unit::AssertionFailedError
		puts "Step 4 : Failed. Donation was Failed!"
	end

	$browser.click "link=No Thanks"
	$browser.wait_for_page_to_load
	
	puts "************** END : Make a donation using Saved Card ****************"	
end

#------------------------------------------------------------------------------------------------------#
# Description:  This method allows the user to make a donation by using Add a new saved Card
# -----------------------------------------------------------------------------------------------------#

def donateUsingAddCreditCard(donation_amount, street, city, state, pin_code,  card_number, sec_code, donate_weekly)
	
	puts "************** START : Make a donation using Add Credit Card ****************"	
	sleep 5
	begin
		assert $browser.is_element_present("recurring_donation")
		puts "Passed. Recurring donation option gets displayed in the Story page."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Recurring donation option is not displayed in the Story page."
	end
	puts "Step 1 : Enter donation amount - $#{donation_amount}"
	$browser.type "name=donation[amount]", donation_amount
	$browser.click "//p/button[@type='submit']/em"
	$browser.wait_for_page_to_load 
	begin
		assert_equal "Raise Money for Nonprofits and Charities Online - Razoo", $browser.get_title
		puts "Passed. User reached Donation Form page successfully!!"
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Problem in reaching the Donation Form page."
	end
	
	begin
		assert $browser.is_text_present($story_name)
		puts "Passed. Story Header gets displayed in the Donation Form screen."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Story Header is not displayed in the Donation Form screen."
	end
	
	begin 
		assert_equal donation_amount, $browser.get_value("donation_amount")
		puts "Step 2 : Selected suggested amount $#{donation_amount} gets displayed in the DF screen."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. Incorrect donation amount gets displayed."
	end
	sleep 5
	puts "Step 3 : Selected a recurring donation"
	$browser.select "order_user_order_recurring_donation", donate_weekly 
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
	$browser.select "order_user_order_credit_card_attributes_state", "label=#{state}"
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
	
	$browser.click "//p[@id='donationSubmit']/button"
	begin
		assert $browser.is_text_present("Processing Donation...")
		puts "Processing Donation... Success!!"
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Processing Donation... failed"
	end
	$browser.wait_for_page_to_load
	begin
		assert $browser.is_text_present("Your donation was successful! We'll send you a confirmation email receipt shortly.")
		puts "Step 6 : Passed. Donation was Successful! and User reached the Thank You screen."
	rescue Test::Unit::AssertionFailedError
		puts "Step 6 : Failed. Donation was Failed!"
	end
		
	puts "************** END : Make a donation using Saved Card ****************"
end

#------------------------------------------------------------------------------------------------------#
# Description:  This method allows the user to make a donation through Donation Widget.
# -----------------------------------------------------------------------------------------------------#

def donationWidget(donation_amount, widget_emailid, widget_fullname, widget_street, widget_city, widget_state, widget_pcode, card_number, sec_code, tip_amount)
	
	puts "************** START : Donation Widget ****************"
	$browser.click "link=Share"
	$browser.wait_for_page_to_load 
	sleep 5
	puts "Step 1 : Enter donation amount in the First screen."
	$browser.type "transaction5", donation_amount
	#***************** Button position check *****************#
	@donatenowbutton_topposition = $browser.get_element_position_top "//div[@id='donation']/a/em"
	puts "DonateNow button Top position : #{@donatenowbutton_topposition}"
	if @donatenowbutton_topposition == '445'
		puts "UI Check : Pass. DonateNow button is present at the correct position in DonateAnywhere screen."
	else
		puts "UI Check : Fail. DonateNow button is not present at the correct position in DonateAnywhere screen."
	end
	$browser.click "//div[@id='donation']/a/em"
	sleep 2
	puts "Step 2 : Enter Billing details in the Second screen."
	$browser.type "order_user_order_email", widget_emailid
	$browser.type "order_user_order_credit_card_attributes_full_name", widget_fullname
	$browser.type "order_user_order_credit_card_attributes_address1", widget_street
	$browser.type "order_user_order_credit_card_attributes_city", widget_city
	$browser.select "order_user_order_credit_card_attributes_state", widget_state
	$browser.type "order_user_order_credit_card_attributes_postal_code", widget_pcode
	#***************** Button position check *****************#
	@carddetailsbutton_topposition = $browser.get_element_position_top "//div[@id='billing']/a[2]/em"
	puts "CardDetails button Top position : #{@carddetailsbutton_topposition}"
	if @carddetailsbutton_topposition == '445'
		puts "UI Check : Pass. CardDetails button is present at the correct position in DonateAnywhere screen."
	else
		puts "UI Check : Fail. CardDetails button is not present at the correct position in DonateAnywhere screen."
	end
	$browser.click "//div[@id='billing']/a[2]/em"
	sleep 2
	
	puts "Step 3 : Enter Card details in the Third screen."
	$browser.type "order_user_order_credit_card_attributes_card_number", card_number
	$browser.type "order_user_order_credit_card_attributes_security_code", sec_code
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
	#***************** Button position check *****************#
	@paynowbutton_topposition = $browser.get_element_position_top "//button[@type='submit']"
	puts "PayNow button Top position : #{@paynowbutton_topposition}"
	if @paynowbutton_topposition == '430'
		puts "UI Check : Pass. PayNow button is present at the correct position in DonateAnywhere screen."
	else
		puts "UI Check : Fail. PayNow button is not present at the correct position in DonateAnywhere screen."
	end
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
	if @offlinelink_topposition == '442'
		puts "UI Check : Pass. Offline link is present at the correct position in Story screen."
	else
		puts "UI Check : Fail. Offline link is not present at the correct position in Story screen."
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
	if @addonationbutton_topposition == '651'
		puts "UI Check : Pass. Addonation button is present at the correct position in Offline screen."
	else
		puts "UI Check : Fail. Addonation button is not present at the correct position in Offline screen."
	end
	$browser.click "//button[@type='submit']"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("The donation has been added.")
		puts "Step 2 : Passed. Offline donations gets successfully added."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. Offline donations doesn't get added successfully."
	end
	#***************** Link position check *****************#
	@viewlink_topposition = $browser.get_element_position_top "link=View"
	puts "View link Top position : #{@viewlink_topposition}"
	if @viewlink_topposition == '501'
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
	puts "Offline link is not available for this story page."
	end
	
	puts "************** END : Create Offline donation ****************"
	
end


# --------------------------------------------------------------------------------------------------------#
# Description:  This method allows the User to verify his donation under 'My Donation' screen.
# --------------------------------------------------------------------------------------------------------#
  
def checkMydonation(donation_amount)
	
	puts "************** START : Check My Donation ****************"
	
	#***************** Link position check *****************#
	@myaccountlink_topposition = $browser.get_element_position_top "//img[@alt='Your profile picture']"
	puts "My Account link Top position : #{@myaccountlink_topposition}"
	if @myaccountlink_topposition == '9'
		puts "UI Check : Pass. MyAccount link is present at the correct position in Home screen."
	else
		puts "UI Check : Fail. MyAccount link is not present at the correct position in Home screen."
	end
	$browser.click "//img[@alt='Your profile picture']"
	$browser.wait_for_page_to_load 
	#***************** Link position check *****************#
	@mydonationslink_topposition = $browser.get_element_position_top "link=My Donations"
	puts "Mydonations link Top position : #{@mydonationslink_topposition}"
	if @mydonationslink_topposition == '258'
		puts "UI Check : Pass. Mydonations link is present at the correct position in Account screen."
	else
		puts "UI Check : Fail. Mydonations link is not present at the correct position in Account screen."
	end
	$browser.click "link=My Donations"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present(donation_amount)
		puts "Success!. My donation gets displayed under 'My Donation' screen."
	rescue Test::Unit::AssertionFailedError
		puts "Failure!. My donation doesn't get displayed under 'My Donation' screen."
	end
	
	puts "************** END : Check My Donation ****************"

end


# ------------------------------------------------------------------------------------------------#
# Description:  This method allows the Normal User to share the story page thorugh Email.
# ------------------------------------------------------------------------------------------------#
  
def normalUserSharePage()
	
	puts "************** START : Share page - Normal User ****************"	
	
	begin
		assert $browser.is_text_present("Thank you for your generosity!")
		puts "Passed. User has successfully reached the Share page."
	rescue Test::Unit::AssertionFailedError
		puts "Failed to reach the Share page."
	end
	#***************** Link position check *****************#
	@imdonelink_topposition = $browser.get_element_position_top "link=I'm done"
	puts "Mydonations link Top position : #{@imdonelink_topposition}"
	if @imdonelink_topposition == '620'
		puts "UI Check : Pass. Imdone link is present at the correct position in Share screen."
	else
		puts "UI Check : Fail. Imdone link is not present at the correct position in Share screen."
	end
	$browser.click "link=I'm done"
	$browser.wait_for_page_to_load 
	
	
	puts "************** END : Share page - Normal User ****************"	
end


# --------------------------------------------------------------------------------------#
# Description:  This method allows the user to post and verify the comments.
# --------------------------------------------------------------------------------------#
  
def postComments(donor_comment)
	
	puts "************** START : Post Comment ****************"	
	sleep 5
	$browser.type "comment_body", donor_comment
	#***************** Button position check *****************#
	@postbutton_topposition = $browser.get_element_position_top "comment_form_submit"
	puts "Post button Top position : #{@postbutton_topposition}"
	if @postbutton_topposition == '394'
		puts "UI Check : Pass. Post button is present at the correct position in ThankYou screen."
	else
		puts "UI Check : Fail. Post button is not present at the correct position in ThankYou screen."
	end
	$browser.click "comment_form_submit"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Thanks for your comment. Now let your friends know!")
		puts "Step 1 : Passed. Donor's comment posted Successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 : Failed while posting the comment."
	end
	
	normalUserSharePage()
	
	begin
		assert $browser.is_element_present("//img[@alt='Your profile picture']")
		$browser.click "//img[@alt='Your profile picture']"
		$browser.wait_for_page_to_load
		$browser.click "link=My Profile"
		$browser.wait_for_page_to_load
		begin
			assert $browser.is_text_present(donor_comment)
			puts "Step 2 : Passed. Posted comment is displayed successfully in My Account screen."
		rescue Test::Unit::AssertionFailedError
			puts "Step 2 : Failed. Posted comment doesn't get displayed in My Account screen."
	end
	rescue
	end
	puts "************** END : Post Comment ****************"	
end

# --------------------------------------------------------------------------------------#
# Description:  This method allows the user to delete the comments.
# --------------------------------------------------------------------------------------#


def deleteComments(donor_comment)
	
	puts "************** START : Delete Comment ****************"	
	#***************** Link position check *****************#
	@nothankslink_topposition = $browser.get_element_position_top "link=No Thanks"
	puts "No Thanks link Top position : #{@nothankslink_topposition}"
	if @nothankslink_topposition == '215'
		puts "UI Check : Pass. NoThanks link is present at the correct position in ThankYou screen."
	else
		puts "UI Check : Fail. NoThanks link is not present at the correct position in ThankYou screen."
	end
	$browser.click "link=No Thanks"
	$browser.wait_for_page_to_load 
	#***************** Button position check *****************#
	@postbutton_topposition = $browser.get_element_position_top "comment_form_submit"
	puts "Post button Top position : #{@postbutton_topposition}"
	if @postbutton_topposition == '235'
		puts "UI Check : Pass. Post button is present at the correct position in Story screen."
	else
		puts "UI Check : Fail. Post button is not present at the correct position in Story screen."
	end
	$browser.type "comment_body", "Link Comment"
	$browser.click "link=Link"
	sleep 2
	$browser.type "comment_link", "http://www.youtube.com/watch?v=giIWXZbyT1o"
	$browser.click "comment_form_submit"
	sleep 5
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
	sleep 10
	$browser.click "//div[@id='comments']/div/ol/li[1]/div[2]/a/img"
	assert /^Are you sure you want to delete this comment[\s\S]$/ =~ $browser.get_confirmation
	sleep 10
	begin
		assert $browser.is_text_present("Your comment has been deleted.")
		puts "Step 3: Passed. Successfully deleted the posted comment."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Failed. Couldnt able to delete the posted comment."
	end
	
	$browser.click "//img[@alt='Your profile picture']"
	$browser.wait_for_page_to_load
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
# Description:  This method allows the user to remove the story from the fan's list.
# -------------------------------------------------------------------------------------------#
  
def removeFan(story_name)
	
	puts "************** START : Remove fan ****************"	
	
	$browser.click "//img[@alt='Your profile picture']"
	$browser.wait_for_page_to_load
	$browser.click "link=My Profile"
	$browser.wait_for_page_to_load
	puts "Step 1 : Slide the mouse on story page and click on 'X' mark"
	$browser.click "//ol[5]/li[1]/div[2]/a/img"
	assert /^Are you sure you want to stop being a fan of this cause[\s\S]$/ =~ $browser.get_confirmation
	sleep 10
	begin
		assert $browser.is_text_present("You are no longer a fan of this cause.")
		puts "Step 2 : Passed. Successfully removed the story from Fan's list in Account screen."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed in removing the story from Fan's list in Account screen."
	end
	
	$browser.click "//a[contains(text(),'#{story_name}')]"
	$browser.wait_for_page_to_load 
	
	begin
		assert_equal "Be the first", $browser.get_text("//button[@type='submit']")
		puts "Step 3 : Passed. Verified the fan status in the #{story_name} page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Failed. Still im a Fan for #{story_name} page."
	end
	
	puts "************** END : Remove fan ****************"	
	
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
	if @savedcardlink_topposition == '258'
		puts "UI Check : Pass. SavedCards link is present at the correct position in Account screen."
	else
		puts "UI Check : Fail. SavedCards link is not present at the correct position in Account screen."
	end
	$browser.click "link=My Saved Cards"
	$browser.wait_for_page_to_load 
	sleep 5
	begin
		assert $browser.is_element_present("link=cancel the recurring donation")
		$browser.click "link=cancel the recurring donation"
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
		assert $browser.is_element_present("link=My nonprofit")
		begin
			assert $browser.is_text_present("My nonprofit")
			puts "Pass. My nonprofit link is displayed at the header."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. My nonprofit link is not displayed at the header."
		end
		#***************** Link position check *****************#
		@mynpolink_topposition = $browser.get_element_position_top "link=My nonprofit"
		puts "MyNPO link Top position : #{@mynpolink_topposition}"
		if @mynpolink_topposition == '258'
			puts "UI Check : Pass. My nonprofit link is present at the correct position in Home screen."
		else
			puts "UI Check : Fail. My nonprofit link is not present at the correct position in Home screen."
		end
		$browser.click "link=My nonprofit"
		$browser.wait_for_page_to_load 
		#***************** Button position check *****************#
		@createfrbutton_topposition = $browser.get_element_position_top "link=Fundraise"
		puts "CreateFR button Top position : #{@createfrbutton_topposition}"
		if @createfrbutton_topposition == '258'
			puts "UI Check : Pass. CreateFR button is present at the correct position in Story screen."
		else
			puts "UI Check : Fail. CreateFR button is not present at the correct position in Story screen."
		end
		$browser.click "link=Fundraise"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_element_present("link=Create a Fundraiser")
			puts "Reached Razoo CMS page.:)"
			 $browser.click "link=Create a Fundraiser"
			$browser.wait_for_page_to_load 
		rescue Test::Unit::AssertionFailedError
			begin
				assert $browser.is_element_present("//a[contains(@href, '/story/new?subject=#{ein_number}')]")
				puts "Reached GiveMN CMS page.:)"
				$browser.click "//a[contains(@href, '/story/new?subject=#{ein_number}')]"
				$browser.wait_for_page_to_load 
			rescue
			end
		end
	rescue
	#------------CREATING FUNDRAISE PAGE-------------------------------#
		sleep 5
		$browser.click "link=Fundraise"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_element_present("link=Create a Fundraiser")
			puts "Reached Razoo CMS page.:)"
			$browser.click "link=Create a Fundraiser"
			$browser.wait_for_page_to_load 
		rescue Test::Unit::AssertionFailedError
			begin
				assert $browser.is_element_present("//a[contains(@href, '/story/new?subject=#{ein_number}')]")
				puts "Reached GiveMN CMS page.:)"
				$browser.click "//a[contains(@href, '/story/new?subject=#{ein_number}')]"
				$browser.wait_for_page_to_load 
			rescue
			end
		end
	end
	sleep 25
	puts "Step 1 : Entering valid details for creating Story page"
	$browser.type "story_title", story_name
	$browser.click "//button[@type='submit']"
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
	$browser.type "//body[@id='tinymce']", page_story
	$browser.click "//a[@id='story_long_description_numlist']/span"
	#$browser.type "story_designation", desig_value
	begin
		assert $browser.is_text_present("Admin Note:")
		$browser.type "story[donation_suggestion_levels][0]", sug_amount
		$browser.type "story[donation_suggestion_descriptions][0]", sug_desc
		$browser.click "link=add another amount"
		$browser.type "story[donation_suggestion_levels][1]", sug_amount
		$browser.type "story[donation_suggestion_descriptions][1]", sug_desc
		$browser.click "link=add another amount"
		$browser.type "story[donation_suggestion_levels][2]", sug_amount
		$browser.type "story[donation_suggestion_descriptions][2]", sug_desc
		$browser.click "link=add another amount"
		$browser.type "story[donation_suggestion_levels][3]", sug_amount
		$browser.type "story[donation_suggestion_descriptions][3]", sug_desc
		$browser.click "link=add another amount"
		$browser.type "story[donation_suggestion_levels][4]", sug_amount
		$browser.type "story[donation_suggestion_descriptions][4]", sug_desc
		$browser.click "document.forms[2].elements[24]"
		$browser.wait_for_page_to_load 
	rescue
		@createstorybutton_topposition = $browser.get_element_position_top "document.forms[2].elements[15]"
		puts "CreateStory button Top position : #{@createstorybutton_topposition}"
		if @createstorybutton_topposition == '258'
			puts "UI Check : Pass. CreateStory button is present at the correct position in Createstory screen."
		else
			puts "UI Check : Fail. CreateStory button is not present at the correct position in Createstory screen."
		end
		$browser.click "document.forms[2].elements[16]"
		$browser.wait_for_page_to_load 
	end
		
	$browser.click "link=View"
	$browser.wait_for_page_to_load
	
	begin
		assert $browser.is_element_present("link=Set Your Goals")
		#***************** Link position check *****************#
		@setgoalslink_topposition = $browser.get_element_position_top "link=Set Your Goals"
		puts "Illustrate link Top position : #{@setgoalslink_topposition}"
		if @setgoalslink_topposition == '258'
			puts "UI Check : Pass. SetGoals link is present at the correct position in Story screen."
		else
			puts "UI Check : Fail. SetGoals link is not present at the correct position in Story screen."
		end
		$browser.click "link=Set Your Goals"
		$browser.wait_for_page_to_load 
		$browser.type "story_goal", goal_amount
		$browser.click "story_end_date"
		$browser.click goal_date
		begin
			assert $browser.is_text_present("Admin Note:")
			$browser.click "document.forms[2].elements[24]"
			$browser.wait_for_page_to_load 
		rescue
			$browser.click "document.forms[2].elements[16]"
			$browser.wait_for_page_to_load 
		end
		begin
			assert $browser.is_text_present("Your page has been saved.")
			puts "Passed. Thank donor message and video gets saved successfully."
		rescue Test::Unit::AssertionFailedError
			puts "Failed. Thank donor message and video gets is not saved successfully."
		end
		
	rescue Test::Unit::AssertionFailedError
	end

	$browser.click "link=View"
	$browser.wait_for_page_to_load
	
	begin
		assert $browser.is_element_present("link=Customize Donor Thank-You's")
		#***************** Link position check *****************#
		@thankdonorlink_topposition = $browser.get_element_position_top "link=Customize Donor Thank-You's"
		puts "Illustrate link Top position : #{@thankdonorlink_topposition}"
		if @thankdonorlink_topposition == '258'
			puts "UI Check : Pass. ThankDonor link is present at the correct position in Story screen."
		else
			puts "UI Check : Fail. ThankDonor link is not present at the correct position in Story screen."
		end
		$browser.click "link=Customize Donor Thank-You's"
		$browser.wait_for_page_to_load 
		sleep 5
		$browser.type "story_new_video_url", "http://www.youtube.com/watch?v=giIWXZbyT1o"
		$browser.type "story_thank_you_message", "Thank donor email message"
		$browser.click "document.forms[2].elements[3]"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_text_present("Save successful!")
			puts "Passed. Thank donor message and video gets saved successfully."
		rescue Test::Unit::AssertionFailedError
			puts "Failed. Thank donor message and video gets is not saved successfully."
		end
		
	rescue Test::Unit::AssertionFailedError
	end

	$browser.click "link=View"
	$browser.wait_for_page_to_load
	
	begin
		assert $browser.is_element_present("link=Illustrate Your Story")
		#***************** Link position check *****************#
		@imagevideolink_topposition = $browser.get_element_position_top "link=Images/Videos"
		puts "Illustrate link Top position : #{@imagevideolink_topposition}"
		if @imagevideolink_topposition == '258'
			puts "UI Check : Pass. Illustrate link is present at the correct position in Story screen."
		else
			puts "UI Check : Fail. Illustrate link is not present at the correct position in Story screen."
		end
		$browser.click "link=Illustrate Your Story"
		$browser.wait_for_page_to_load 
		sleep 5
		puts "Step 7 : Upload valid youtube and vimeo video."
		$browser.type "new_video_urls", "http://www.youtube.com/watch?v=HNVSI_r9SVg\nhttp://www.youtube.com/watch?v=giIWXZbyT1o"
		#***************** Button position check *****************#
		@savebutton_topposition = $browser.get_element_position_top "document.forms[2].elements[2]"
		puts "Save button Top position : #{@savebutton_topposition}"
		if @savebutton_topposition == '258'
			puts "UI Check : Pass. Save button is present at the correct position in Imagevideo screen."
		else
			puts "UI Check : Fail. Save button is not present at the correct position in Imagevideo screen."
		end
		$browser.click "document.forms[2].elements[2]"
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
		if @viewlink_topposition == '258'
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
	end

	begin
		assert $browser.is_element_present(admin_links)
		puts "Step 10 : Passed. Admin links are available in the Created #{story_name} page"
	rescue 
	end
	begin
		assert $browser.is_text_present("Your fundraiser is 80% complete.")
		puts "Step 11 : Passed. 80% complete label gets displayed in FR completion steps progress bar."
	rescue Test::Unit::AssertionFailedError
		puts "Step 11 : Failed. Incorrect percent is displayed in FR completion steps progress bar."
	end
	
	puts "************** END : Create Story Page ****************"
end

# ----------------------------------------------------------------------------------------------------------------#
# Description:  This method allows the Team Captain to create a Team Campaign page for Specific Cause.
# ----------------------------------------------------------------------------------------------------------------#

def createTeamCampaignSpecificCause(teamcampaign_url, camp_org, camp_title, camp_story, camp_goalamount, camp_goaldate)
	
	puts "************** START : Create Team Campaign Page ****************"	
	$camp_title = camp_title
	$browser.open teamcampaign_url
	$browser.wait_for_page_to_load 
	puts "Step 1 : Entering valid details for creating Team Campaign page"
	$browser.type "org_picker_kw", camp_org
	sleep 25
	#$browser.click "ui-active-menuitem"
	$browser.type "campaign_title", $camp_title
	$browser.type "campaign_intro", camp_story
	$browser.type "//body[@id='tinymce']", camp_story
	$browser.click "//a[@id='campaign_about_numlist']/span"
	$browser.type "campaign_goal_amount", camp_goalamount
	$browser.click "campaign_start_at"
	$browser.click camp_goaldate
	$browser.click "campaign_end_at"
	$browser.click camp_goaldate
	$browser.click "campaign_enable_offline_donations"
	#***************** Button position check *****************#
	@createteambutton_topposition = $browser.get_element_position_top "//button[@type='submit']"
	puts "CreateTeam button Top position : #{@createteambutton_topposition}"
	if @createteambutton_topposition == '258'
		puts "UI Check : Pass. CreateTeam button is present at the correct position in CreateTeam screen."
	else
		puts "UI Check : Fail. CreateTeam button is not present at the correct position in CreateTeam screen."
	end
	$browser.click "//button[@type='submit']"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Congratulations! your team has been created.")
		puts "Step 2 : Passed. Team Campaign for #{camp_org} was created successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. Team Campaign for #{camp_org} was not created successfully."
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
	sleep 10
	$browser.click "campaign_fundraise_for_any_org_true"
	#$browser.click "ui-active-menuitem"
	$browser.type "campaign_title", $camp_title
	$browser.type "campaign_intro", camp_story
	$browser.type "//body[@id='tinymce']", camp_story
	$browser.click "//a[@id='campaign_about_numlist']/span"
	$browser.type "campaign_goal_amount", camp_goalamount
	$browser.click "campaign_start_at"
	$browser.click camp_goaldate
	$browser.click "campaign_end_at"
	$browser.click camp_goaldate
	$browser.click "campaign_enable_offline_donations"
	$browser.click "//button[@type='submit']"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Congratulations! your team has been created.")
		puts "Step 2 : Passed. Team Campaign for multiple causes was created successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. Team Campaign for multiple causes was not created successfully."
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
	if @editpagelink_topposition == '258'
		puts "UI Check : Pass. Edit link is present at the correct position in EditTeam screen."
	else
		puts "UI Check : Fail. Edit link is not present at the correct position in EditTeam screen."
	end
	$browser.click "link=Edit"
	$browser.wait_for_page_to_load 
	puts "Step 1 : Start updating the Team Campaign page."
	sleep 5
	#$browser.click "//a[@id='campaign_about_numlist']/span"
	$browser.select "campaign_leaderboard_order", leaderboard_order
	$browser.type "campaign_new_url", camp_url
	#***************** Button position check *****************#
	@updatebutton_topposition = $browser.get_element_position_top "//button[@type='submit']"
	puts "UpdateInformation button Top position : #{@updatebutton_topposition}"
	if @updatebutton_topposition == '258'
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
	if @postbutton_topposition == '394'
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
	if @createtemplink_topposition == '258'
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
	$browser.type "fundraiser_template_long_description", story_summary
	#~ $browser.click "//a[@id='fundraiser_template_long_description_bold']/span"
	#~ $browser.click "//a[@id='fundraiser_template_long_description_bullist']/span"
	#~ $browser.click "//a[@id='fundraiser_template_long_description_indent']/span"
	$browser.type "fundraiser_template_goal_amount", camp_goalamount
	
	#***************** Button position check *****************#
	@createtempbutton_topposition = $browser.get_element_position_top "//button[@type='submit']"
	puts "CreateTemplate button Top position : #{@createtempbutton_topposition}"
	if @createtempbutton_topposition == '394'
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
		puts "Step 1 : Failed. Fundraiser Template creation failed!"
	end
	$browser.click "link=Fundraise"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Creating Fundraiser for You ...")
		puts "Step 2 : Passed. FR creation is in progress....spinning!!!!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. FR creation is not in progress!"
	end
	begin
		assert $browser.is_text_present("1st place")
		puts "Step 3 : Passed. FR gets created successfully!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Failed. FR creation failed!"
	end
	begin
		assert $browser.is_element_present("//img[@alt='team']")
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
	
	puts "************** END : Create FR using Fundraiser Template ****************"	
	
end

# ------------------------------------------------------------------------------------------------#
# Description:  This method allows the Team Captain to Create FR for Team Campaign page.
# ------------------------------------------------------------------------------------------------#

def createTeamCampFundraiser(teamcamp_fr, story_summary, story_name, youtube_url, sug_amount, sug_desc, camp_goalamount)
	
	puts "************** START : Create FR for Team Camp ****************"	

	$browser.click "link=Fundraise"
	$browser.wait_for_page_to_load 
	puts "Step 1 : Entering valid details for creating FR page for Team Campaign."
	sleep 25
	$browser.type "story_title", teamcamp_fr
	$browser.click "//button[@type='submit']"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Congratulations, your page has been created!")
		puts "Step 2 : Passed. FR gets created successfully!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. FR creation failed!"
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
		puts "Step 3 : Passed. Team Campaign link is not present in the FR story page."
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

def removeFundraiserFromTeam(teamcamp2_fr)
	
	puts "************** START : View Campaign Leaderboard ****************"
	sleep 5
	$browser.click "//img[@alt='Thumb_unfollow']"
	assert /^Are you sure you want to remove this fundraiser from your team[\s\S] This cannot be undone\.$/ =~ $browser.get_confirmation
	sleep 15
	begin
		assert $browser.is_text_present("This fundraiser has been removed.")
		puts "Step 1 : Passed. Fundraiser is successfully removed from the Team."
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 : Failed. Fundraiser is not successfully removed from the Team."
	end
	sleep 10
	begin
		assert $browser.is_text_present(teamcamp2_fr)
		puts "Step 2 : Passed. #{teamcamp2_fr} is no more in the Leaderboard."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. #{teamcamp2_fr} is still gets displayed in the Leaderboard."
	end
	
	puts "************** END : View Campaign Leaderboard ****************"
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
	if @mglink_topposition == '258'
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
	if @addmgbutton_topposition == '258'
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
		puts "Step 1 : MG creation failed."
	end
	begin
		assert $browser.is_element_present("//img[@alt='X2_money']")
		puts "Step 2 : MG icon displayed in the story page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : MG icon is not displayed in the story page."
	end
	begin
		assert $browser.is_text_present("$#{$mg_totalamount} left")
		puts "Step 3 : Correct MG amount - $#{$mg_totalamount} displayed in the MG page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Incorrect MG amount displayed in the MG page."
	end
	begin
		assert $browser.is_text_present("Your donation will be matched by #{$mgcreator_name}")
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
		assert $browser.is_text_present("Your donation will be matched by #{$mgcreator_name}")
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
	
	$browser.click "link=No Thanks"
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
	$browser.click "link=Matching Grants"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("$0.00 left of this $#{mg_donationamount} matching grant, provided by #{$mgcreator_name}.")
		puts "Pass. $0.00 left of this $#{mg_donationamount} matching grant, provided by #{$mgcreator_name} is displayed in MG screen."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. Donated Amount is not displayed in the MG screen."
	end
	puts "Click on 'Close' button in the MG screen."
	sleep 2
	#***************** Link position check *****************#
	@mgcloselink_topposition = $browser.get_element_position_top "link=close"
	puts "MGClose link Top position : #{@mgcloselink_topposition}"
	if @mgcloselink_topposition == '258'
		puts "UI Check : Pass. MGClose link is present at the correct position in MG screen."
	else
		puts "UI Check : Fail. MGClose link is not present at the correct position in MG screen."
	end
	$browser.click "link=close"
	assert /^Are you sure you want to close this Matching Grant[\s\S] This cannot be undone\.$/ =~ $browser.get_confirmation
	sleep 10
	begin
		assert $browser.is_text_present("This matching grant has been closed")
		puts "Pass. MG was successfully closed."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. MG was not successfully closed."
	end
	sleep 10
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
		puts "Pass. Incorrect donation amount gets displayed successfully in the Grant History section."
	end

	puts "************** END : Close Matching Grant ****************"

end

# -----------------------------------------------------------------------------------------------#
# Description:  This method allows to create a Challenge Grant for a Story page.
# -----------------------------------------------------------------------------------------------#

def createChallengeGrant(mgcreator_name, mg_email, mg_totalamount, mg_date)

	puts "************** START : Create Challenge Grant ****************"
	$mgcreator_name = mgcreator_name
	$mg_totalamount = mg_totalamount
	
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
	$browser.click "type_challenge"
	$browser.type "matching_grant_number_of_donations_to_unlock_grant", "1"
	$browser.click "//button[@type='submit']"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Your matching grant has been created")
		puts "Step 1 : CG gets created successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 : CG creation failed."
	end
	begin
		assert $browser.is_element_present("//img[@alt='Treasurechestclosed']")
		puts "Step 2 : CG closed icon is displayed in the MG page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : CG closed icon is not displayed in the MG page."
	end
	begin
		assert $browser.is_text_present("1 donation left to unlock this $#{$mg_totalamount} challenge grant, provided by #{$mgcreator_name}")
		puts "Step 3 : Correct CG amount - $#{$mg_totalamount} and 1 donation are displayed in the MG page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Incorrect CG amount and donation count are displayed in the MG page."
	end
	$browser.click "link=View"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("1 more donation needed to unlock this challenge grant of $100")
		puts "Step 4 : Correct CG amount - $#{$mg_totalamount} and 1 donation are displayed in the Story page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 4 : Incorrect CG amount and donation count are displayed in the story page."
	end
	begin
		assert $browser.is_text_present("Your donation will be matched by #{$mgcreator_name}")
		puts "Step 5 : Correct CG creator name displayed in the Story page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 5 : Incorrect CG creator name displayed in the Story page."
	end
	begin
		assert $browser.is_element_present("//img[@alt='Locked grant']")
		puts "Step 6 : CG closed icon displayed in the story page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 6 : CG closed icon is displayed in the story page."
	end
	puts "************** END : Create Challenge Grant ****************"
end


# -----------------------------------------------------------------------------------------------#
# Description:  This method allows to close the created Challenge Grant for a Story page.
# -----------------------------------------------------------------------------------------------#

def closeChallengeGrant(mg_donationamount)

	puts "************** START : Close Challenge Grant ****************"
	begin
		assert $browser.is_text_present("Your donation will be matched by #{$mgcreator_name}")
		puts "Pass. CG donation count is not reached; CG Creator Name is still displayed in the Story page."
	rescue Test::Unit::AssertionFailedError
		puts "Pass. CG donation count is achieved; Thus, CG Creator Name is not displayed in the Story page."
	end
	begin
		assert $browser.is_element_present("//img[@alt='Locked grant']")
		puts "CG donation count is not reached; CG icon still displayed in the story page."
	rescue Test::Unit::AssertionFailedError
		puts "CG donation count is reached; Thus, CG icon is not displayed in the story page."
	end
	$browser.click "link=Matching Grants"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_element_present("//img[@alt='Treasurechestopen']")
		puts "Pass. CG open icon is displayed in the MG page."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. CG open icon is not displayed in the MG page."
	end
	begin
		assert $browser.is_text_present("0 donations left to unlock this $#{mg_donationamount} challenge grant, provided by #{$mgcreator_name}")
		puts "Pass. 0 donations left to unlock this $#{mg_donationamount} challenge grant, provided by #{$mgcreator_name} is displayed in CG screen."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. Donated count and amount are not displayed in the CG screen."
	end
	puts "Click on 'Close' button in the MG screen."
	sleep 2
	$browser.click "link=close"
	assert /^Are you sure you want to close this Matching Grant[\s\S] This cannot be undone\.$/ =~ $browser.get_confirmation
	sleep 10
	begin
		assert $browser.is_text_present("This matching grant has been closed")
		puts "Pass. CG was successfully closed."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. CG was not successfully closed."
	end
	sleep 2
	begin
		assert $browser.is_text_present($mgcreator_name)
		puts "Pass. Challenge Grant name gets displayed successfully in the Grant History section."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. Challenge Grant name is not displayed successfully in the Grant History section."
	end
	begin
		assert $browser.is_text_present("$#{$mg_totalamount}")
		puts "Pass. Total Amount gets displayed successfully in the Grant History section."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. Total Amount is not displayed successfully in the Grant History section."
	end
	begin
		assert $browser.is_text_present("1 donations")
		puts "Pass. Correct donation count gets displayed successfully in the Grant History section."
	rescue Test::Unit::AssertionFailedError
		puts "Fail. Incorrect donation count gets displayed successfully in the Grant History section."
	end
	begin
		assert $browser.is_text_present("$#{mg_donationamount}")
		puts "Pass. Correct donation amount gets displayed successfully in the Grant History section."
	rescue Test::Unit::AssertionFailedError
		puts "Pass. Incorrect donation amount gets displayed successfully in the Grant History section."
	end

	puts "************** END : Close Matching Grant ****************"

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
	$browser.type "email", email_id
	$browser.type "ein", ein_number
	#***************** Button position check *****************#
	@createadminbutton_topposition = $browser.get_element_position_top "commit"
	puts "CreateAdmin button Top position : #{@createadminbutton_topposition}"
	if @createadminbutton_topposition == '394'
		puts "UI Check : Pass. CreateAdmin button is present at the correct position in NewOrgAdmins screen."
	else
		puts "UI Check : Fail. CreateAdmin button is not present at the correct position in NewOrgAdmins screen."
	end
	$browser.click "commit"
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
	if @createadminbutton_topposition == '394'
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
	if @deleteadminlink_topposition == '258'
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
        puts "Admins link is not visible to #{email_id} User."
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
	sleep 2
	$browser.open "admin/organizations/new"
	$browser.wait_for_page_to_load 
	$browser.type "org_ein", $ein_number
	$browser.type "org_name", $neworg_name
	$browser.type "org_city", org_city
	$browser.select "org_state", org_state
	#***************** Button position check *****************#
	@createorgbutton_topposition = $browser.get_element_position_top "commit"
	puts "CreateORG button Top position : #{@createorgbutton_topposition}"
	if @createorgbutton_topposition == '394'
		puts "UI Check : Pass. CreateORG button is present at the correct position in CreateNPO screen."
	else
		puts "UI Check : Fail. CreateORG button is not present at the correct position in CreateNPO screen."
	end
	$browser.click "commit"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("New organization created")
		puts "Passed. New ORG successfully created."
	rescue Test::Unit::AssertionFailedError
		puts "Failed in creating a New ORG."
	end
	sleep 5
	
	puts "************** END : Create a New ORG ****************"	
end

# ---------------------------------------------------------------------------------------------#
# Description:  This method allows the Razoo global Admin to create an  EIN-lessORG.
# ---------------------------------------------------------------------------------------------#

def createEinLessOrg(admin_url, new_einlessorgname, org_city, org_state)	
	
	puts "************** START : Create a New ORG with No EIN ****************"	
	$new_einlessorgname = new_einlessorgname
	
	$browser.open admin_url
	sleep 2
	$browser.open "admin/organizations/new"
	$browser.wait_for_page_to_load 
	$browser.type "org_name", $new_einlessorgname
	$browser.type "org_city", org_city
	$browser.select "org_state", org_state
	$browser.click "commit"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("New organization created")
		puts "Passed. New ORG successfully created."
	rescue Test::Unit::AssertionFailedError
		puts "Failed in creating a New ORG."
	end
	sleep 5
	
	puts "************** END : Create a New ORG with No EIN ****************"	
end


# -----------------------------------------------------------------------------------------#
# Description:  This method allows the Razoo global Admin to Edit the NPO Details.
# -----------------------------------------------------------------------------------------#

def editNpoDetails(org_url, first_name, last_name, add_1, add_2, org_emailid, phone_num)	
	
	puts "************** START: Edit NPO Details ****************"
	$add_1 = add_1
	$add_2 = add_2
	$phone_num = phone_num
	
	puts "Step 1 : Modify the NPO details"
	$browser.type "story_new_url", org_url
	$browser.type "story_contact_first_name", first_name
	$browser.type "story_contact_last_name", last_name
	$browser.type "story_address1", $add_1
	$browser.type "story_address2", $add_2
	$browser.type "story_contact_email", org_emailid
	$browser.type "story_contact_phone", $phone_num
	#***************** Button position check *****************#
	@savebutton_topposition = $browser.get_element_position_top "document.forms[2].elements[39]"
	puts "Save button Top position : #{@savebutton_topposition}"
	if @savebutton_topposition == '394'
		puts "UI Check : Pass. Save button is present at the correct position in EditORG screen."
	else
		puts "UI Check : Fail. Save button is not present at the correct position in EditORG screen."
	end
	$browser.click "document.forms[2].elements[39]"
	$browser.wait_for_page_to_load 
	sleep 5
	begin
		assert $browser.is_text_present("Your page has been saved.")
		puts "Step 2 : Passed. NPO Details was successfully changed and saved."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed in updating the NPO Details."
	end
	
	puts "************** END: Edit NPO Details ****************"
end


# -----------------------------------------------------------------------------------------#
# Description:  This method allows the Razoo global Admin to Edit the NPO Details.
# -----------------------------------------------------------------------------------------#

def verifyNpoDetails()	
	
	puts "************** START: Verify NPO Details ****************"
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
		puts "Passed. Tell Your Story link is displayed under NPO Completion Steps section."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Tell Your Story link is not displayed under NPO Completion Steps section."
	end
	begin
		assert $browser.is_element_present("link=Illustrate Your Story")
		puts "Passed. Illustrate Your Story link is displayed under NPO Completion Steps section."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Illustrate Your Story link is not displayed under NPO Completion Steps section."
	end
	begin
		assert $browser.is_element_present("link=Share It With Others")
		puts "Passed. Share It With Others link is displayed under NPO Completion Steps section."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Share It With Others link is not displayed under NPO Completion Steps section."
	end
		
	puts "************** END: Verify NPO Details ****************"
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
	if @verifyauditlink_topposition == '258'
		puts "UI Check : Pass. VerifyAudit link is present at the correct position in Audits screen."
	else
		puts "UI Check : Fail. VerifyAudit link is not present at the correct position in Audits screen."
	end
	$browser.click "link=Verify"
	$browser.wait_for_page_to_load 
	$browser.type "audit_details", audit_notes
	#***************** Button position check *****************#
	@createauditbutton_topposition = $browser.get_element_position_top "document.forms[2].elements[3]"
	puts "CreateAudit button Top position : #{@createauditbutton_topposition}"
	if @createauditbutton_topposition == '394'
		puts "UI Check : Pass. CreateAudit button is present at the correct position in VerifyAudit screen."
	else
		puts "UI Check : Fail. CreateAudit button is not present at the correct position in VerifyAudit screen."
	end
	$browser.click "document.forms[2].elements[3]"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Audit created.")
		puts "Audit created successfully"
	rescue Test::Unit::AssertionFailedError
		puts "Audit not created successfully"
	end
	begin
		assert $browser.is_element_present("//img[@alt='Org_verified']")
		puts "Passed. Now, ORG is Verified."
	rescue Test::Unit::AssertionFailedError
		puts "Failed in verifying the ORG."
	end
	puts "************** END: Verify the Audit ****************"

end


# -------------------------------------------------------------------------------------------------#
# Description:  This method allows the user to become a Fan without making any donation.
# -------------------------------------------------------------------------------------------------#
def becomeFan()

	puts "************** START: Become a Fan - Explicit ****************"
	
	#***************** Link position check *****************#
	@becomefanlink_topposition = $browser.get_element_position_top "//button[@type='submit']"
	puts "BecomeFan link Top position : #{@becomefanlink_topposition}"
	if @becomefanlink_topposition == '258'
		puts "UI Check : Pass. BecomeFan link is present at the correct position in ORGStory screen."
	else
		puts "UI Check : Fail. BecomeFan link is not present at the correct position in ORGStory screen."
	end
	$browser.click "//button[@type='submit']"
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
# Description:  This method allows the Razoo Admin to Impersonate Permission.
# -------------------------------------------------------------------------------------------------#
def impersonatePermission(admin_url, email_id, first_name)
	
	puts "************** START: Impersonate Permission ****************"
	
	$browser.click "//img[@alt='Your profile picture']"
	$browser.wait_for_page_to_load
	begin
	assert $browser.is_element_present("link=Permissions")
	#***************** Link position check *****************#
	@permissionslink_topposition = $browser.get_element_position_top "link=Permissions"
	puts "Permissions link Top position : #{@permissionslink_topposition}"
	if @permissionslink_topposition == '258'
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
	if @impersonatebutton_topposition == '394'
		puts "UI Check : Pass. Impersonate button is present at the correct position in Impersonate screen."
	else
		puts "UI Check : Fail. Impersonate button is not present at the correct position in Impersonate screen."
	end
	$browser.click "//input[@value='impersonate']"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Welcome back, #{first_name}")
		puts "Step 3 : Passed. Razoo Admin successfully impersonated as #{first_name}."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Failed. Razoo Admin failed impersonating as #{first_name}."
	end
	rescue
		puts "Permissions Access is not available for this User."
	end
	
	puts "************** END: Impersonate Permission ****************"
	
end

# -------------------------------------------------------------------------------------------------#
# Description:  This method allows the User to login via Google Account.
# -------------------------------------------------------------------------------------------------#
def loginViaGmail(gmail_emailId, gmail_password)
	
	puts "************** START: Login Via Gmail ****************"
	
	#***************** Button position check *****************#
	@SigninwithGooglebutton_topposition = $browser.get_element_position_top "//img[@alt='Google']"
	puts "SigninGoogle button Top position : #{@SigninwithGooglebutton_topposition}"
	if @SigninwithGooglebutton_topposition == '394'
		puts "UI Check : Pass. SigninGoogle button is present at the correct position in Home screen."
	else
		puts "UI Check : Fail. SigninGoogle button is not present at the correct position in Home screen."
	end
	$browser.click "//img[@alt='Google']"
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
		puts "Step 1 : Failed. User failed to log in successfully into Razoo via Gmail."
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
	
	#***************** Button position check *****************#
	@Signinwithfacebookbutton_topposition = $browser.get_element_position_top "//img[@alt='Facebook']"
	puts "SigninFB button Top position : #{@Signinwithfacebookbutton_topposition}"
	if @Signinwithfacebookbutton_topposition == '394'
		puts "UI Check : Pass. SigninFB button is present at the correct position in Home screen."
	else
		puts "UI Check : Fail. SigninFB button is not present at the correct position in Home screen."
	end
	$browser.click "//img[@alt='Facebook']"
	$browser.wait_for_page_to_load 
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
		puts "Step 1 : Failed. User failed to log in successfully into Razoo via Gmail."
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
	puts "************** End: Login Via FB ****************"
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
	if @logoutlink_topposition == '258'
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
	$browser.open reindex_hack
	$browser.wait_for_page_to_load 
	sleep 5
	$browser.go_back()
	puts "Reindex Hack URL is finished running."
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
	$browser.go_back()
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
