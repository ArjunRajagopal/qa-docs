#--------------------------------------------------------------------------------------------------#
# Razoo_Test_Cases.rb
#
# Author: EBI,SDR and SID
# Date: 17-NOV-2010
# Description:  Includes all the methods that are required to execute the sanity test cases in FF.
#
# Change history:
#
#--------------------------------------------------------------------------------------------------#

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
		:url => "https://www-qarc.razoo.com/login",
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
	$browser.click "//button[@type='submit']"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Your account has been created.")
		puts "Step 2 : Passed. Account has been created successfully!"
		rescue Test::Unit::AssertionFailedError
		begin
			assert $browser.is_text_present("Email is already in use by another account (if it's yours, you can recover your account password from the login screen)")
			puts 	"Step 2 : Failed. #{email_id} has already been taken."
			login(email_id, pass_word)
		rescue Test::Unit::AssertionFailedError
			puts "Step 2 : Failed. Account not created successfully!"
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
	

# -------------------------------------------------------------------------------------------------#
# Description:  This method allows the user to check/click Signup Login links in Razoo.
# -------------------------------------------------------------------------------------------------#
def verifySignupLoginLinks()
	
	puts "************** START: Verify SignUp Login Links ****************"
	puts "Step 1 : Click on Sign Up Link at the Header."
	$browser.click "link=Sign up"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Create an account on Razoo")
		puts "Step 1 is passed. User has reached the Sign Up screen successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 is Failed. User had failed to reach the Sign Up screen."
		$verification_errors << $!
	end
	
	puts "Step 2 : Click on Login Link in the Sign up screen."
	$browser.click "link=Log In"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Log in")
		puts "Step 2 is passed. User has reached the Login screen successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 is Failed. User had failed to reach the Login screen."
		$verification_errors << $!
	end
	
	puts "Step 3 : Click on Forgot Password Link in the Login screen."
	$browser.click "link=exact:Forgot login details?"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Reset Your Password")
		puts "Step 3 is passed. User has reached the Reset Your Password screen successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 is Failed. User had failed to reach the Reset Your Password screen."
		$verification_errors << $!
	end
	
	puts "************** END: Verify SignUp Login Links ****************"
end

# -------------------------------------------------------------------------------------------------#
# Description:  This method allows the user to check/click all the Header links in Razoo.
# -------------------------------------------------------------------------------------------------#
def verifyHeaderLinks()

	puts "************** START: Verify Header Links ****************"
	puts "Step 1 : Click on Donate Link at the Header"
	$browser.click "//strong"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Search by Name, Keyword, or Zip Code")
		puts "Step 1 is Passed. User has reached the Search page successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 is Failed. User had failed to reach the Search Page."
		$verification_errors << $!
	end

	puts "Step 2 : Click on Fundraise Link at the Header"
	$browser.click "//li[2]/a/strong"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Create a Fundraising Page")
		puts "Step 2 is Passed. User has reached the Create Fundraising page successfully thro' Header."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 is Failed. User had failed to reach the Create Fundraising page thro' Header."
		$verification_errors << $!
	end
	begin
		assert $browser.is_element_present("link=Start a fundraiser")
		puts "Step 2 is Passed. User has reached the Create Fundraising page successfully thro' Header."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 is Failed. User had failed to reach the Create Fundraising page thro' Header."
		$verification_errors << $!
	end
	
	puts "Step 3 : Click on Search Image icon at the Header"
	$browser.click "//input[@type='image']"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Search by Name, Keyword, or Zip Code")
		puts "Step 3 is Passed. User has reached the Search page successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 is Failed. User had failed to reach the Search Page."
		$verification_errors << $!
	end
	
	puts "************** END: Verify Header Links ****************"
end

# -------------------------------------------------------------------------------------------------#
# Description:  This method allows the user to check/click all the Footer links in Razoo.
# -------------------------------------------------------------------------------------------------#
def verifyFooterLinks()
	
	puts "************** START: Verify Footer Links ****************"
	
	puts "Step 1 : Click on Fundraise Link at the Footer"
	$browser.click "//div/a/em"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Create a Fundraising Page")
		puts "Step 1 is Passed. User has reached the Create Fundraising page successfully thro' Footer."
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 is Failed. User had failed to reach the Create Fundraising page thro' Footer."
		$verification_errors << $!
	end
	begin
		assert $browser.is_element_present("link=Start a fundraiser")
		puts "Step 2 is Passed. User has reached the Create Fundraising page successfully thro' Footer."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 is Failed. User had failed to reach the Create Fundraising page thro' Footer."
		$verification_errors << $!
	end

	puts "Step 3 : Click on Nonprofits Link at the Footer"
	$browser.click "//div[2]/div/a/em"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Razoo For Nonprofits")
		puts "Step 3 is Passed. User has reached the Claim Admin Access page successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 is Failed. User had failed to reach the Claim Admin Access page."
		$verification_errors << $!
	end
	puts "************** END: Verify Footer Links ****************"
	
