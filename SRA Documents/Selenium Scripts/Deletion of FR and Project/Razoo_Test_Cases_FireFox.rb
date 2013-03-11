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

# ------------------------------------------------------------------------------#
# Description:  This method allows the user to login to Razoo application.
# ------------------------------------------------------------------------------#
def login (email_id, pass_word)
	
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
		puts "Passed. Login was Successful!!!"
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Login Failed"
	end
	puts "************** END : Login to Razoo ****************"	
end

# -------------------------------------------------------------------------------------#
# Description:  This method allows the Razoo Admin to delete the FR/PRO page.
# -------------------------------------------------------------------------------------#
def deleteFundraiser (story_urn)

	puts "***************** START : Delete Fundraising page *******************"
	
	$browser.open "/story/"+story_urn
	$browser.wait_for_page_to_load
	begin
		assert $browser.is_text_present("[DELETED]")
		puts "ALERT : This #{story_urn} page has already been deleted."
	rescue
		begin
			assert $browser.is_text_present("A project of")
			puts "Pass. Razoo Admin has reached the Project page."
			$browser.open "/story/"+story_urn+"/delete_confirmation"
			$browser.wait_for_page_to_load
			begin
				assert_equal "Delete It", $browser.get_value("name=commit")
				puts "Pass. Delete It link is present in the #{story_urn} deletion screen."
				$browser.click "name=commit"
				$browser.wait_for_page_to_load
				begin
					assert $browser.is_element_present("css=div.feedback > p")
					puts "Pass. #{story_urn} story page has been successfully deleted."
				rescue Test::Unit::AssertionFailedError
					puts "Fail. #{story_urn} story page is not successfully deleted."
				end
			rescue Test::Unit::AssertionFailedError
				puts "Fail. 'Delete It' link is not present in the #{story_urn} deletion screen."
			end
		rescue Test::Unit::AssertionFailedError
			begin
				assert $browser.is_text_present("A verified US-registered nonprofit")
				puts "Sorry... You have reached the ORG page. You shouldn't delete me :)"
			rescue Test::Unit::AssertionFailedError
				puts "Pass. Razoo Admin has reached the FR page."
				$browser.open "/story/"+story_urn+"/delete_confirmation"
				$browser.wait_for_page_to_load
				begin
					assert_equal "Delete It", $browser.get_value("name=commit")
					puts "Pass. Delete It link is present in the #{story_urn} deletion screen."
					$browser.click "name=commit"
					$browser.wait_for_page_to_load
					begin
						assert $browser.is_element_present("css=div.feedback > p")
						puts "Pass. #{story_urn} story page has been successfully deleted."
					rescue Test::Unit::AssertionFailedError
						puts "Fail. #{story_urn} story page is not successfully deleted."
					end
				rescue Test::Unit::AssertionFailedError
				puts "Fail. 'Delete It' link is not present in the #{story_urn} deletion screen."
				end
			end
		end
	end
	puts "***************** END : Delete Fundraising page *******************"
end


# --------------------------------------------------------------------------------------#
# Description:  This method allows the user to logout from the Razoo application.
# --------------------------------------------------------------------------------------#
def logout()
	
	puts "************** START : Log out from Razoo ****************"
	sleep 1
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

