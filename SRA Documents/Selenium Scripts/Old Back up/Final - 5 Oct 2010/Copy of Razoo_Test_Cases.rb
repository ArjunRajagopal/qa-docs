#-----------------------------------------------------------------------------#
# UDF.rb
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
#require "D:\\EBI\\MyProjects\\Razoo\\Automation\\Selenium\\Selenium2\\ModularFramework\\Log\\logger.rb"

# Variable declarations
$verification_errors = []

#-------------------------------------------------------------#
# invokeRazooSite Method.
#
# Author: EBI,SDR and SID
# Date: 4-OCT-2010
# Description:  It is a METHOD for invoking the Razoo Site
#
# Change history:
# 4-OCT-2010 - Initial Development
# -------------------------------------------------------------#

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
	$mylog.info "Razoo Site gets invoked successfully!"
	puts "Razoo Site gets invoked successfully!"
	puts "************** END : Invoke Razoo Application ****************"
	
end

#-------------------------------------------------------------#
# createRazooAccount Method.
#
# Author: EBI,SDR and SID
# Date: 4-OCT-2010
# Description:  It is a METHOD for creating a Razoo Account.
#
# Change history:
# 4-OCT-2010 - Initial Development
# -------------------------------------------------------------#
 
def createRazooAccount(first_name, last_name, email_id, pass_word)
	
	puts "************** START : Create a Razoo Account ****************"	
	#$browser.click "link=Sign up"
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
		puts "Step 2 : Failed. Account not created successfully!"
	end
	$browser.click "myAccountHeaderLink"
	$browser.wait_for_page_to_load 
	begin
		$user_name = first_name+" "+ last_name
		puts "User Name is #{$user_name}"
		assert $browser.is_text_present($user_name)
		puts "Passed. #{$user_name} gets displayed in Account screen."
	rescue Test::Unit::AssertionFailedError
		puts "Passed. #{$user_name} doesn't get displayed in Account screen."
	end
	puts "************** END : Create a Razoo Account ****************"	
end

#-------------------------------------------------------------#
# searchORG Method.
#
# Author: EBI,SDR and SID
# Date: 4-OCT-2010
# Description:  It is a METHOD for searching the ORG/FR/PRO
#
# Change history:
# 4-OCT-2010 - Initial Development
# -------------------------------------------------------------#

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

#-------------------------------------------------------------#
# donationUsingNewCard Method.
#
# Author: EBI,SDR and SID
# Date: 4-OCT-2010
# Description:  It is a METHOD for making a successful donation.
#
# Change history:
# 4-OCT-2010 - Initial Development
# -------------------------------------------------------------#

