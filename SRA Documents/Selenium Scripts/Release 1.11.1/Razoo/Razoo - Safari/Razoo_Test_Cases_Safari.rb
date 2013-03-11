#-----------------------------------------------------------------------------#
# Razoo_Test_Cases.rb
#
# Author: EBI,SDR and SID
# Date: 4-OCT-2010
# Description:  Includes all the methods that are required to execute the test cases in IE.
#
# Change history:
# 4-OCT-2010 - Initial Development
# 5-OCT-2010  - Added createFundraise scenarios.
# 13-OCT-2010 - Fine tuned few codes and added grantOrgAdminRights() method
# 15-OCT-2010 - Included Facebook pop up code.
# 28-OCT-2010 - Included 9, 10 scenarios.
# 16-NOV-2010 - Update on Release 1.8.
# 25-NOV-2010 - Implementing EXCEL concept.
# 22-DEC-2010 - Update - Release 1.10.
# 14-Jan-2010 - Update - Release 1.11.
# 7-Feb-2011 - Update - Release 1.11.1.
# 
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
		:browser => "*safari", 
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
		assert $browser.is_text_present("You need an account to post this comment. It's really easy to set one up!")
		$browser.click "//form[@id='new_user']/div[2]/div/div/button"
		$browser.wait_for_page_to_load 
	rescue
		$browser.click "//button[@type='submit']"
		$browser.wait_for_page_to_load
	end
	 
	begin
		assert $browser.is_text_present("Donate to:")
		begin
			assert $browser.is_text_present("Your account has been created.")
			$user_name = first_name+" "+ last_name
			puts "Step 2 : Passed. Account has been created successfully! and retained in the Donation Form screen."
		rescue Test::Unit::AssertionFailedError
		begin
			assert $browser.is_text_present("Email is already in use by another account (if it's yours, you can recover your account password from the login screen)")
			puts 	"Step 2 : Failed. #{email_id} has already been taken."
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
			assert $browser.is_element_present("myAccountHeaderLink")
			$browser.click "myAccountHeaderLink"
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
	$browser.click "link=Log in"
	$browser.wait_for_page_to_load 
	puts "Step 1 : Entering valid User credintials - User Name as #{email_id} and Password as #{pass_word}"
	$browser.type "user_session_email", email_id 
	$browser.type "user_session_password", pass_word
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
	
	$browser.click "myAccountHeaderLink"
	$browser.wait_for_page_to_load 
	sleep 2
	$browser.click "link=Account Settings" 
	$browser.wait_for_page_to_load 
	puts "Step 1: Enter password and password confirmation"
	$browser.type "user_password", new_password
	$browser.type "user_password_confirmation", new_password
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
	$browser.highlight "//strong"
	$browser.click "//strong"
	$browser.wait_for_page_to_load
	$browser.click "projectScope"
	sleep 2
	$browser.click "widgetScope"
	sleep 2
	puts "Step 1 : Type #{$story_name} in the Search Field"
	$browser.type "parametricKeyword", $story_name
	$browser.click "//button[@type='submit']"
	sleep 5
	puts "Step 2 : Click on #{$story_name} link"
	$browser.click "link=#{$story_name}"
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
	$browser.click "//strong"
	$browser.wait_for_page_to_load
	$browser.click "orgScope"
	sleep 2
	$browser.click "widgetScope"
	sleep 2
	puts "Step 1 : Type #{$story_name} in the Search Field"
	$browser.type "parametricKeyword", project_name
	$browser.click "//button[@type='submit']"
	sleep 5
	puts "Step 2 : Click on #{$story_name} link"
	$browser.click "link=#{$story_name}"
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
	$browser.click "//strong"
	$browser.wait_for_page_to_load
	$browser.click "orgScope"
	sleep 5
	$browser.click "projectScope"
	sleep 5
	puts "Step 1 : Type #{$story_name} in the Search Field"
	$browser.type "parametricKeyword", fundraise_name
	$browser.click "//button[@type='submit']"
	sleep 10
	puts "Step 2 : Click on #{$story_name} link"
	$browser.click "link=#{$story_name}"
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
	$browser.click "//p/button[@type='submit']/em"
	$browser.wait_for_page_to_load 
	begin
		assert_equal "An inspiring place to donate and raise money - Razoo", $browser.get_title
		puts "Step 1 : User reached Donation Form page successfully!!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 : Failed. Problem in reaching the Donation Form page."
	end
	
	begin
		assert $browser.is_text_present("Already a Member?")
		puts "Step 2 : Click on 'Sign Up' link in the donation form screen."
		$browser.click "link=create an account"
		$browser.wait_for_page_to_load 
	rescue
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
		assert_equal "An inspiring place to donate and raise money - Razoo", $browser.get_title
		puts "Step 1 : User reached Donation Form page successfully!!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 : Failed. Problem in reaching the Donation Form page."
	end
	
	begin
		assert $browser.is_text_present("Already a Member?")
		puts "Step 2 : Enter valid user credentials - #{email_id} and #{pass_word} "
		$browser.type "user_session_email", email_id 
		$browser.type "user_session_password", pass_word
		$browser.click "//div[@id='authPortable']/div/form/div[1]/button"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_text_present("Login successful!")
			puts "Step 2 : Passed. Login was Successful!!!"
		rescue Test::Unit::AssertionFailedError
			puts "Step 2 : Failed. Login Failed"
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
	#$browser.wait_for_page_to_load
	$email_id = email_id
	
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
			
			#assert $browser.is_text_present($donation_amount_retain)
			
			puts "Step 1 : Entered amount $#{$donation_amount_retain} gets displayed in the DF screen."
		rescue Test::Unit::AssertionFailedError
			
			puts "Step 1 : Enter donation amount - $#{donation_amount}"
			$browser.type "name=donation[amount]", donation_amount
			$browser.click "//p/button[@type='submit']/em"
			$browser.wait_for_page_to_load 
			begin
				assert_equal "An inspiring place to donate and raise money - Razoo", $browser.get_title
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
	
	begin
		assert_equal "#{$user_name}", $browser.get_value("order_user_order_credit_card_attributes_full_name")
		puts "Passed. User First name & Last name gets displayed in Name on Card field."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. User First name & Last name doesn't get displayed in Name on Card field."
	end
	
	$browser.click "tip_amount_0"
	$browser.click "add_dedication"
	$browser.type "order_user_order_donations_attributes_0_dedication", "With Dedication"
	
	puts "Step 2 : Entering Card Details : #{$user_name}, #{name_on_card}, #{card_number}, #{$email_id}"
	$browser.type "order_user_order_credit_card_attributes_full_name", name_on_card
	$browser.type "order_user_order_credit_card_attributes_address1", street
	$browser.type "order_user_order_credit_card_attributes_city", city
	$browser.type "order_user_order_credit_card_attributes_state", state
	$browser.type "order_user_order_credit_card_attributes_postal_code", pin_code
	$browser.type "cardNumber", card_number
	$browser.type "order_user_order_credit_card_attributes_security_code", sec_code
	begin
	#GUEST USER DONATION
		assert $browser.is_text_present("Donate without an account to:")
		$browser.type "donation_email", $email_id
	rescue Test::Unit::AssertionFailedError
	end
	$browser.click "//button[@type='submit']"
	begin
		assert $browser.is_text_present("Processing Donation...")
		puts "Processing Donation... Success!!"
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Processing Donation... failed"
	end
	$browser.wait_for_page_to_load
	begin
		assert $browser.is_text_present("Your donation was successful! We'll send you a confirmation email receipt shortly.")
		puts "Step 3 : Passed. Donation was Successful! and User reached the Thank You screen."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Failed. Donation was Failed!"
	end
	
	puts "************** END : Make a donation using New Card ****************"	
	
