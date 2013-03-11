#-----------------------------------------------------------------------------#
# Razoo_Test_Cases.rb
#
# Author: EBI,SDR and SID
# Date: 4-OCT-2010
# Description:  Includes all the methods that are required to execute the test cases in IE.
#
# Change history:
# 4-OCT-2010 - Initial Development
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

def invokeRazooSite()
	
	puts "************** START : Invoke Razoo Application ****************"	
	# Create a new instance of the Selenium-Client driver.
	$browser = Selenium::Client::Driver.new \
		:host => "localhost",
		:port => 4444,
		:browser => "*iexplore", 
		:url => "https://www-qatrunk.razoo.com/login",
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
		assert_equal "An inspiring place to donate and raise money - Razoo", $browser.get_title
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

#-------------------------------------------------------------------------#
# Description:  This method allows the user to search ORG/FR/PRO
# -------------------------------------------------------------------------#

def searchStory(story_name)
	
	$story_name = story_name
	puts "************** START: Search ORG/FR/PRO ****************"
	$browser.click "//strong"
	$browser.wait_for_page_to_load
	$browser.click "projectScope"
	$browser.click "widgetScope"
	puts "Step 1 : Type #{$story_name} in the Search Field"
	$browser.type "parametricKeyword", story_name
	$browser.click "//button[@type='submit']"
	sleep (5)
	puts "Step 2 : Click on #{$story_name} link"
	$browser.click "link=#{$story_name}"
	$browser.wait_for_page_to_load
	begin
		assert_equal "#{$story_name} - Razoo", $browser.get_title
		puts "Step 3 : Passed. User reached #{story_name} Story Page successfully!!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Failed. Problem in reaching the ORG Story page."
	end
	puts "************** END : Search ORG/FR/PRO ****************"
end

#---------------------------------------------------------------------------------------#
# Description:  This method allows the user to make a donation by using new Card
# ---------------------------------------------------------------------------------------#

def donateUsingNewCard(donation_amount, name_on_card, street, state, city, pin_code, card_number, sec_code, email_id)
	
	puts "************** START : Make a donation using New Card ****************"	
	#$browser.wait_for_page_to_load
	puts "Step 1 : Enter donation amount - $#{donation_amount}"
	$browser.type "transactionA", donation_amount
	$browser.click "//p/button[@type='submit']/em"
	$browser.wait_for_page_to_load 
	begin
		assert_equal "An inspiring place to donate and raise money - Razoo", $browser.get_title
		puts "User reached Donation Form page successfully!!"
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Problem in reaching the Donation Form page."
	end
	begin
		assert $browser.is_text_present("$10.00")
		puts "Entered amount $#{donation_amount} gets displayed in the DF screen."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Incorrect donation amount gets displayed."
	end
	puts "Step 2 : Entering Card Details : #{name_on_card}, #{card_number}, #{ email_id}"
	$browser.type "order_user_order_credit_card_attributes_full_name", name_on_card
	$browser.type "order_user_order_credit_card_attributes_address1", street
	$browser.type "order_user_order_credit_card_attributes_city", state
	$browser.type "order_user_order_credit_card_attributes_state", city
	$browser.type "order_user_order_credit_card_attributes_postal_code", pin_code
	$browser.type "cardNumber", card_number
	$browser.type "order_user_order_credit_card_attributes_security_code", sec_code
	begin
	#GUEST USER DONATION
		assert $browser.is_text_present("Donate without an account to:")
		$browser.type "donation_email", email_id
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
		assert $browser.is_text_present("Your donation was successful! We've sent you a confirmation email receipt.")
		puts "Step 3 : Passed. $#{donation_amount} Donation was Successful!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Failed. $#{donation_amount} Donation was Failed!"
	end
	begin
		assert $browser.is_text_present(donation_amount)
		puts "Step 4 : Passed. $#{donation_amount} gets displayed in the Thank You screen."
	rescue Test::Unit::AssertionFailedError
		puts "Step 4 : Failed. $#{donation_amount} doesn't get displayed in the Thank You screen."
	end
	begin
		assert $browser.is_text_present($story_name)
		puts "Step 5 : Passed. #{$story_name} gets displayed in the Thank You screen."
	rescue Test::Unit::AssertionFailedError
		puts "Step 5 : Failed. #{$story_name} doesn't get displayed in the Thank You screen."	
		
	end
	puts "************** END : Make a donation using New Card ****************"	
	
end

#---------------------------------------------------------------------------------------#
# Description:  This method allows the user to make a donation by using new Card
# ---------------------------------------------------------------------------------------#

