require "firewatir"
include FireWatir
url = "http://www-stage.razoo.com/story/Support-Harvard"
test_site = "http://stage:krug1916@www-stage.razoo.com/"
ff=Firefox.new
puts "Beginning of test: Log into Razoo Alpha Stage"
puts "Step 1: Go to the Razoo production site: " + test_site
ff.goto test_site
if ff.text.include? "See More In"
  puts "Step 1 Passed"
  else
  puts "Step 1 failed"
end
ff.link(:text, "LOG IN").click
puts "Step 2: Entering user credentials to log in"
ff.text_field(:id, "session_username").set("your user name")
ff.text_field(:id, "session_password").set("your pwd") 
ff.button(:value,"Log In").click
if ff.text.include? "Profile"
  puts "Step 2 Passed"
  else
  puts "Step 2 Failed"
end
puts "Step 3: Searching for Project: Support Harvard"
ff.link(:text, "BROWSE").click
ff.text_field(:id, "parametricKeyword").set("Support Harvard")
sleep 5
ff.link(:text,"Support Harvard").click
if ff.text.include? "Support"
  puts "NPO Page Reached"
else
  puts "Error in reaching Support Harvard Page"
end
puts "Step 4: Clicking donate button"
ff.radio(:id, "customDonationLevel", "custom").set
ff.text_field(:id, "donation_amount").set("12")
ff.button(:id,"storyDonateButton").click

#ff.img(:name,"storyDonateForm").click
if ff.text.include? "Donate"
  puts "Moved to Donation Page"
else
  puts "Error"
end
ff.select_list(:name, "scheduled_donation[period]").select("Weekly")
puts "Entering credit card details"
ff.div(:id, "newCard").click
puts "Entering credit card information(Master Card)"
ff.text_field(:name, "card[address1]").set("1915 I street")
ff.text_field(:name, "card[city]").set("Washington")
ff.text_field(:name, "card[state]").set("District of Columbia")
ff.text_field(:name, "card[postal]").set("20006")
ff.text_field(:name, "card[phone]").set("8063681580")
ff.text_field(:name, "card[number]").set("378282246310005")
ff.text_field(:name, "card[exp_month]").set("08")
ff.text_field(:name, "card[exp_year]").set("11")
ff.text_field(:name, "card[csc]").set("0719")
puts "Click Donate Now button"
ff.image(:id,"donationSubmit").click
sleep 35
if ff.text.include? "Thank you for your gift to"
  puts "Donation Successfull"
  else
  puts "Donation Unsuccessfull"
end
puts "Entering comments - donor wall"
ff.text_field(:id, "testimonial").set("Best****")
ff.checkbox(:name, "post_to_facebook").clear
ff.link(:text,"Post Comment").click
sleep 2
ff.link(:text,"Go to My Profile").click
if ff.text.include? "Best****"
  puts "Comment got posted in my profile"
else
  puts "Comment Error"
end
sleep 2
ff.link(:text,"Donations").click
puts "Firstly, I want to see if my donation got recorded"
if ff.text.include? "$37"
  puts "Yes it is!"
else
  puts "No :(("
end
puts "Checking to see if my recurring donation is setup for Support Harvard"
ff.li(:text,"Scheduled Donations").click
sleep 3
if ff.text.include? "$37"
  puts "Yes it is!"
else
  puts "No :(("
end
sleep 2
ff.link(:text,"LOG OUT").click
sleep 1
puts "Testing is done!"
puts "Closing the browser"
ff.close