end

#---------------------------------------------------------------------------------------#
# Description:  This method allows the user to make a donation by using new Card
# ---------------------------------------------------------------------------------------#

def donateUsingSavedCard(donation_amount, tip_amount)
	
	puts "************** START : Make a donation using saved Card ****************"	
	puts "Step 1 : Select donation amount"
	$browser.click "name=selected_level"
	$browser.click "//p/button[@type='submit']/em"
	$browser.wait_for_page_to_load 
	begin
		assert_equal "An inspiring place to donate and raise money - Razoo", $browser.get_title
		puts "User reached Donation Form page successfully!!"
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Problem in reaching the Donation Form page."
	end
	begin
		assert_equal donation_amount, $browser.get_value("donation_amount")
		puts "Selected suggested amount $#{donation_amount} gets displayed in the DF screen."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Incorrect donation amount gets displayed."
	end
	puts "Step 2 : Provide tip amount of $#{tip_amount}"
	$browser.click "tip_amount_other"
	$browser.type "tip_other_amount", tip_amount
	$browser.click "//button[@type='submit']"
	begin
		assert $browser.is_text_present("Processing Donation...")
		puts "Processing Donation... Success!!"
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Processing Donation...!!!"
	end
	$browser.wait_for_page_to_load
	begin
		assert $browser.is_text_present("Your donation was successful! We'll send you a confirmation email receipt shortly.")
		puts "Step 3 : Passed. Donation was Successful! and User reached the Thank You screen."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Failed. Donation was Failed!"
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
	
	puts "Step 1 : Enter donation amount - $#{donation_amount}"
	$browser.type "name=donation[amount]", donation_amount
	$browser.click "//p/button[@type='submit']/em"
	$browser.wait_for_page_to_load 
	begin
		assert_equal "An inspiring place to donate and raise money - Razoo", $browser.get_title
		puts "User reached Donation Form page successfully!!"
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Problem in reaching the Donation Form page."
	end
	begin 
		assert_equal donation_amount, $browser.get_value("donation_amount")
		puts "Step 2 : Selected suggested amount $#{donation_amount} gets displayed in the DF screen."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Failed. Incorrect donation amount gets displayed."
	end
	sleep 2
	puts "Step 3 : Selected a recurring donation"
	$browser.select "order_user_order_recurring_donation", donate_weekly 
	$browser.click "new_credit_card"
	
	begin
		assert_equal "#{$user_name}", $browser.get_value("order_user_order_credit_card_attributes_full_name")
		puts "Passed. User First name & Last name gets displayed in Name on Card field."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. User First name & Last name doesn't get displayed in Name on Card field."
	end
		
	$browser.click "tip_amount_0"
	$browser.click "add_designation"
	$browser.type "order_user_order_donations_attributes_0_designation", "With Designation"
	$browser.click "add_dedication"
	$browser.type "order_user_order_donations_attributes_0_dedication", "With Dedication"
	
	puts "Step 4 : Entering New Card Details : #{$user_name}, #{card_number}"
	$browser.type "order_user_order_credit_card_attributes_address1", street
	$browser.type "order_user_order_credit_card_attributes_city", city
	$browser.type "order_user_order_credit_card_attributes_state", state
	$browser.type "order_user_order_credit_card_attributes_postal_code", pin_code
	$browser.type "cardNumber", card_number
	$browser.type "order_user_order_credit_card_attributes_security_code", sec_code
	$browser.click "order_user_order_donations_attributes_0_disclosure"
	$browser.click "//button[@type='submit']"
	begin
		assert $browser.is_text_present("Processing Donation...")
		puts "Processing Donation... Success!!"
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Processing Donation... failed"
	end
	$browser.wait_for_page_to_load
	begin
		assert $browser.is_text_present("Your donation was successful! We'll send you a confirmation email receipt shortly.")
		puts "Step 5 : Passed. Donation was Successful! and User reached the Thank You screen."
	rescue Test::Unit::AssertionFailedError
		puts "Step 5 : Failed. Donation was Failed!"
	end
		
	puts "************** END : Make a donation using Saved Card ****************"