end

# -------------------------------------------------------------------------------------------------#
# Description:  This method allows the user to check/click all the MyAccount links in Razoo.
# -------------------------------------------------------------------------------------------------#
def verifyMyAccountLinks()
	
	puts "************** START: Verify MyAccount Links ****************"
	
	puts "Step 1 : Verify all the links under My Account screen."
	$browser.click "myAccountHeaderLink"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("My Account")
		puts "Step 1.1 : User has reached the Account page successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 1.1 : User had failed to reach the Account page."
		$verification_errors << $!
	end
	$browser.click "link=Edit My Profile"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Edit My Profile")
		puts "Step 1.2 : User has reached the EditMyProfile page successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 1.2 : User had failed to reach the EditMyProfile page."
		$verification_errors << $!
	end
	$browser.click "link=My Donations"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Start donating")
		puts "Step 1.3 : User has reached the My Donations page successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 1.3 : User had failed to reach the My Donations page."
		$verification_errors << $!
	end
	$browser.click "link=Account Settings"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Change your login information")
		puts "Step 1.4 : User has reached the Account Settings page successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 1.4 : User had failed to reach the Account Settings page."
		$verification_errors << $!
	end
	begin
		assert $browser.is_element_present("link=My Saved Cards")
		$browser.click "link=My Saved Cards"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_text_present("My Credit Cards")
			puts "Step 1.5 : User has reached the My Saved Card page successfully."
		rescue Test::Unit::AssertionFailedError
			puts "Step 1.5 : User had failed to reach the My Saved Card page."
			$verification_errors << $!
		end
	rescue
		$verification_errors << $!
		puts "Step 1.5 : My Saved card link is not available for this User."
	end
	
	puts "************** END: Verify MyAccount Links ****************"
	
end

