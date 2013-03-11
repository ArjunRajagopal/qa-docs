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
		:browser => "*firefox", 
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
	
	sleep 600
	$story_name = project_name
	begin
		assert $browser.is_element_present("link=No Thanks")
		$browser.click "link=No Thanks"
		$browser.wait_for_page_to_load
		$browser.click "link=I'm done"
		$browser.wait_for_page_to_load 
	rescue Test::Unit::AssertionFailedError
	end
	puts "************** START: Search PROJECT ****************"
	$browser.click "css=input[type=\"image\"]"
	$browser.wait_for_page_to_load
	$browser.click "link=see all causes"
	$browser.wait_for_page_to_load
	begin
		assert $browser.is_text_present("Search by Name, Keyword, or ZIP Code")
		begin
			assert $browser.is_element_present("preferredNposOnly")
			$browser.click "preferredNposOnly"
			sleep 5
		rescue Test::Unit::AssertionFailedError
		end
		sleep 2
		#***************** Checkbox position check *****************#
		@orgcheckbox_topposition = $browser.get_element_position_top "orgScope"
		puts "ORG checkbox Top position : #{@orgcheckbox_topposition}"
		if @orgcheckbox_topposition == '142'
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
		begin
			assert $browser.is_element_present("link=#{$story_name}")
			$browser.click "//a[contains(text(),'#{$story_name}')]"
			$browser.wait_for_page_to_load
			begin
				assert_equal "#{$story_name} - Razoo", $browser.get_title
				puts "Step 3 : Passed. User reached #{$story_name} Story Page successfully!!"
			rescue Test::Unit::AssertionFailedError
				puts "Step 3 : Failed. Problem in reaching the Project Story page."
			end 
		rescue Test::Unit::AssertionFailedError
			puts "@@@@@@@@@ FAILED @@@@@@@@@. Newly created Project is not displayed in the search screen."
			$browser.click "css=img[alt=\"Your profile picture\"]"
			$browser.wait_for_page_to_load 
			$browser.click "link=My Profile"
			$browser.wait_for_page_to_load 
			begin
				assert $browser.is_element_present("link=#{$story_name}")
				puts "Pass. #{$story_name} story link is present in the Profile screen."
				$browser.click "link=#{$story_name}"
				$browser.wait_for_page_to_load 
			rescue Test::Unit::AssertionFailedError
				puts "Fail. #{$story_name} story link is not present in the Profile screen."
			end
		end
	rescue Test::Unit::AssertionFailedError
		puts "@@@@@@@@@ FAILED @@@@@@@@@. Exception thrown in the search screen."
		$browser.go_back()
		sleep 2
		$browser.click "css=img[alt=\"Your profile picture\"]"
		$browser.wait_for_page_to_load 
		sleep 2
		$browser.click "link=My Profile"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_element_present("link=#{$story_name}")
			puts "Pass. #{$story_name} story link is present in the Profile screen."
			$browser.click "link=#{$story_name}"
			$browser.wait_for_page_to_load 
		rescue Test::Unit::AssertionFailedError
			puts "Fail. #{$story_name} story link is not present in the Profile screen."
		end
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
	$browser.click "projectScope"
	sleep 3
	puts "Step 1 : Type #{$story_name} in the Search Field"
	$browser.type "parametricKeyword", fundraise_name
	$browser.click "//button[@type='submit']"
	sleep 6
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


# --------------------------------------------------------------------------------------#
# Description:  This method allows to grant the Admin rights to the Normal User.
# --------------------------------------------------------------------------------------#