end

#------------------------------------------------------------------------------------------------------#
# Description:  This method allows the user to make a donation through DonateAnywere.
# -----------------------------------------------------------------------------------------------------#

def donateUsingDonateAnywhere(donation_amount, widget_emailid, widget_fullname, widget_street, widget_city, widget_state, widget_pcode, card_number, sec_code, tip_amount)
	
	puts "************** START : DonateAnywere ****************"
	$browser.click "link=DonateAnywhere"
	$browser.wait_for_page_to_load 
	puts "Step 1 : Enter donation amount in the First screen."
	$browser.type "transaction5", donation_amount
	$browser.click "//div[@id='donation']/a/em"
	sleep 1
	#~ begin
		#~ assert $browser.is_text_present("Enter your")
		#~ puts "User has reached the Second screen successfully."
	#~ rescue Test::Unit::AssertionFailedError
		#~ puts "User has failed to reach the Second screen successfully."
	#~ end
	puts "Step 2 : Enter Billing details in the Second screen."
	$browser.type "order_user_order_email", widget_emailid
	$browser.type "order_user_order_credit_card_attributes_full_name", widget_fullname
	$browser.type "order_user_order_credit_card_attributes_address1", widget_street
	$browser.type "order_user_order_credit_card_attributes_city", widget_city
	$browser.select "order_user_order_credit_card_attributes_state", widget_state
	$browser.type "order_user_order_credit_card_attributes_postal_code", widget_pcode
	$browser.click "//div[@id='billing']/a[2]/em"
	sleep 1
	#~ begin
		#~ assert $browser.is_text_present("And finally")
		#~ puts "User has reached the Third screen successfully."
	#~ rescue Test::Unit::AssertionFailedError
		#~ puts "User has failed to reach the Third screen successfully."
	#~ end
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
	
	$browser.click "//button[@type='submit']"
	
	begin
		assert_equal "", $browser.get_text("//img[@alt='Loading']")
		puts "Donation was processing!!!"
	rescue Test::Unit::AssertionFailedError
		puts "Donation process was failed."
	end
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
	
	
	puts "************** END : DonateAnywere ****************"

