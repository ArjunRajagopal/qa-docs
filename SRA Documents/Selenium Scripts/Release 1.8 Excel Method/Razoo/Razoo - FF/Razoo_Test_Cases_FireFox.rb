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
		:browser => "*firefox", 
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
		assert $browser.is_text_present("Sign in to save your donation and post comments")
		$browser.click "link=create an account"
		$browser.wait_for_page_to_load 
	rescue
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
	$browser.click "//button[@type='submit']"
	$browser.wait_for_page_to_load 
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
		$browser.click "myAccountHeaderLink"
		$browser.wait_for_page_to_load 
		begin
			$user_name = first_name+" "+ last_name
			assert $browser.is_text_present($user_name)
			puts "Step 3 : Passed. #{$user_name} gets displayed in Account screen."
		rescue Test::Unit::AssertionFailedError
			puts "Step 3 : Failed. #{$user_name} doesn't get displayed in Account screen."
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
			assert $browser.is_text_present($donation_amount_retain)
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
				assert $browser.is_text_present(donation_amount)
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
	puts "Step 2 : Provided tip amount of $#{tip_amount}"
	$browser.click "tip_amount_other"
	$browser.type "tip_other_amount", tip_amount
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

	$browser.click "//em"
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
	
	$browser.click "link=Proceed without signing in"
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
  
def normalUserSharePage(share_emailid, story_url)
	
	puts "************** START : Share page - Normal User ****************"	
	
	$browser.click "//em"
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
	
	sleep 2 
	$browser.open story_url
	sleep 2
	
	puts "************** END : Share page - Normal User ****************"	
end


# --------------------------------------------------------------------------------------#
# Description:  This method allows the user to post and verify the comments.
# --------------------------------------------------------------------------------------#
  
def postComments(donor_comment)
	
	puts "************** START : Post Comment ****************"	
	$browser.type "comment_body", donor_comment
	$browser.click "comment_form_submit"
	sleep 5
	begin
		assert $browser.is_text_present("Thank you, your comment has been posted.")
		puts "Step 1 : Passed. Donor's comment posted Successfully in Donor's Wall!!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 : Failed while posting the comment in Donor's Wall."
	end
	begin
		assert $browser.is_text_present("You are a fan")
		puts "Step 2 : Passed. Now, I'm a Fan of #{$story_name}"
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. Now, I'm not a Fan of #{$story_name}"
	end
	
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
		puts "Step 4 : Passed. Posted comment is displayed successfully in My Account screen. "
	rescue Test::Unit::AssertionFailedError
		puts "Step 4 : Failed. Posted comment doesn't get displayed in My Account screen."
	end
	puts "************** END : Post Comment ****************"	
end

# --------------------------------------------------------------------------------------#
# Description:  This method allows the user to delete the comments.
# --------------------------------------------------------------------------------------#
  
def deleteComments(donor_comment)
	
	puts "************** START : Delete Comment ****************"	
	$browser.type "comment_body", donor_comment
	$browser.click "comment_form_submit"
	sleep 5
	begin
		assert $browser.is_text_present("Thank you, your comment has been posted.")
		puts "Step 1 : Passed. Donor's comment posted Successfully!!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 : Failed in posting the comment."
	end
	
	begin
		assert $browser.is_text_present("You are a fan")
		puts "Step 2 : Passed. Now, I'm a Fan of #{$story_name}"
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. Now, I'm not a Fan of #{$story_name}"
	end
	
	$browser.click "//div[@id='comments']/div/ol/li[1]/div[2]/a/img"
	assert /^Are you sure you want to delete this comment[\s\S]$/ =~ $browser.get_confirmation
	sleep 10
	begin
		assert $browser.is_text_present("Your comment has been deleted.")
		puts "Step 3 : Passed. Successfully deleted the posted comment."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Failed. Couldnt able to delete the posted comment."
	end
	
	$browser.click "myAccountHeaderLink"
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
	
	$browser.click "myAccountHeaderLink"
	$browser.wait_for_page_to_load 
	puts "Step 1 : Slide the mouse on story page and click on 'X' mark"
	$browser.click "//ol[3]/li[1]/div[2]/a/img"
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
		assert_equal "Become a fan", $browser.get_text("//button[@type='submit']")
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
	sleep 3
	begin
		assert $browser.is_element_present("link=cancel the recurring donation")
		$browser.click "link=cancel the recurring donation"
		$browser.wait_for_page_to_load 
		sleep 3
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
	sleep 3
	$browser.click "commit"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("You do not have any saved credit cards.")
	rescue Test::Unit::AssertionFailedError
		sleep 3
		$browser.click "commit"
	end
	sleep 10
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

def createStoryPage(org_name, story_name, story_summary, page_story, youtube_url, desig_value, goal_amount,  goal_date, admin_links, sug_amount, sug_desc)
	
	puts "************** START : Create Story Page ****************"	
	
	#------------CREATING PROJECT PAGE-------------------------------#
	begin
		assert $browser.is_element_present("link=My NPO")
		$browser.click "link=My NPO"
		$browser.wait_for_page_to_load 
		$browser.click "link=Create Project"
	rescue
	#------------CREATING FUNDRAISE PAGE-------------------------------#
		$browser.click "//p/a/em"
	end
	$browser.wait_for_page_to_load
	puts "Step 1 : Entering valid details for creating Story page"
	$browser.type "story_title", story_name
	$browser.type "story_blurb", story_summary	
	#$browser.select_frame "//iframe[@id='story_story_ifr']"
	$browser.type "tinymce", page_story
	$browser.type "youtubeField", youtube_url
	$browser.type "story_designation", desig_value
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
		assert $browser.is_text_present("Congratulations! Your page has been created.\nOne last step: Upload an image which will be displayed on the search results page.")
		puts "Step 2 : Passed. #{story_name} created successfully!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. #{story_name} creation failed!"
	end
	begin
		assert $browser.is_element_present(admin_links)
		puts "Step 3 : Passed. Admin links are available in the Created #{story_name} page"
	rescue 
	end
	$browser.click "link=View"
	$browser.wait_for_page_to_load 
	puts "************** END : Create Story Page ****************"
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
	$browser.type "org_state", org_state
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
# Description:  This method will stop the running browser.
# --------------------------------------------------------------------------------------#
def stopBrowser()
	
	$browser.stop
	
end