def donationUsingNewCard(donation_amount, name_on_card, street, state, city, pin_code, card_number, sec_code, email_id, thankyou_message)
	
	puts "************** START : Make a donation ****************"	
	$browser.wait_for_page_to_load
	puts "Step 1 : Enter donation amount - $#{donation_amount}"
	$browser.type "transactionA", donation_amount
	$browser.click "document.forms[2].elements[3]"
	$browser.wait_for_page_to_load 
	begin
		assert_equal "An inspiring place to donate and raise money - Razoo", $browser.get_title
		puts "Step 2 : Passed. User reached Donation Form page successfully!!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. Problem in reaching the Donation Form page."
	end
	begin
		assert $browser.is_text_present("$10.00")
		puts "Step 3 : Passed. Entered amount $#{donation_amount} gets displayed in the DF screen."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 : Failed. Incorrect donation amount gets displayed."
	end
	puts "Step 4 : Entering Card Details : #{name_on_card}, #{card_number}, #{ email_id}"
	$browser.type "order_user_order_credit_card_attributes_full_name", name_on_card
	$browser.type "order_user_order_credit_card_attributes_address1", street
	$browser.type "order_user_order_credit_card_attributes_city", state
	$browser.type "order_user_order_credit_card_attributes_state", city
	$browser.type "order_user_order_credit_card_attributes_postal_code", pin_code
	$browser.type "cardNumber", card_number
	$browser.type "order_user_order_credit_card_attributes_security_code", sec_code
	$browser.type "donation_email", email_id
	$browser.click "//button[@type='submit']"
	begin
		assert $browser.is_text_present("Processing Donation...")
		puts "Step 5 : Passed. Processing Donation... success"
	rescue Test::Unit::AssertionFailedError
		puts "Step 5 : Failed. Processing Donation... failed"
	end
	$browser.wait_for_page_to_load
	begin
		assert $browser.is_text_present(thankyou_message)
		puts "Step 6 : Passed. $#{donation_amount} Donation was Successful!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 6 : Failed. $#{donation_amount} Donation was Failed!"
	end
	begin
		assert $browser.is_text_present(donation_amount)
		puts "Step 7 : Passed. #{donation_amount} gets displayed in the Thank You screen."
	rescue Test::Unit::AssertionFailedError
		puts "Step 7 : Failed. #{donation_amount} doesn't get displayed in the Thank You screen."
	end
	begin
		assert $browser.is_text_present($story_name)
		puts "Step 8 : Passed. #{$story_name} gets displayed in the Thank You screen."
	rescue Test::Unit::AssertionFailedError
		puts "Step 8 : Failed. #{$story_name} doesn't get displayed in the Thank You screen."	
		
	end
	puts "************** END : Make a donation ****************"	
	
end

#-------------------------------------------------------------#
# viewComments Method.
#
# Author: EBI,SDR and SID
# Date: 4-OCT-2010
# Description:  It is a METHOD for viewing the comments as a Guest User
#
# Change history:
# 4-OCT-2010 - Initial Development
# -------------------------------------------------------------#
  
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
	

#-------------------------------------------------------------#
# login Method.
#
# Author: EBI,SDR and SID
# Date: 4-OCT-2010
# Description:  It is a METHOD for logging into the Razoo application.
#
# Change history:
# 4-OCT-2010 - Initial Development
# -------------------------------------------------------------#
def login(email_id, pass_word)
	
	puts "************** START : Log into Razoo ****************"	
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
	puts "************** END : Log into Razoo ****************"	
end


#-------------------------------------------------------------#
# createFundraise Method.
#
# Author: EBI,SDR and SID
# Date: 4-OCT-2010
# Description:  It is a METHOD for logging into the Razoo application.
#
# Change history:
# 4-OCT-2010 - Initial Development
# -------------------------------------------------------------#

def createFundraise(org_name, fr_name, fr_summary, fr_story, youtube_url, desig_value, sugg_amount, sugg_desc, goal_amount,  goal_date)
	
	puts "************** START : Create Fundraise Page ****************"	
	$browser.click "//a/em"
	$browser.wait_for_page_to_load
	puts "Step 1 : Entering valid details for creating Fundraise page"
	$browser.type "story_title", fr_name
	$browser.type "story_blurb", fr_summary
	$browser.type "\\p\br[@mce_bogus='1']", fr_story
	$browser.type "youtubeField", youtube_url
	$browser.type "story_designation", desig_value
	$browser.type "level_amount[0]", sugg_amount
	$browser.type "level_description[0]", sugg_desc
	$browser.type "story_goal", goal_amount
	$browser.click "story_end_date"
	$browser.click goal_date
	$browser.click "//button[@type='submit']"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present(fr_name)
		puts "Step 2 : Passed. #{fr_name} created successfully!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. #{fr_name} creation failed!"
	end
	begin
		assert $browser.is_element_present("link=Donations")
		puts " Step 3 : Passed. Admin links are available in the Created #{fr_name} page"
	rescue 
	end
	puts "************** END : Create Fundraise Page ****************"
end

  # The teardown method is called after each test.
  def logout

	$browser.click "link=Log out"
	puts "Logout Successfully!!"
	$browser.wait_for_page_to_load
	# Stop the browser session.
	$browser.close_current_browser_session

  end