end

# --------------------------------------------------------------------------------------------------------#
# Description:  This method allows the User to verify his donation under 'My Donation' screen.
# --------------------------------------------------------------------------------------------------------#
  
def checkMydonation(donation_amount)
	
	puts "************** START : Check My Donation ****************"
	
	$browser.click "myAccountHeaderLink"
	$browser.wait_for_page_to_load 
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
# Description:  This method allows the Guest User to share the story page thorugh Email.
# ------------------------------------------------------------------------------------------------#
  
def guestUserSharePage(share_emailid)
	
	puts "************** START : Share page - Guest User ****************"	
	
	$browser.click "link=No Thanks"
	$browser.wait_for_page_to_load 
	
	begin
		assert $browser.is_text_present("Help raise more money")
		puts "Passed. User has successfully reached the Share page."
	rescue Test::Unit::AssertionFailedError
		puts "Failed to reach the Share page."
	end

	begin
		assert_equal "#{$email_id}", $browser.get_value("your_email")
		puts "Passed. #{$email_id} gets pre-populated in the 'Your email id' field."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. #{$email_id} doesn't get pre-populated in the 'Your email id' field."
	end
	begin
		assert $browser.is_text_present("Greetings, I just gave to #{$story_name}. Please join me in supporting this great cause. Together we can make a real difference!")
		puts "Passed. Default 'Add a personal message' content gets displayed successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Default 'Add a personal message' content doesn't get displayed."
	end

	puts "Step 1 : Enter Recipients email id - #{share_emailid}"
	$browser.type "share_story_recipients_emails", share_emailid
	$browser.click "//form[@id='new_share_story']/div[2]/p[1]/button"
	$browser.wait_for_page_to_load 
	
	begin
		assert $browser.is_text_present("Thank you for telling others about this cause!")
		puts "Step 2 : Passed. User has successfully shared the #{$story_name} story page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed in sharing the #{$story_name} story page."
	end
	
	begin
		assert $browser.is_text_present("You might also be interested in the following causes")
		puts "Step 3 : Passed. User has reached the recommendations page successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Failed in reaching the recommendations page."
	end
	
	#$browser.click "link=Go back to #{$story_name}"
	

	puts "************** END : Share page - Guest User ****************"	
end


# ------------------------------------------------------------------------------------------------#
# Description:  This method allows the Normal User to share the story page thorugh Email.
# ------------------------------------------------------------------------------------------------#
  