def grantOrgAdminRights(admin_url, email_id, ein_number)
	
	puts "************** START : Grant ORG Admin rights ****************"	
	$browser.open admin_url
	$browser.open "admin/org_admins"
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
	$browser.click "link=Log in"
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
	$browser.click "//input[@type='image']"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Explore by Category")
		puts "Step 1 is Passed. User has reached the Search page successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 is Failed. User had failed to reach the Search Page."
		$verification_errors << $!
	end

	#~ puts "Step 2 : Click on Fundraise Link at the Header"
	#~ $browser.click "//li[2]/a/strong"
	#~ $browser.wait_for_page_to_load 
	#~ begin
		#~ assert $browser.is_text_present("Raise Money Faster and Easier on Razoo")
		#~ puts "Step 2 is Passed. User has reached the Create Fundraising page successfully thro' Header."
	#~ rescue Test::Unit::AssertionFailedError
		#~ puts "Step 2 is Failed. User had failed to reach the Create Fundraising page thro' Header."
		#~ $verification_errors << $!
	#~ end
	
	puts "Step 3 : Click on Search Image icon at the Header"
	$browser.click "//input[@type='image']"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Explore by Category")
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
		assert $browser.is_text_present("exact:What if can others are fundraising with me ?")
		puts "Step 1 is Passed. User has reached the Create Fundraising page successfully thro' Footer."
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 is Failed. User had failed to reach the Create Fundraising page thro' Footer."
		$verification_errors << $!
	end

	puts "Step 3 : Click on Nonprofits Link at the Footer"
	$browser.click "//div[2]/div/a/em"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("exact:Why Should I Claim Admin Access?")
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
	$browser.click "//img[@alt='Your profile picture']"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Your Account on Razoo")
		puts "Step 1.1 : User has reached the Account page successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 1.1 : User had failed to reach the Account page."
		$verification_errors << $!
	end
	$browser.click "link=Edit Profile"
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

# --------------------------------------------------------------------------------------#
# Description:  This method allows the Normal user to create a Story page.
# --------------------------------------------------------------------------------------#

def createStoryPage(ein_number, org_name, story_name, story_summary, page_story, youtube_url, desig_value, goal_amount,  goal_date, sug_amount, sug_desc)
	
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
		@createfrbutton_topposition = $browser.get_element_position_top "//div/p[2]/a[2]"
		puts "CreateFR button Top position : #{@createfrbutton_topposition}"
		if @createfrbutton_topposition == '258'
			puts "UI Check : Pass. CreateFR button is present at the correct position in Story screen."
		else
			puts "UI Check : Fail. CreateFR button is not present at the correct position in Story screen."
		end
		$browser.click "//div/p[2]/a[2]"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_element_present("link=Start a fundraiser")
			puts "Reached Razoo CMS page.:)"
			 $browser.click "link=Start a fundraiser"
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
		$browser.click "//div/p[2]/a[2]"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_element_present("link=Start a fundraiser")
			puts "Reached Razoo CMS page.:)"
			$browser.click "link=Start a fundraiser"
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
		$browser.click "css=button[type=submit]"
		$browser.wait_for_page_to_load 
	rescue
		@createstorybutton_topposition = $browser.get_element_position_top "css=button[type=submit]"
		puts "CreateStory button Top position : #{@createstorybutton_topposition}"
		if @createstorybutton_topposition == '258'
			puts "UI Check : Pass. CreateStory button is present at the correct position in Createstory screen."
		else
			puts "UI Check : Fail. CreateStory button is not present at the correct position in Createstory screen."
		end
		$browser.click "css=button[type=submit]"
		$browser.wait_for_page_to_load 
	end
		
	$browser.click "link=View"
	$browser.wait_for_page_to_load
		
	begin
		assert $browser.is_element_present(admin_links)
		puts "Step 10 : Passed. Admin links are available in the Created #{story_name} page"
	rescue 
	end
	begin
		assert $browser.is_text_present("Your page is 20% complete.")
		puts "Step 11 : Passed. 20% complete label gets displayed in PRO completion steps progress bar."
	rescue Test::Unit::AssertionFailedError
		puts "Step 11 : Failed. Incorrect percent is displayed in PRO completion steps progress bar."
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
	$browser.click "campaign_fundraise_for_any_org_true"
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
		assert $browser.is_text_present("Congratulations! Your team has been created.")
		puts "Step 2 : Passed. Team Campaign for #{camp_org} was created successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 : Failed. Team Campaign for #{camp_org} was not created successfully."
	end
	begin
		assert $browser.is_text_present("of $101")
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
		assert $browser.is_text_present("to start")
		puts "Step 5 : Passed. Count says 'to start' label."
	rescue Test::Unit::AssertionFailedError
		puts "Step 5 : Failed. Count doesn't say 'to start' label."
	end
	
	puts "************** END : Create Team Campaign Page ****************"	
	
end