# This is the Donate And Post Comment Method.
def donatePostComment(org_name, donation_amount, comment)
	  
	$browser.type "search", org_name
	$browser.click "//input[@type='image']"
	$browser.wait_for_page_to_load 
	assert_equal "Learn about nonprofits and donate to charity - Razoo", $browser.get_title
	$browser.click "//div[@class ='aside']/p[1]/a[@href='/story/Harvard-College']"
	#$browser.click "//div[@id='parametricResults']/ol[1]/li[14]/div/div[1]/h3/a"
	$browser.wait_for_page_to_load 
	#assert_equal "#{org_name} - Razoo", $browser.get_title
	$browser.type "transactionA", donation_amount
	#$browser.click "document.forms[3].elements[3]"
	$browser.click "//form[@action ='https://www-qatrunk.razoo.com/orders/new']/p[1]/button"
	$browser.wait_for_page_to_load 
	#assert_equal "An inspiring place to donate and raise money - Razoo", $browser.get_title
	$browser.click "//p[@id='donationSubmit']/button"
	
	begin
		assert $browser.is_text_present("Processing Donation...")
		puts "Processing Donation..."
	rescue Test::Unit::AssertionFailedError
		$verification_errors << $!
	end
	
	$browser.wait_for_page_to_load 
	assert_equal "An inspiring place to donate and raise money - Razoo", $browser.get_title
	
	begin
		assert $browser.is_text_present(donation_amount)
		puts "$#{donation_amount} is present in the Thank You screen."
	rescue Test::Unit::AssertionFailedError
		$verification_errors << $!
	end
	begin
		assert $browser.is_text_present(org_name)
		puts "Donation made to #{org_name}"
	rescue Test::Unit::AssertionFailedError
		$verification_errors << $!
	end
	
	begin
		assert $browser.is_text_present("Your donation was successful! We've sent you a confirmation email receipt.")
		puts "Your donation was successful!"
	rescue Test::Unit::AssertionFailedError
		$verification_errors << $!
	end
	
	$browser.click "//div[4]/a/em"
	$browser.wait_for_page_to_load 
	assert_equal "#{org_name} - Razoo", $browser.get_title
	$browser.type "comment_body", comment
	$browser.click "comment_form_submit"
	$browser.open "javascript:Story.postCommentToFacebook();"
	#$browser.click "//div[@class ='inset wall']/div[2]/form[@id='comment_form']/p[@id='comment_thanks']/a[@href='javascript:Story.postCommentToFacebook();']"
	$browser.wait_for_pop_up "_blank" 
	$browser.select_window "_blank"
	puts "2"
	$browser.window_focus() 
	puts "3"
	$browser.type "//form[@id =login_form]/div[2]/input[@id='email']", "fbuser1@rediffmail.com"
	puts "after email"
	#$browser.type "email", "fbuser1@rediffmail.com"
	$browser.type "pass", "111111"
	puts "after pass"
	$browser.click "login"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present(comment)
	rescue Test::Unit::AssertionFailedError
		$verification_errors << $!
	end
	$Browser.click "publish"
	begin
		assert $browser.is_text_present("Im posting the comment!!")
		puts "Comment posted successfully. Comment verified in Story page."
	rescue Test::Unit::AssertionFailedError
		$verification_errors << $!
	end
	
	$browser.wait_for_page_to_load 
	assert_equal "", $browser.get_title
	assert_equal "Cross-Domain Receiver Page", $browser.get_title
	$browser.select_window "null"
	$browser.click "link=Log out"
	
	$browser.click "link=ACCOUNT"
	$browser.wait_for_page_to_load 
	assert_equal "An inspiring place to donate and raise money - Razoo", $browser.get_title
	begin
		assert $browser.is_text_present("\"Im posting the comment!!\"")
		$mylog.info "Post Comment was successful and Test Scenario was Passed."
		puts "Comment verified in My Account screen."
	rescue Test::Unit::AssertionFailedError
		$verification_errors << $!
	end
end	