# -----------------------------------------------------------------------------------------------------#
# Description:  This method allows the NPO Admin to check/click all the Story links in Razoo.
# -----------------------------------------------------------------------------------------------------#
def verifyNPOAdminLinks(story_name)
	
	puts "************** START: Verify ORG page Links ****************"
	
	puts "Step 1 : Click on MY NPO link at the Header."
	$browser.click "link=My NPO"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present(story_name)
		puts "Step 1 is Passed. User has reached the MY NPO screen successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 is Failed. User had failed to reach MY NPO screen."
		$verification_errors << $!
	end
	
	puts "Step 2 : Click on EditPage link on the Story page."
	$browser.click "link=Edit Page"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("The Basics")
		puts "Step 2 is Passed. User has reached the EditPage screen successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 is Failed. User had failed to reach EditPage screen."
		$verification_errors << $!
	end

	puts "Step 3 : Click on Thumbnail link on the Story page."
	$browser.click "link=Thumbnail"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Current Thumbnail")
		puts "Step 3 is Passed. User has reached the Thumbnail screen successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 is Failed. User had failed to reach Thumbnail screen."
		$verification_errors << $!
	end
	
	puts "Step 4 : Click on Matching Grants link on the Story page."
	$browser.click "link=Matching Grants"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Grantor")
		puts "Step 4 is Passed. User has reached the Matching Grants screen successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 4 is Failed. User had failed to reach Matching Grants screen."
		$verification_errors << $!
	end
	
	puts "Step 5 : Click on NPO Details link on the Story page."
	$browser.click "link=NPO Details"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Charity Logo:")
		puts "Step 5 is Passed. User has reached the NPO Details screen successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 5 is Failed. User had failed to reach NPO Details screen."
		$verification_errors << $!
	end
	
	puts "Step 6 : Click on Promote link on the Story page."
	$browser.click "link=Promote"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Or get a donation button to put on your website")
		puts "Step 6 is Passed. User has reached the Promote screen successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 6 is Failed. User had failed to reach Promote screen."
		$verification_errors << $!
	end
	
	puts "Step 7 : Click on DonateAnywhere link on the Story page."
	$browser.click "link=DonateAnywhere"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("DonateAnywhere")
		puts "Step 7 is Passed. User has reached the DonateAnywhere screen successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 7 is Failed. User had failed to reach DonateAnywhere screen."
		$verification_errors << $!
	end
	
	puts "Step 8 : Click on Donations link on the Story page."
	$browser.click "link=Donations"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Donations Listing")
		puts "Step 8 is Passed. User has reached the Donations screen successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 8 is Failed. User had failed to reach Donations screen."
		$verification_errors << $!
	end
	
	puts "Step 9 : Click on Disbursements link on the Story page."
	$browser.click "link=Disbursements"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Disbursements")
		puts "Step 9 is Passed. User has reached the Disbursements screen successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 9 is Failed. User had failed to reach Disbursements screen."
		$verification_errors << $!
	end
	
	# ------------------------------ Global Admin Links -----------------------------
	begin 
		assert $browser.is_element_present("link=Data Sources")
		puts "Step 10 : Click on Create Data Sources link on the Story page."
		$browser.click "link=Data Sources"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_text_present("Razoo Admin Area")
			puts "Step 10 is Passed. User has reached the Data Sources screen successfully."
		rescue Test::Unit::AssertionFailedError
			puts "Step 10 is Failed. User had failed to reach Data Sources screen."
			$verification_errors << $!
		end
		puts "Step 11 : Click on Create Audits link on the Story page."
		$browser.click "link=Audits"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_text_present("PATRIOT Act")
			puts "Step 11 is Passed. User has reached the Audits screen successfully."
		rescue Test::Unit::AssertionFailedError
			puts "Step 11 is Failed. User had failed to reach Audits screen."
			$verification_errors << $!
		end
	rescue
		puts "Step 10 & 11 : I don't have access to view Data Sources and Audit links."
	end
	# ------------------------------ Global Admin Links -----------------------------
	
	puts "Step 12 : Click on Create Project link on the Story page."
	$browser.click "link=Create Project"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("The Basics")
		puts "Step 12 is Passed. User has reached the Create Project screen successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 12 is Failed. User had failed to reach Create Project screen."
		$verification_errors << $!
	end
	
	puts "************** END: Verify ORG page Links ****************"

end


# -----------------------------------------------------------------------------------------------------#
# Description:  This method allows the FR/PRO Admin to check/click all the Story links in Razoo.
# -----------------------------------------------------------------------------------------------------#
def verifyStoryAdminLinks()
	
	puts "************** START: Verify PRO page Links ****************"
	
	puts "Step 1 : Click on EditPage link on the Story page."
	$browser.click "link=Edit Page"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("The Basics")
		puts "Step 1 is Passed. User has reached the EditPage screen successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 is Failed. User had failed to reach EditPage screen."
		$verification_errors << $!
	end

	puts "Step 2 : Click on Thumbnail link on the Story page."
	$browser.click "link=Thumbnail"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Current Thumbnail")
		puts "Step 2 is Passed. User has reached the Thumbnail screen successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 is Failed. User had failed to reach Thumbnail screen."
		$verification_errors << $!
	end
	
	puts "Step 3 : Click on Matching Grants link on the Story page."
	$browser.click "link=Matching Grants"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Grantor")
		puts "Step 3 is Passed. User has reached the Matching Grants screen successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 is Failed. User had failed to reach Matching Grants screen."
		$verification_errors << $!
	end
	
	puts "Step 4 : Click on Promote link on the Story page."
	$browser.click "link=Promote"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Or get a donation button to put on your website")
		puts "Step 4 is Passed. User has reached the Promote screen successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 4 is Failed. User had failed to reach Promote screen."
		$verification_errors << $!
	end
	
	puts "Step 5 : Click on DonateAnywhere link on the Story page."
	$browser.click "link=DonateAnywhere"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("DonateAnywhere")
		puts "Step 5 is Passed. User has reached the DonateAnywhere screen successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 5 is Failed. User had failed to reach DonateAnywhere screen."
		$verification_errors << $!
	end
	
	puts "Step 6 : Click on Donations link on the Story page."
	$browser.click "link=Donations"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Donations Listing")
		puts "Step 6 is Passed. User has reached the Donations screen successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 6 is Failed. User had failed to reach Donations screen."
		$verification_errors << $!
	end
	
	puts "************** END: Verify PRO page Links ****************"
	
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