def donateUsingSavedCard(donation_amount, donate_weekly, tip_amount)
	
	puts "************** START : Make a donation using saved Card ****************"	
	puts "Step 1 : Enter donation amount - $#{donation_amount}"
	$browser.click "transaction0"
	$browser.click "document.forms[2].elements[9]"
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
	puts "Step 2 : Selected a recurring donation"
	$browser.select "order_user_order_recurring_donation", donate_weekly 
	puts "Step 3 : Provided tip amount of $#{tip_amount}"
	$browser.type "tip_other_amount", tip_amount
	$browser.click "card_40"
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
		assert $browser.is_text_present("Your donation was successful! We've sent you a confirmation email receipt.")
		puts "Step 4 : Passed. $#{donation_amount} Donation was Successful!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 4 : Failed. $#{donation_amount} Donation was Failed!"
	end
	begin
		assert $browser.is_text_present(donation_amount)
		puts "Step 5 : Passed. $#{donation_amount} donation amount displayed in the Thank You screen."
	rescue Test::Unit::AssertionFailedError
		puts "Step 5 : Failed. $#{donation_amount} doesn't get displayed in the Thank You screen."
	end
	begin
		assert $browser.is_text_present(tip_amount)
		puts "Step 6 : Passed. $#{tip_amount} tip amount gets displayed in the Thank You screen."
	rescue Test::Unit::AssertionFailedError
		puts "Step 6 : Failed. $#{tip_amount} doesn't get displayed in the Thank You screen."
	end
	begin
		assert $browser.is_text_present($story_name)
		puts "Step 7 : Passed. #{$story_name} gets displayed in the Thank You screen."
	rescue Test::Unit::AssertionFailedError
		puts "Step 7 : Failed. #{$story_name} doesn't get displayed in the Thank You screen."	
		
	end
	$browser.click "//div[4]/a/em"
	$browser.wait_for_page_to_load
	puts "************** END : Make a donation using Saved Card ****************"	
end


# --------------------------------------------------------------------------------------#
# Description:  This method allows the user to view the comments in story page.
# --------------------------------------------------------------------------------------#
  
def viewComments()
	
	puts "************** START : View Comments ****************"	
	begin
		assert $browser.is_text_present("View comments")
	rescue Test::Unit::AssertionFailedError
	end
	$browser.click "//em"
	$browser.wait_for_page_to_load "3000"
	begin
		assert_equal "Harvard College - Razoo", $browser.get_title
		puts "Step 1 : Passed. User has reached #{$story_name} story comment frame."
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 : Failed. User has failed to reach #{$story_name} story comment frame."
	end
	begin
		assert $browser.is_text_present("Updates and Donor Comments")
		puts "Step 2 : Passed. User can able to view #{$story_name} story comment frame successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. Problem in viewing the #{$story_name} story comment frame"
	end
	$browser.go_back()
	$browser.click "link=create an account"
	$browser.wait_for_page_to_load 
	puts "************** END : View Comments ****************"	
end
	

# --------------------------------------------------------------------------------------#
# Description:  This method allows the user to post and verify the comments.
# --------------------------------------------------------------------------------------#
  
def postComments(donor_comment)
	
	puts "************** START : Post Comment ****************"	
	$browser.click "//div[4]/a/em"
	$browser.wait_for_page_to_load
	$browser.type "comment_body", donor_comment
	$browser.click "comment_form_submit"
	sleep (5)
	begin
		assert $browser.is_text_present("Thank you, your comment has been posted. Post your comment to Facebook")
		puts "Step 1 : Passed. Donor's comment posted Successfully!!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 : Failed in posting the comment."
	end
	$browser.click "myAccountHeaderLink"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present(donor_comment)
		puts "Step 2 : Passed. Verified the posted comment in My Account screen."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. Posted comment is not displayed in My Account screen. "
	end

	puts "************** END : Post Comment ****************"	
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
	$browser.select_frame "//iframe[@id='story_story_ifr']"
	$browser.select_frame( "relative=top") 
	#$browser.set_cursor_position "//iframe[@id='story_story_ifr']", "0"
	$browser.type "//body", page_story
	sleep(10)
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
		assert $browser.is_text_present(story_name)
		puts "Step 2 : Passed. #{story_name} created successfully!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. #{story_name} creation failed!"
	end
	begin
		assert $browser.is_element_present(admin_links)
		puts "Step 3 : Passed. Admin links are available in the Created #{story_name} page"
	rescue 
	end

	puts "************** END : Create Story Page ****************"
end


# --------------------------------------------------------------------------------------#
# Description:  This method allows the user to logout from the Razoo application.
# --------------------------------------------------------------------------------------#
def logout()
	
	puts "************** START : Log out from Razoo ****************"
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

