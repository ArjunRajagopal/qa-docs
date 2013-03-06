require "watir"
#url = "http://alpha-stage.razoo.com/story/Red-Cross"
test_site = "http://www-stage.razoo.com/"
ie = Watir::IE.new
puts "Beginning of test: Log into Razoo Alpha Stage"
puts "Step 1: Go to the Razoo test site: " + test_site
ie.goto test_site
if ie.text.include? "See More In"
  puts "Home Page Reached"
  else
  puts "Home Page Land Unsuccessfull"
end
ie.link(:text,"LOG IN").click
puts "Step 2: Entering user credentials to log in"
ie.text_field(:id, "session_username").set("your username")
ie.text_field(:id, "session_password").set("your pwd") 
ie.button(:value,"Log In").click
if ie.text.include? "Profile"
  puts "Profile Page reached"
  else
  puts "Error landing on Profile page"
end
puts "Clicking on the Profile link"
ie.link(:text,"Profile").click
puts "I want to edit my details"
ie.link(:text,"edit").click
puts "Editing all my details"
ie.text_field(:id, "first").set("Rajkumar")
ie.text_field(:id, "last").set("Sithavan")
ie.text_field(:id, "statement").set("Make a diff")
#ie.button(:id,"account_picture").click
ie.text_field(:id, "occupation").set("BA")
ie.text_field(:id, "location").set("DC")
ie.text_field(:id, "facebook_url").set("http://www.facebook.com/rajkumar.sithavan")
ie.text_field(:id, "twitter_url").set("http://twitter.com/sithava")
ie.text_field(:id, "linkedin_url").set("http://www.linkedin.com/in/rajkumarsithavan")
ie.link(:text,"save").click
sleep 1
puts "Changing my settings"
ie.link(:text,"Settings").click
ie.text_field(:id, "first").set("Raj")
ie.text_field(:id, "last").set("Sithavan")
ie.text_field(:id, "address1").set("1915 I street")
ie.text_field(:id, "address2").set("Suite 700")
ie.text_field(:id, "city").set("Washington")
ie.text_field(:id, "state").set("DC")
ie.text_field(:id, "postal").set("2000Raj")
ie.text_field(:id, "phone").set("Raj")
ie.text_field(:id, "username").set("Raj")
ie.text_field(:id, "password").set("machoman84")
ie.text_field(:id, "password_confirmation").set("machoman84")
ie.button(:value,"Save Changes").click
#ie.goto url
sleep 4
ie.link(:text,"LOG OUT").click
sleep 1
puts "Testing is done!"
puts "Closing the browser"
ie.close

