require "test/unit"
require "rubygems"
gem "selenium-client"
require "selenium/client"
require "win32ole"


# Variable declarations
$verification_errors = []


class RazooTestSuite < Test::Unit::TestCase

	#------------------------------------------------------------------#
	# Description:  It is a METHOD for invoking the Razoo Site
	#------------------------------------------------------------------#

	def test_01()
		puts "Inside test 1"
		puts "************** START : Invoke Razoo Application ****************"	
		# Create a new instance of the Selenium-Client driver.
		$browser = Selenium::Client::Driver.new \
			:host => "localhost",
			:port => 4444,
			:browser => "*iexplore", 
			:url => "https://www-qatrunk.razoo.com",
			:timeout_in_second => 60

		# Start the browser session
		$browser.start_new_browser_session
		
		# Print a message in the browser-side log and status bar
		$browser.set_context("Razoo Application")
		$browser.open "/"
		puts "************** END : Invoke Razoo Application ****************"
		
	end


	# ------------------------------------------------------------------------------#
	# Description:  This method allows the user to login to Razoo application.
	# ------------------------------------------------------------------------------#
	def test_02()
		
		puts "************** START : Login to Redmine ****************"	
		
		puts "Inside test 2"
		sleep 4
		@loginbutton_topposition = $browser.get_element_position_top "link=Log in"
		puts "Login button Top position : #{@loginbutton_topposition}"
		if @loginbutton_topposition == '9'
			puts "UI Check : Pass. Login link is present at the correct position."
		else
			puts "UI Check : Fail. Login link is not present at the correct position."
		end
		
		
		
		@loginbutton_leftposition = $browser.get_element_position_left "link=Log in"
		puts "Login button Left position : #{@loginbutton_leftposition}"
		if @loginbutton_leftposition == '1091'
			puts "UI Check : Pass. Login link is present at the correct position."
		else
			puts "UI Check : Fail. Login link is not present at the correct position."
		end
		@loginbutton_width = $browser.get_element_width "link=Log in"
		puts "Login button Width : #{@loginbutton_width}"
		if @loginbutton_width == '40'
			puts "UI Check : Pass. Login link is present at the correct position."
		else
			puts "UI Check : Fail. Login link is not present at the correct position."
		end
		
		@browse_topposition = $browser.get_element_position_top "//div[2]/div/a/em"
		puts "Browse button Top position : #{@browse_topposition}"
		@signupbutton_leftposition = $browser.get_element_position_left "link=Sign up"
		puts "Signup button Left position : #{@signupbutton_leftposition}"
		@signupbutton_width = $browser.get_element_width "link=Sign up"
		puts "Signup button Width : #{@signupbutton_width}"
		
				
		#~ #$browser.click_at "link=Log in", "916,10"
		#~ #$browser.break()
		#~ $browser.wait_for_page_to_load 
		#~ puts "Step 1 : Entering valid User credintials - User Name as #{email_id} and Password as #{pass_word}"
		#~ $browser.type "user_session_email", email_id 
		#~ $browser.type "user_session_password", pass_word
		#~ $browser.click "//button[@type='submit']"
		#~ $browser.wait_for_page_to_load 
		
		#~ # FOR LOOP
		#~ for row in 1..10
			#~ print row, "Hello\n"
		#~ end
		
		#~ puts "----------------------------"
		#~ # ARRAY
		#~ $players = "www.google.com/test   "
		#~ print $players.strip, "\n"
		#~ $splitvalue = $players.split("/", 5)
		#~ print $splitvalue[0], "\n"
		#~ print $players, "\n"
		#~ print $players.length, "\n"
		
		#~ puts "----------------------------"
		#~ #ANOTHER METHOD
		#~ $players = ["sachin","dravid","ganguly    "]
		#~ $players.pop
		#~ $players.push("Sheryln")
		#~ $players.each { |i| print i, "\n"}
		
		#~ puts "----------------------------"
		#~ presidents = ["Ford", "Carter", "Reagan", "Bush1", "Clinton", "Bush2"]
		#~ for ss in 0...presidents.length
		#~ print ss, ": ", presidents[-ss -1], "\n";
		#~ end
		#~ puts "----------------------------"
		
		#~ string1 = "Steve was here"
		#~ print "e.*e found", "\n" if string1 =~ /e.*e/

		#~ puts "----------------------------"
		#~ mystring = "wew_1234"
		#~ regex = Regexp.new(/we../)
		#~ matchdata = regex.match(mystring)
		#~ if matchdata
			#~ puts matchdata[0]
		#~ else
			#~ puts "NO MATCH"
		#~ end
		
			
		#~ $browser.click "link=Sign in"
		#~ $browser.wait_for_page_to_load 
		#~ $browser.type "username", email_id
		#~ $browser.type "password", pass_word
		#~ $browser.click "login"
		#~ $browser.wait_for_page_to_load 

		puts "************** END : Login to Redmine ****************"	
	end

	# --------------------------------------------------------------------------------------#
	# Description:  This method will stop the running browser.
	# --------------------------------------------------------------------------------------#
	def test_03()
		puts "Inside test 3"
		$browser.stop
		
	end

end
    