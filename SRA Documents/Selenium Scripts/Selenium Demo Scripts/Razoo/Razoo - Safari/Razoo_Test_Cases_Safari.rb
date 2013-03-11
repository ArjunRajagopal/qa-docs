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
	
	$browser.click "link=Sign up"
	$browser.wait_for_page_to_load 
	
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
	sleep 2
	$browser.click "projectScope"
	sleep 2
	puts "Step 1 : Type #{$story_name} in the Search Field"
	$browser.type "parametricKeyword", fundraise_name
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
	puts "************** END : Search FR ****************"
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
	
	begin
		assert $browser.is_text_present("How about sharing that encouragement with your friends?")
		puts "Step 2 : Passed. User has successfully reached the Share page."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed to reach the Share page."
	end
	
	$browser.click "link=I'm done"
	$browser.wait_for_page_to_load 
	
	begin
		assert $browser.is_element_present("myAccountHeaderLink")
		$browser.click "myAccountHeaderLink"
		$browser.wait_for_page_to_load
		begin
			assert $browser.is_text_present(donor_comment)
			puts "Step 3 : Passed. Posted comment is displayed successfully in My Account screen. "
		rescue Test::Unit::AssertionFailedError
			puts "Step 3 : Failed. Posted comment doesn't get displayed in My Account screen."
	end
	rescue
	end
	
	puts "************** END : Post Comment ****************"	
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
		sleep 5
		$browser.click "//p/a/em"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_element_present("//a[contains(@href, '/story/new?subject=#{ein_number}')]")
			puts "Reached CMS page.:)"
			$browser.click "//a[contains(@href, '/story/new?subject=#{ein_number}')]"
			sleep 10
		rescue Test::Unit::AssertionFailedError
		end
	end
	puts "Step 1 : Entering valid details for creating Story page"
	$browser.type "story_title", story_name
	$browser.type "story_blurb", story_summary	
	$browser.type "//body[@id='tinymce']", page_story
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
	sleep 5
	
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