def normalUserSharePage()
	
	puts "************** START : Share page - Normal User ****************"	
	
	begin
		assert $browser.is_text_present("How about sharing that encouragement with your friends?")
		puts "Passed. User has successfully reached the Share page."
	rescue Test::Unit::AssertionFailedError
		puts "Failed to reach the Share page."
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
	$browser.click "comment_form_submit"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Thanks for your comment. Now let your friends know!")
		puts "Step 1 : Passed. Donor's comment posted Successfully in Donor's Wall!!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 : Failed while posting the comment in Donor's Wall."
	end
	
	normalUserSharePage()
	
	#   ------------------- FACEBOOK---------------------------------
	#~ $browser.click "link=Post your comment to Facebook"
	#~ $browser.wait_for_pop_up "_blank", "30000"
	#~ $browser.select_window "name=_blank"
	#~ $browser.type "email", fb_emailid
	#~ $browser.type "pass", fb_password
	#~ $browser.click "login"
	#~ $browser.wait_for_page_to_load 
	#~ #$browser.type "feedform_user_message", "Comment"
	#~ $browser.click "publish"
	#~ sleep 5
	#~ $browser.select_window "null"
	#~ begin
		#~ assert $browser.is_text_present("Thank you, your comment has been posted")
		#~ puts "Step 3 : Passed. Donor's comment posted Successfully in Facebook Wall!!"
	#~ rescue Test::Unit::AssertionFailedError
		#~ puts "Step 3 : Failed while posting the comment in Facebook Wall."
	#~ end
	#   ------------------- FACEBOOK---------------------------------
	
	$browser.click "myAccountHeaderLink"
	$browser.wait_for_page_to_load 
	
	begin
		assert $browser.is_text_present(donor_comment)
		puts "Step 2 : Passed. Posted comment is displayed successfully in My Account screen. "
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. Posted comment doesn't get displayed in My Account screen."
	end
	puts "************** END : Post Comment ****************"	
end

# --------------------------------------------------------------------------------------#
# Description:  This method allows the user to delete the comments.
# --------------------------------------------------------------------------------------#


def deleteComments(donor_comment)
	
	puts "************** START : Delete Comment ****************"	
	$browser.click "link=No Thanks"
	$browser.wait_for_page_to_load 
	
	$browser.type "comment_body", donor_comment
	$browser.click "comment_form_submit"
	sleep 5
	begin
		assert $browser.is_text_present("Thank you, your comment has been posted.")
		puts "Step 1 : Passed. Donor's comment posted Successfully!!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 : Failed in posting the comment."
	end
	$browser.click "//div[@id='comments']/div/ol/li[1]/div[2]/a/img"
	assert /^Are you sure you want to delete this comment[\s\S]$/ =~ $browser.get_confirmation
	sleep 10
	begin
		assert $browser.is_text_present("Your comment has been deleted.")
		puts "Step 2: Passed. Successfully deleted the posted comment."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. Couldnt able to delete the posted comment."
	end
	
	$browser.click "myAccountHeaderLink"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present(donor_comment)
		puts "Step 3 : Failed. Deleted comment gets displayed in My Account screen."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Passed. Deleted comment doesn't gets displayed in My Account screen."
	end

	puts "************** END : Delete Comment ****************"	
end

	
# -------------------------------------------------------------------------------------------#
# Description:  This method allows the user to remove the story from the fan's list.
# -------------------------------------------------------------------------------------------#
  