# -----------------------------------------------------------------------------------------------------#
# Description:  This method allows the NPO Admin to check/click all the Story links in Razoo.
# -----------------------------------------------------------------------------------------------------#
def verifyNPOAdminLinks(story_name)
	
	puts "************** START: Verify ORG page Links ****************"
	
	puts "Click on MY NPO link at the Header."
	begin 
		assert $browser.is_element_present("link=My nonprofit")
		$browser.click "link=My nonprofit"
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_text_present(story_name)
			puts "Step 1 is Passed. User has reached the MY NPO screen successfully."
		rescue Test::Unit::AssertionFailedError
			puts "Step 1 is Failed. User had failed to reach MY NPO screen."
		end
	rescue
		$browser.click "link=My nonprofits"
		$browser.wait_for_page_to_load
		begin
			assert $browser.is_text_present("News Feed")
			puts "Step 1 is Passed. User has reached the Account screen successfully."
			$browser.click "link=Harvard College"
			$browser.wait_for_page_to_load
		rescue Test::Unit::AssertionFailedError
			puts "Step 1 is Failed. User had failed to reach Account screen."
		end
	end 
	sleep 5
	puts "Step 2 : Click on EditPage link on the Story page."
	$browser.click "link=Edit"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Tell Your Story")
		puts "Step 2 is Passed. User has reached the EditPage screen successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 2 is Failed. User had failed to reach EditPage screen."
		$verification_errors << $!
	end
	
	puts "Step 4 : Click on Matching Grants link on the Story page."
	$browser.click "link=Matching Grants"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Matching Grant")
		puts "Step 4 is Passed. User has reached the Matching Grants screen successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 4 is Failed. User had failed to reach Matching Grants screen."
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
	
	# ------------------------------ Global Admin Links -----------------------------
	begin 
		assert $browser.is_element_present("link=Razoo Admins")
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

	
	puts "************** END: Verify ORG page Links ****************"

end


# -----------------------------------------------------------------------------------------------------#
# Description:  This method allows the FR/PRO Admin to check/click all the Story links in Razoo.
# -----------------------------------------------------------------------------------------------------#
def verifyStoryAdminLinks()
	
	puts "************** START: Verify PRO page Links ****************"
	
	puts "Step 1 : Click on EditPage link on the Story page."
	$browser.click "link=Edit"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Tell Your Story")
		puts "Step 1 is Passed. User has reached the EditPage screen successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 1 is Failed. User had failed to reach EditPage screen."
		$verification_errors << $!
	end
	
	puts "Step 3 : Click on Matching Grants link on the Story page."
	$browser.click "link=Matching Grants"
	$browser.wait_for_page_to_load 
	begin
		assert $browser.is_text_present("Set Up a Matching Grant")
		puts "Step 3 is Passed. User has reached the Matching Grants screen successfully."
	rescue Test::Unit::AssertionFailedError
		puts "Step 3 is Failed. User had failed to reach Matching Grants screen."
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
	sleep 2
	puts "Step 2 : Entering Card Details : Name on Card - #{name_on_card}, #{card_number}, #{$email_id}"
	$browser.type "order_user_order_credit_card_attributes_full_name", name_on_card
	$browser.type "order_user_order_credit_card_attributes_address1", street
	$browser.type "order_user_order_credit_card_attributes_city", city
	$browser.select "id=card_state_select", "label=#{state}"
	$browser.type "order_user_order_credit_card_attributes_postal_code", pin_code
	$browser.type "cardNumber", card_number
	$browser.type "order_user_order_credit_card_attributes_security_code", sec_code
	
	begin
	#GUEST USER AC CREATION 
		assert $browser.is_text_present("Store my card and create account for future use")
		$browser.type "order_user_order_email", $email_id
		$browser.click "create_account"
	rescue Test::Unit::AssertionFailedError
		puts "Pass. I'm Logged in user! 'Store my card and create account for future use' checkbox is not present."
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
	if @donatenowbutton_topposition == '1305' or @donatenowbutton_topposition == '1256' or @donatenowbutton_topposition == '1222'
		puts "UI Check : Pass. DonateNow button is present at the correct position in DF screen."
	else
		puts "UI Check : Fail. DonateNow button is not present at the correct position in DF screen."
	end
	begin
		assert $browser.is_text_present("I accept the terms of use and privacy policy")
		puts "Pass. 'Terms of use' checkbox is present in the Donation Form screen."
		$browser.click "id=order_user_order_terms_of_use"
	rescue Test::Unit::AssertionFailedError
		puts "Fail. 'Terms of use' checkbox is not present in the Donation Form screen."
	end
	$browser.click "//p[@id='donationSubmit']/button"
	begin
		assert $browser.is_text_present("Processing donation...")
		puts "Processing Donation... Success!!"
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Processing Donation... failed"
	end
	$browser.wait_for_page_to_load
	begin
		assert $browser.is_text_present("Your donation was successful! We'll send you a confirmation email receipt shortly")
		puts "Step 4 : Passed. Donation was Successful! and User reached the Thank You screen."
	rescue Test::Unit::AssertionFailedError
		puts "Step 4 : Failed. Donation was Failed!"
	end
	$browser.click "link=No Thanks"
	$browser.wait_for_page_to_load
	$browser.click "link=I'm done"
	$browser.wait_for_page_to_load 
	
	puts "************** END : Make a donation using New Card ****************"	
	
