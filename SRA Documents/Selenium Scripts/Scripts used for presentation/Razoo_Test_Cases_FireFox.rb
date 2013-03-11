#-----------------------------------------------------------------------------#
# Razoo_Test_Cases.rb
#
# Author: EBI,SDR and SID
# Date: 4-OCT-2010
# Description:  Includes all the methods that are required to execute the test cases in IE.
#
#-----------------------------------------------------------------------------#

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
	@browser = Selenium::Client::Driver.new \
		:host => "localhost",
		:port => 4444,
		:browser => "*firefox", 
		:url => test_site,
		:timeout_in_second => 60

	# Start the browser session
	@browser.start_new_browser_session
	
	# Print a message in the browser-side log and status bar
	@browser.set_context("Razoo Application")
	@browser.open "/"
	puts "Passed. Razoo Site gets invoked successfully!"
	puts "************** END : Invoke Razoo Application ****************"
	
end

#-----------------------------------------------------------------------------#
# Description:  This method allows the user to create account in Razoo.
#-----------------------------------------------------------------------------#

def createRazooAccount(first_name, last_name, email_id, pass_word)
	
	puts "************** START : Create a Razoo Account ****************"	
	sleep 2
	@browser.click "link=Sign up"
	@browser.wait_for_page_to_load
	puts "Step 1 : Entering  Account creation details"
	@browser.type "user_first_name", first_name
	@browser.type "user_last_name", last_name
	@browser.type "user_email", email_id
	@browser.click "user_terms_of_use"
	@browser.type "user_password", pass_word
	@browser.type "user_password_confirmation", pass_word
	#***************** Button position check *****************#
	@createaccountbutton_topposition = @browser.get_element_position_top "//button[@type='submit']"
	puts "Create Account button Top position : #{@createaccountbutton_topposition}"
	if @createaccountbutton_topposition == '674'
		puts "UI Check : Pass. CreateAccount button is present at the correct position in Signup screen."
	else
		puts "UI Check : Fail. CreateAccount button is not present at the correct position in Signup screen."
	end
	@browser.click "//button[@type='submit']"
	@browser.wait_for_page_to_load
		
	begin
		assert @browser.is_text_present("Your account has been created.")
		puts "Step 2 : Passed. Account has been created successfully!"
	rescue Test::Unit::AssertionFailedError
		begin
			assert @browser.is_text_present("Email is already in use by another account (if it's yours, you can recover your account password from the login screen)")
			puts 	"Step 2 : Failed. #{email_id} has already been taken."
		rescue Test::Unit::AssertionFailedError
			puts "Step 2 : Failed. Account not created successfully!"
		end
	end
	begin
		assert @browser.is_element_present("myAccountHeaderLink")
		@browser.click "myAccountHeaderLink"
		@browser.wait_for_page_to_load 
		begin
			@user_name = first_name+" "+ last_name
			assert @browser.is_text_present(@user_name)
			puts "Step 3 : Passed. #{@user_name} gets displayed in Account screen."
		rescue Test::Unit::AssertionFailedError
			puts "Step 3 : Failed. #{@user_name} doesn't get displayed in Account screen."
		end
	rescue Test::Unit::AssertionFailedError
		puts "Account link is missing at the header."
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
	@loginlink_topposition = @browser.get_element_position_top "link=Log in"
	puts "Login link Top position : #{@loginlink_topposition}"
	if @loginlink_topposition == '44'
		puts "UI Check : Pass. Login link is present at the correct position in Home screen."
	else
		puts "UI Check : Fail. Login link is not present at the correct position in Home screen."
	end
	@browser.click "link=Log in"
	@browser.wait_for_page_to_load 
	sleep 5
	puts "Step 1 : Entering valid User credintials - User Name as #{email_id} and Password as #{pass_word}"
	@browser.type "user_session_email", email_id 
	@browser.type "user_session_password", pass_word
	#***************** Button position check *****************#
	@loginbutton_topposition = @browser.get_element_position_top "//button[@type='submit']"
	puts "Login button Top position : #{@loginbutton_topposition}"
	if @loginbutton_topposition == '488'
		puts "UI Check : Pass. Login button is present at the correct position in Login screen."
	else
		puts "UI Check : Fail. Login button is not present at the correct position in Login screen."
	end
	@browser.click "//button[@type='submit']"
	@browser.wait_for_page_to_load 
	begin
		assert @browser.is_text_present("Login successful!")
		puts "Step 2 : Passed. Login was Successful!!!"
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. Login Failed"
	end
	puts "************** END : Login to Razoo ****************"	
end

# --------------------------------------------------------------------------------------#
# Description:  This method allows the user to logout from the Razoo application.
# --------------------------------------------------------------------------------------#
def logout()
	
	puts "************** START : Log out from Razoo ****************"
	sleep 2
	@browser.click "link=Log out"
	@browser.wait_for_page_to_load 
	begin
		assert @browser.is_element_present("link=Log in")
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
	
	#@browser.close_current_browser_session()
	@browser.stop
	
end