def removeFan(story_name)
	
	puts "************** START : Remove fan ****************"	
	
	$browser.click "myAccountHeaderLink"
	$browser.wait_for_page_to_load 
	puts "Step 1 : Slide the mouse on story page and click on 'X' mark"
	$browser.click "//ol[3]/li[2]/div[2]/a/img"
	assert /^Are you sure you want to stop being a fan of this cause[\s\S]$/ =~ $browser.get_confirmation
	sleep 10
	begin
		assert $browser.is_text_present("You are no longer a fan of this cause.")
		puts "Step 2 : Passed. Successfully removed the story from Fan's list in Account screen."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed in removing the story from Fan's list in Account screen."
	end
	
	$browser.click "link=#{story_name}"
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
	$browser.click "myAccountHeaderLink"
	$browser.wait_for_page_to_load 
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
	begin
		assert $browser.is_text_present("You do not have any saved credit cards.")
	rescue Test::Unit::AssertionFailedError
		sleep 5
		$browser.click "commit"
	end
	$browser.wait_for_page_to_load 
	sleep 5
	begin
		assert $browser.is_text_present("You do not have any saved credit cards.")
		puts "Passed. The My stored card was successfully deleted."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. My stored card is not deleted."
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
		assert $browser.is_element_present("link=My NPO")
		$browser.click "link=My NPO"
		$browser.wait_for_page_to_load 
		$browser.click "link=Create Project"
		$browser.wait_for_page_to_load 
	rescue
	#------------CREATING FUNDRAISE PAGE-------------------------------#
		$browser.click "//p/a/em"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_element_present("//a[contains(@href, '/story/new?subject=#{ein_number}')]")
			puts "Reached CMS page.:)"
			$browser.click "//a[contains(@href, '/story/new?subject=#{ein_number}')]"
			$browser.wait_for_page_to_load 
		rescue Test::Unit::AssertionFailedError
		end
	end
	puts "Step 1 : Entering valid details for creating Story page"
	$browser.type "story_title", story_name
	$browser.type "story_blurb", story_summary	
	sleep 2
	$browser.type "tinymce", page_story
	$browser.click "//a[@id='story_story_numlist']/span"
	$browser.type "youtubeField", youtube_url
	#$browser.type "story_designation", desig_value
	begin
		assert $browser.is_text_present("Create a Project")
		$browser.type "level_amount[0]", sug_amount
		$browser.type "level_description[0]", sug_desc
		$browser.click "link=add another amount"
		$browser.type "level_amount[1]", sug_amount
		$browser.type "level_description[1]", sug_desc
		$browser.click "link=add another amount"
		$browser.type "level_amount[2]", sug_amount
		$browser.type "level_description[2]", sug_desc
		$browser.click "link=add another amount"
		$browser.type "level_amount[3]", sug_amount
		$browser.type "level_description[3]", sug_desc
		$browser.click "link=add another amount"
		$browser.type "level_amount[4]", sug_amount
		$browser.type "level_description[4]", sug_desc
	rescue
	end
	$browser.type "story_goal", goal_amount
	$browser.click "story_end_date"
	$browser.click goal_date
	$browser.click "//button[@type='submit']"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("This title is already being used by another nonprofit, project, or fundraiser")
		puts "Failed. #{story_name} is already being used by another nonprofit, project, or fundraiser. Try using a different name."
	rescue Test::Unit::AssertionFailedError
	end
	begin
		assert $browser.is_text_present("Congratulations, Your page has been created!")
		puts "Step 2 : Passed. #{story_name} created successfully!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. #{story_name} creation failed!"
	end
	$browser.click "//em"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_element_present(admin_links)
		puts "Step 3 : Passed. Admin links are available in the Created #{story_name} page"
	rescue 
	end
	
	puts "************** END : Create Story Page ****************"
end

# -------------------------------------------------------------------------------------------#
# Description:  This method allows the Normal user to create a Team Campaign page.
# -------------------------------------------------------------------------------------------#

def createTeamCampaign(teamcampaign_url, camp_org, camp_title, camp_story, camp_goalamount, camp_goaldate)
	
	puts "************** START : Create Team Campaign Page ****************"	
	$camp_title = camp_title
	$browser.open teamcampaign_url
	$browser.wait_for_page_to_load 
	puts "Step 1 : Entering valid details for creating Team Campaign page"
	$browser.type "org_picker_kw", camp_org
	sleep 30
	#$browser.click "ui-active-menuitem"
	$browser.type "campaign_title", $camp_title
	$browser.type "campaign_intro", camp_story
	$browser.type "tinymce", camp_story
	$browser.click "//a[@id='campaign_about_numlist']/span"
	$browser.type "campaign_goal_amount", camp_goalamount
	$browser.click "campaign_start_at"
	$browser.click camp_goaldate
	$browser.click "campaign_end_at"
	$browser.click camp_goaldate
	$browser.click "//button[@type='submit']"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Your team fundraiser has been created successfully")
		puts "Step 2 : Passed. Team Campaign was created successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. Team Campaign was not created successfully."
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
# Description:  This method allows the Normal user to Edit theTeam Campaign page.
# -------------------------------------------------------------------------------------------#

def editTeamCampaign(leaderboard_order, camp_url)
	
	puts "************** START : Edit Team Campaign Page ****************"	
	
	$browser.click "link=Edit Page"
	$browser.wait_for_page_to_load 
	puts "Step 1 : Start updating the Team Campaign page."
	#$browser.click "//a[@id='campaign_about_numlist']/span"
	$browser.select "campaign_leaderboard_order", leaderboard_order
	$browser.type "campaign_cached_urn", camp_url
	$browser.click "//button[@type='submit']"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Your page has been updated.")
		puts "Step 2 : Team Campaign page gets updated successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Team Campaign page doesn't get updated successfully."
	end
	
	puts "************** END : Edit Team Campaign Page ****************"	
end

# ------------------------------------------------------------------------------------------------#
# Description:  This method allows the Normal user to Create FR for Team Campaign page.
# ------------------------------------------------------------------------------------------------#

