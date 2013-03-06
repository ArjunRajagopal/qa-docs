require "watir"
include FireWatir
url = "http://www-stage.razoo.com/story/Red-Cross"
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
ie.text_field(:id, "session_username").set("your user name")
ie.text_field(:id, "session_password").set("your pwd") 
ie.button(:value,"Log In").click
if ie.text.include? "Profile"
  puts "Profile Page reached"
  else
  puts "Error landing on Profile page"
end
puts "Step 3: Searching Red Cross"
ie.link(:text,"BROWSE").click
ie.text_field(:id, "parametricKeyword").set("red cross!~")
sleep 5
ie.link(:text,"red cross!~").click
if ie.text.include? "red cross!~"
  puts "FR page reached"
else
  puts "Error reaching FR page"
end
ie.button(:id,"storyFollowButton").click
sleep 7
#if ie.image(:alt,"Rajkumar Sithavan").include? 
#puts "RESULT: You are following this org"
#else 
  #puts "RESULT: Error in following this org"
#end
sleep 7
puts "Moving to my profile page to check if this org is added to my followers list"
ie.image(:alt,"Raj Sithavan").click
#if ie.text.include? "red cross!~"
  #puts "Yes it is!"
#else
  #puts "Oops where did it go???"
#end
puts "I dont want to follow this FR page anymore"
puts "I need to delete it now"
ie.div(:title,"stop following red cross!~").click
puts "Deleted from my list of followers"
ie.goto url
ie.link(:text,"LOG OUT").click
sleep 1
puts "Testing is done!"
puts "Closing the browser"
ie.close

