require "firewatir"
include FireWatir
url = "http://www-stage.razoo.com/story/Red-Cross"
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
puts "Step 3: Searching Red Cross"
ff.link(:text,"BROWSE").click
ff.text_field(:id, "parametricKeyword").set("red cross!~")
sleep 5
ff.link(:text,"red cross!~").click
if ff.text.include? "red cross!~"
  puts "FR page reached"
else
  puts "Error reaching FR page"
end
ff.button(:id,"storyFollowButton").click
sleep 7
if ff.image(:alt,"Raj Sithavan").include? 
puts "RESULT: You are following this org"
else 
  puts "RESULT: Error in following this org"
end
sleep 7
puts "Moving to my profile page to check if this org is added to my followers list"
ff.image(:alt,"Raj Sithavan").click
if ff.text.include? "red cross!~"
  puts "Yes it is!"
else
  puts "Oops where did it go???"
end
puts "I dont want to follow this FR page anymore"
puts "I need to delete it now"
ff.div(:title,"stop following red cross!~").click
puts "Deleted from my list of followers"
ff.goto url
ff.link(:text,"LOG OUT").click
sleep 1
puts "Testing is done!"
puts "Closing the browser"
ff.close