def createTeamCampFundraiser(teamcamp_fr, story_summary, story_name, youtube_url, sug_amount, sug_desc, camp_goalamount)
	
	puts "************** START : Create FR for Team Camp ****************"	

	$browser.click "link=Create a Page"
	$browser.wait_for_page_to_load 
	puts "Step 1 : Entering valid details for creating FR page for Team Campaign."
	$browser.type "story_title", teamcamp_fr
	$browser.type "story_blurb", story_summary
	$browser.type "tinymce", story_name
	$browser.click "//a[@id='story_story_numlist']/span"
	$browser.type "youtubeField", youtube_url
	$browser.type "level_amount[0]", sug_amount
	$browser.type "level_description[0]", sug_desc
	$browser.type "story_goal", camp_goalamount
	$browser.click "//button[@type='submit']"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Congratulations, Your page has been created!")
		puts "Step 2 : Passed. FR gets created successfully!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. FR creation failed!"
	end
	$browser.click "//em"
	$browser.wait_for_page_to_load 
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
		puts "Step 4 : Passed. Team Campaign icon is not present in the FR story page."
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
# Description:  This method allows the Normal user to view the Leaderboard.
# ------------------------------------------------------------------------------------------------#

def verifyLeaderboard(modified_camp_url, sug_amount, teamcamp_fr)
	
	puts "************** START : View Campaign Leaderboard ****************"	
	$browser.open modified_camp_url
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
	
	puts "************** END : View Campaign Leaderboard ****************"	
end


# -----------------------------------------------------------------------------------------------#
# Description:  This method allows to create a Matching Grant for a Story page.
# -----------------------------------------------------------------------------------------------#

def createMatchingGrant(mgcreator_name, mg_email, mg_totalamount, mg_date)

	puts "************** START : Create Matching Grant ****************"
	$mgcreator_name = mgcreator_name
	$mg_totalamount = mg_totalamount
	
	$browser.click "link=Matching Grants"
	$browser.wait_for_page_to_load 
	sleep 2
	$browser.type "matching_grant_name", $mgcreator_name
	$browser.type "matching_grant_email", mg_email
	$browser.type "matching_grant_amount", $mg_totalamount
	$browser.click "matching_grant_start_at"
	$browser.click mg_date
	$browser.click "matching_grant_end_at"
	$browser.click mg_date
	$browser.click "matching_grant_submit"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Your matching grant hs been created")
		puts "Step 1 : MG gets created successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 : MG creation failed."
	end
	begin
		assert_equal "", $browser.get_text("//img[@alt='x2 money']")
		puts "Step 2 : MG icon displayed in the story page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : MG icon is not displayed in the story page."
	end
	begin
		assert $browser.is_text_present("$#{$mg_totalamount} left")
		puts "Step 3 : Correct MG amount - $#{$mg_totalamount} displayed in the story page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Incorrect MG amount displayed in the story page."
	end
	begin
		assert $browser.is_text_present("#{$mgcreator_name}")
		puts "Step 4 : Correct MG creator name displayed in the story page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 4 : Incorrect MG creator name displayed in the story page."
	end
	puts "************** END : Create Matching Grant ****************"
end


# -----------------------------------------------------------------------------------------------#
# Description:  This method allows to close the created Matching Grant for a Story page.
# -----------------------------------------------------------------------------------------------#

def closeMatchingGrant(mg_donationamount)

	puts "************** START : Close Matching Grant ****************"

	begin
		assert $browser.is_text_present("$#{$mg_totalamount} left")
		puts "MG amount is achieved; MG amount is still displayed in the Story page."
	rescue Test::Unit::AssertionFailedError
		puts "MG amount is achieved; Thus, MG amount is not displayed in the Story page."
	end
	begin
		assert $browser.is_text_present("#{$mgcreator_name}")
		puts "MG amount is achieved; MG Creator Name is still displayed in the Story page."
	rescue Test::Unit::AssertionFailedError
		puts "MG amount is achieved; Thus, MG Creator Name is not displayed in the Story page."
	end
	$browser.click "link=Matching Grants"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("$#{mg_donationamount}")
		puts "Donated Amount gets displayed in the MG screen."
	rescue Test::Unit::AssertionFailedError
		puts "Donated Amount is not displayed in the MG screen."
	end
	puts "Click on 'Close' button in the MG screen."
	sleep 2
	$browser.click "//input[@value='Close']"
	assert /^Are you sure you want to close this Matching Grant[\s\S] This cannot be undone\.$/ =~ $browser.get_confirmation
	sleep 5
	begin
		assert $browser.is_text_present("This matching grant has been closed")
		puts "MG was successfully closed."
	rescue Test::Unit::AssertionFailedError
		puts "MG was not successfully closed."
	end

	puts "************** END : Close Matching Grant ****************"