end

# ----------------------------------------------------------------------------------------------------------------#
# Description:  This method allows the user to purchase the giving card of 10 dollars worth.
# ----------------------------------------------------------------------------------------------------------------#

def purchaseGivingCard (recipient_name, recipient_emailid, recipient_deliverydate, givingcard_amount, givingcard_url)
	
	puts "************** START : Purchase Giving Card ****************"	
	$browser.open givingcard_url
	$browser.wait_for_page_to_load
	begin
		assert $browser.is_text_present("Giving Card")
		puts "Step 1 : Entering all valid details in the Giving Card purchase screen."
		$browser.type "id=order_gift_card_purchase_attributes_recipient_name", recipient_name
		$browser.type "id=order_gift_card_purchase_attributes_recipient_email", recipient_emailid
		$browser.click "id=order_gift_card_purchase_attributes_deliver_on"
		$browser.click recipient_deliverydate
		$browser.click "id=order_terms_of_use"
		begin
			assert $browser.is_text_present("Please note all gift card sales are final. There will be no refunds.")
			puts "Pass. 'Please note all gift card sales are final. There will be no refunds' content is present."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. 'Please note all gift card sales are final. There will be no refunds' content is not present."
		end
		$browser.click "css=button[type='submit']"
		begin
			assert $browser.is_text_present("Processing purchase...")
			puts "Processing purchase... processing icon Success!!"
		rescue Test::Unit::AssertionFailedError
			puts "Failed. Processing purchase... processing icon is missing."
		end
		$browser.wait_for_page_to_load 
		begin
			assert $browser.is_text_present("Thank you for purchasing a Razoo Giving Card!")
			puts "Step 2 : Pass. User has reached the Thank You screen successfully."
		rescue Test::Unit::AssertionFailedError
			puts "Step 2 : Fail. User has failed to reach the Thank You screen successfully."
		end
		begin
			assert $browser.is_text_present("Your purchase was successful! We'll send you a confirmation email receipt shortly.")
			puts "Pass. Correct information flash text is displayed in the 'Thank You' screen."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. Incorrect information flash text is displayed in the 'Thank You' screen."
		end
		begin
			assert $browser.is_text_present(givingcard_amount)
			puts "Pass. #{givingcard_amount} giving card purchase amount successfully displayed in the Thank You screen."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. #{givingcard_amount} giving card purchase amount is not displayed in the Thank You screen."
		end
		begin
			assert $browser.is_text_present(recipient_emailid)
			puts "Pass. #{recipient_emailid} recipient emailId is displayed in the Thank You screen."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. #{recipient_emailid} recipient emailId is not displayed in the Thank You screen."
		end
		begin
			assert $browser.is_text_present("Recipient Name")
			puts "Pass. #{recipient_name} successfully displayed in the Thank You screen."
		rescue Test::Unit::AssertionFailedError
			puts "Fail. #{recipient_name} is not displayed in the Thank You screen."
		end
		$browser.click "link=Back to Homepage"
		$browser.wait_for_page_to_load 
	rescue Test::Unit::AssertionFailedError
		puts "Failed. Giving Card purchase screen is not available to this user, since there is no theme/collection is available."
	end
	puts "************** END : Purchase Giving Card ****************"	
	
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

