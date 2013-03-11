require "test/unit"
require "rubygems"
require "selenium/client"

#gem "selenium-client"

class RazooTestSuite < Test::Unit::TestCase

  # The setup method is called before each test.
  def test00_invoke_browser

    # This array is used to capture errors and display them at the
    # end of the test run.
    $verification_errors = []

    # Create a new instance of the Selenium-Client driver.
    $Browser = Selenium::Client::Driver.new \
      :host => "localhost",
      :port => 4444,
      :browser => "*firefox", # Firefox Explorer Browser
      #:browser => "*safari",  # Safari Browser
      #:browser => "*googlechrome",  # Google Chrome Browser
      #:browser => "*iexplore",  # Internet Explorer Browser
      :url => "http://www-qatrunk.razoo.com/",
      :timeout_in_second => 60

    # Start the browser session
    $Browser.start

    # Print a message in the browser-side log and status bar
    $Browser.set_context("Razoo Application")

  end
  
  # This is the Login Method.
  def test01_login
	  
	# Open the root of the site we specified when we created the
	# new driver instance, above.
	$Browser.open "/"
 
	$Browser.click "link=LOG IN"
	puts "I have clicked Log in link"
	sleep 25
	$Browser.wait_for_page_to_load 
	puts "Im inside Loginlogoutmethod" 
	$Browser.type "user_session_email", "ebi@srasys.co.in"
	$Browser.type "user_session_password", "123456"
	$Browser.click "user_session_submit"
	
	sleep 20
	#$Browser.wait_for_page_to_load 
	begin
		assert $Browser.is_text_present("LOG OUT")
		puts "Login was Successful!!!"
	rescue Test::Unit::AssertionFailedError
		puts "Login was Failed :("
		$verification_errors << $!
	end
	puts "End of Login Method"
end

# This is the Donate And Post Comment Method.
  def test02_donate_post_comment
	
	$Browser.click "link=BROWSE"
	$Browser.wait_for_page_to_load 
	assert_equal "Learn about nonprofits and donate to charity - Razoo", $Browser.get_title
	$Browser.type "parametricKeyword", "harvard college"
	sleep 10
	$Browser.click "link=Harvard College"
	$Browser.wait_for_page_to_load 
	assert_equal "Harvard College - Razoo", $Browser.get_title
	$Browser.click "donation_amount"
	$Browser.type "donation_amount", "10"
	$Browser.click "storyDonateButton"
	$Browser.wait_for_page_to_load 
	assert_equal "An inspiring place to donate and raise money - Razoo", $Browser.get_title
	$Browser.click "donationSubmit"
	$Browser.wait_for_page_to_load 
	begin
		assert $Browser.is_text_present("Processing Donation...")
		puts "Processing Donation..."
	rescue Test::Unit::AssertionFailedError
		$verification_errors << $!
	end
	assert_equal "An inspiring place to donate and raise money - Razoo", $Browser.get_title
	begin
		assert $Browser.is_text_present("$10.00")
		puts "$10.00 is present in the Thank You screen."
	rescue Test::Unit::AssertionFailedError
		$verification_errors << $!
	end
	begin
		assert $Browser.is_text_present("Harvard College")
		puts "Donation made to Harvard College"
	rescue Test::Unit::AssertionFailedError
		$verification_errors << $!
	end
	$Browser.click "thankYouEgress"
	$Browser.wait_for_page_to_load 
	assert_equal "Harvard College - Razoo", $Browser.get_title
	$Browser.type "comment_body", "Im posting the comment!!"
	sleep 5
	$Browser.click "comment_submit"
	sleep 10
	assert $Browser.is_text_present("Thank you, your comment has been posted.")
	puts "Text is present"
	$Browser.click "link = Post your comment to Facebook"
	
	sleep 10
	$Browser.wait_for_pop_up "_blank", "30"
	$Browser.select_window "name=_e_2QUk"
	$Browser.type "email", "fbuser1@rediffmail.com"
	$Browser.type "pass", "111111"
	$Browser.click "login"
	$Browser.wait_for_page_to_load 
		
	begin
		assert $Browser.is_text_present("Im posting the comment!!")
	rescue Test::Unit::AssertionFailedError
		$verification_errors << $!
	end
	$Browser.click "publish"
	$Browser.wait_for_page_to_load 
	begin
		assert $Browser.is_text_present("Im posting the comment!!")
		puts "Comment posted successfully. Comment verified in Story page."
	rescue Test::Unit::AssertionFailedError
		$verification_errors << $!
	end
	$Browser.click "link=ACCOUNT"
	$Browser.wait_for_page_to_load 
	assert_equal "An inspiring place to donate and raise money - Razoo", $Browser.get_title
	begin
		assert $Browser.is_text_present("\"Im posting the comment!!\"")
		puts "Comment verified in My Account screen."
	rescue Test::Unit::AssertionFailedError
		$verification_errors << $!
	end
end	


  # The teardown method is called after each test.
  def test02_logout

	$Browser.click "link=LOG OUT"
	puts "Logout Successfully!!"
	$Browser.wait_for_page_to_load
	# Stop the browser session.
	$Browser.stop

  end
end