end


# --------------------------------------------------------------------------------------#
# Description:  This method allows to grant the Admin rights to the Normal User.
# --------------------------------------------------------------------------------------#

def grantOrgAdminRights(admin_url, email_id, ein_number)
	
	puts "************** START : Grant ORG Admin rights ****************"	
	$browser.open admin_url
	$browser.click "link=Manage Org Admins"
	$browser.wait_for_page_to_load 
	$browser.type "email", email_id
	$browser.type "ein", ein_number
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
	
# --------------------------------------------------------------------------------------#
# Description:  This method allows the Razoo global Admin to create an ORG.
# --------------------------------------------------------------------------------------#

def createOrg(admin_url, ein_number, neworg_name, org_city, org_state)	
	
	puts "************** START : Create a New ORG ****************"	
	$ein_number = ein_number
	$neworg_name = neworg_name
	
	$browser.open admin_url
	$browser.click "link=Create New Org"
	$browser.wait_for_page_to_load 
	$browser.type "org_ein", $ein_number
	$browser.type "org_name", $neworg_name
	$browser.type "org_city", org_city
	$browser.select "org_state", org_state
	$browser.click "commit"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("#{neworg_name} A US registered nonprofit")
		puts "Passed. New ORG successfully created."
	rescue Test::Unit::AssertionFailedError
		puts "Failed in creating a New ORG."
	end
	
	puts "************** END : Create a New ORG ****************"	
end


# -----------------------------------------------------------------------------------------#
# Description:  This method allows the Razoo global Admin to Edit the NPO Details.
# -----------------------------------------------------------------------------------------#

def editNpoDetails(first_name, last_name, add_1, add_2, org_emailid, phone_num)	
	
	puts "************** START: Edit NPO Details ****************"
	$add_1 = add_1
	$add_2 = add_2
	$phone_num = phone_num
	
	puts "Step 1 : Modify the NPO details"
	$browser.type "org_contact_first_name", first_name
	$browser.type "org_contact_last_name", last_name
	$browser.type "org_address1", $add_1
	$browser.type "org_address2", $add_2
	$browser.type "org_contact_email", org_emailid
	$browser.type "org_contact_phone", $phone_num
	$browser.click "commit"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Thank you, your nonprofit organizational information has been saved.")
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
		assert_equal "#{$neworg_name} - Razoo", $browser.get_title
		puts "Step 1 : Passed. User has reached #{$neworg_name} story page successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 : Failed in reaching #{$neworg_name} story page."
	end
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
		
	puts "************** END: Verify NPO Details ****************"
end


# -----------------------------------------------------------------------------------------#
# Description:  This method allows the Razoo global Admin to verify the Audit.
# -----------------------------------------------------------------------------------------#

def auditVerifyOrg(audit_notes)
	
	puts "************** START: Verify the Audit ****************"
	$browser.click "link=Audits"
	$browser.wait_for_page_to_load 
	$browser.click "link=Verify"
	$browser.wait_for_page_to_load 
	$browser.type "audit_details", audit_notes
	$browser.click "audit_submit"
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


# --------------------------------------------------------------------------------------#
# Description:  This method allows the user to logout from the Razoo application.
# --------------------------------------------------------------------------------------#
def logout()
	
	puts "************** START : Log out from Razoo ****************"
	sleep 2
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
	puts "Reindex Hack URL is finished running."
	sleep 2
	$browser.open reindexall_hack
	$browser.wait_for_page_to_load 
	puts "Reindex_all Hack URL is finished running."
	sleep 2
	$browser.open memcache_hack
	$browser.wait_for_page_to_load 
	puts "Memcache Hack URL is finished running."
	sleep 2
	$browser.open regstats_hack
	$browser.wait_for_page_to_load 
	puts "Regenerate Stats Hack URL is finished running."
	sleep 2
	
	puts "************** END : Run Hack URL ****************"
	
end


# --------------------------------------------------------------------------------------#
# Description:  This method will stop the running browser.
# --------------------------------------------------------------------------------------#
def stopBrowser()
	
	$browser.stop
	
end