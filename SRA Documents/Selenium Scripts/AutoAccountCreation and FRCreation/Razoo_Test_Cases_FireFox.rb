require "test/unit"
require "rubygems"
gem "selenium-client"
require "selenium/client"


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
	$browser.click "link=Sign up"
	$browser.wait_for_page_to_load
	
	begin
		assert $browser.is_text_present("Create an account on Razoo")
		puts "Passed. User has reached the Account creation page successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Failed. User didn't reach the Account creation page."
	end
	puts "Entering  Account creation details"
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
	
	$browser.click "//button[@type='submit']"
	$browser.wait_for_page_to_load
	
	begin
		assert $browser.is_text_present("Your account has been created.")
		puts "Passed. Account has been created successfully!"
	rescue Test::Unit::AssertionFailedError
		begin
			assert $browser.is_text_present("Email is already in use by another account (if it's yours, you can recover your account password from the login screen)")
			puts 	"Failed. #{email_id} has already been taken."
		rescue Test::Unit::AssertionFailedError
			puts "Failed. Account not created successfully!"
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
				puts "Passed. #{$user_name} gets displayed in Account screen."
			rescue Test::Unit::AssertionFailedError
				puts "Failed. #{$user_name} doesn't get displayed in Account screen."
			end
		rescue Test::Unit::AssertionFailedError
			puts "No header links displayed in the Thank you screen."
			$browser.click "link=No Thanks"
			$browser.wait_for_page_to_load
			$browser.click "link=I'm done"
			$browser.wait_for_page_to_load 
	end
		
	puts "************** END : Create a Razoo Account ****************"	
end


# --------------------------------------------------------------------------------------#
# Description:  This method allows the Normal user to create a Story page.
# --------------------------------------------------------------------------------------#

def createStoryPage(org_url, ein_number, story_name, story_summary, page_story, desig_value, goal_amount,  goal_date, sug_amount, sug_desc)
	
	puts "************** START : Create Story Page ****************"	
	
	$browser.open org_url
	sleep  5
	begin
		assert $browser.is_element_present("link=Fundraise")
		$browser.click "//a[contains(@href,'?subject=#{ein_number}')]"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_element_present("link=Create a Fundraiser")
			puts "Reached Razoo CMS page :)"
			$browser.click "link=Create a Fundraiser"
			$browser.wait_for_page_to_load 
		rescue Test::Unit::AssertionFailedError
			begin
				assert $browser.is_element_present("//a[contains(@href, '/story/new?subject=#{ein_number}')]")
				puts "Reached GiveMN CMS page :)"
				$browser.click "//a[contains(@href, '/story/new?subject=#{ein_number}')]"
				$browser.wait_for_page_to_load 
			rescue
			end
		end
	rescue
		puts "Fail. Fundraise link is not present in the Story page."
	end
	puts "Entering valid details for creating Story page"
	$browser.type "story_title", story_name
	$browser.click "//button[@type='submit']"
	$browser.wait_for_page_to_load
	$browser.click "link=Edit"
	$browser.wait_for_page_to_load 
	$browser.type "story_short_description", story_summary	
	$browser.type "//body[@id='tinymce']", page_story
	$browser.click "//a[@id='story_long_description_numlist']/span"
	$browser.type "story_goal", goal_amount
	$browser.click "story_end_date"
	$browser.click goal_date
	$browser.click "css=button[type=submit]"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("This title is already being used by another nonprofit, project, or fundraiser")
		puts "Failed. #{story_name} is already being used by another nonprofit, project, or fundraiser. Try using a different name."
	rescue Test::Unit::AssertionFailedError
	end
	begin
		assert $browser.is_text_present("Congratulations, your page has been created!")
		puts "Passed. #{story_name} created successfully!"
	rescue Test::Unit::AssertionFailedError
		puts "Failed. #{story_name} creation failed!"
	end
	
	$browser.click "link=View"
	$browser.wait_for_page_to_load
	
	puts "************** END : Create Story Page ****************"
end


# --------------------------------------------------------------------------------------#
# Description:  This method allows the user to logout from the Razoo application.
# --------------------------------------------------------------------------------------#
def logout()
	
	puts "************** START : Log out from Razoo ****************"
	sleep 1
	#***************** Link position check *****************#
	@logoutlink_topposition = $browser.get_element_position_top "link=Log out"
	puts "Logout link Top position : #{@logoutlink_topposition}"
	if @logoutlink_topposition == '12' or @logoutlink_topposition == '11'
		puts "UI Check : Pass. Logout link is present at the correct position in Team screen."
	else
		puts "UI Check : Fail. Logout link is not present at the correct position in Team screen."
	end
	begin
		assert $browser.is_text_present("Contact Razoo")
			puts "Passed. Contact Razoo label gets displayed at the footer."
		rescue Test::Unit::AssertionFailedError
			puts "Failed. Contact Razoo label is not displayed at the footer."
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
# Description:  This method will stop the running browser.
# --------------------------------------------------------------------------------------#
def stopBrowser()
	
	$browser.stop
	
end

