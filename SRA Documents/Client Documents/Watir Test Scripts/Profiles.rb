require "firewatir"
include FireWatir
#url = "http://alpha-stage.razoo.com/story/Red-Cross"
test_site = "http://stage:krug1916@www-stage.razoo.com/"
ff=Firefox.new
puts "Beginning of test: Log into Razoo Alpha Stage"
puts "Step 1: Go to the Razoo test site: " + test_site
ff.goto test_site
if ff.text.include? "See More In"
  puts "Home Page Reached"
  else
  puts "Home Page Land Unsuccessfull"
end
ff.link(:text,"LOG IN").click
puts "Step 2: Entering user credentials to log in"
ff.text_field(:id, "session_username").set("your user name")
ff.text_field(:id, "session_password").set("your pwd") 
ff.button(:value,"Log In").click
if ff.text.include? "Profile"
  puts "Profile Page reached"
  else
  puts "Error landing on Profile page"
end
puts "Clicking on the Profile link"
ff.link(:text,"Profile").click
puts "I want to edit my details"
ff.link(:text,"edit").click
puts "Editing all my details"
ff.text_field(:id, "first").set("Rajkumar")
ff.text_field(:id, "last").set("Sithavan")
ff.text_field(:id, "statement").set("Make a diff")
#ff.button(:id,"account_picture").click
ff.text_field(:id, "occupation").set("BA")
ff.text_field(:id, "location").set("DC")
ff.text_field(:id, "facebook_url").set("http://www.facebook.com/rajkumar.sithavan")
ff.text_field(:id, "twitter_url").set("http://twitter.com/sithava")
ff.text_field(:id, "linkedin_url").set("http://www.linkedin.com/in/rajkumarsithavan")
ff.link(:text,"save").click
sleep 1
puts "Changing my settings"
ff.link(:text,"Settings").click
ff.text_field(:id, "first").set("Raj")
ff.text_field(:id, "last").set("Sithavan")
ff.text_field(:id, "address1").set("1915 I street")
ff.text_field(:id, "address2").set("Suite 700")
ff.text_field(:id, "city").set("Washington")
ff.text_field(:id, "state").set("DC")
ff.text_field(:id, "postal").set("2000Raj")
ff.text_field(:id, "phone").set("Raj")
ff.text_field(:id, "username").set("Raj")
ff.text_field(:id, "password").set("machoman84")
ff.text_field(:id, "password_confirmation").set("machoman84")
ff.button(:value,"Save Changes").click
#ff.goto url
sleep 4
ff.link(:text,"LOG OUT").click
sleep 1
puts "Testing is done!"
puts "Closing the browser"
ff.close

