require "watir"
url = "http://www-stage.razoo.com/organization/Hahvad-College"
test_site = "http://www-stage.razoo.com/"
ie = Watir::IE.new
puts "Beginning of test: Log into Razoo Alpha Stage"
puts "Step 1: Go to the Razoo production site: " + test_site
ie.goto test_site
if ie.text.include? "40,000 members"
  puts "Step 1 Passed"
  else
  puts "Step 1 failed"
end
ie.link(:text,"LOG IN").click
puts "Step 2: Entering user credentials to log in"
ie.text_field(:id, "session_username").set("you username")
ie.text_field(:id, "session_password").set("your password") 
ie.button(:value,"Log In").click
if ie.text.include? "Profile"
  puts "Step 2 Passed"
  else
  puts "Step 2 Failed"
end
puts "Step 3: Searching for Project: Support Harvard"
ie.link(:text,"BROWSE").click
ie.text_field(:id, "parametricKeyword").set("Hahvad College")
sleep 5
ie.link(:text,"Hahvad College").click
if ie.text.include? "Lance"
  puts "NPO Page Reached"
else
  puts "Error in reaching Lance Page"
end
puts "Step 4: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("10")
ie.button(:id,"storyDonateButton").click

#ie.img(:name,"storyDonateForm").click
if ie.text.include? "Donate"
  puts "Moved to Donation Page"
else
  puts "Error"
end
puts "Entering credit card details"
ie.div(:id, "newCard").click
puts "Entering credit card information(Master Card)"
ie.text_field(:name, "card[address1]").set("1915 I street")
ie.text_field(:name, "card[city]").set("Washington")
ie.text_field(:name, "card[state]").set("District of Columbia")
ie.text_field(:name, "card[postal]").set("20006")
ie.text_field(:name, "card[phone]").set("8063681580")
ie.text_field(:name, "card[number]").set("378282246310005")
ie.text_field(:name, "card[exp_month]").set("08")
ie.text_field(:name, "card[exp_year]").set("11")
ie.text_field(:name, "card[csc]").set("0719")
ie.checkbox(:name, "remember").clear
ie.checkbox(:name, "donation[disclosure]").click
#ie.checkbox(:name, "donation[admin_disclosure]").click
puts "Step 2: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 35
if ie.text.include? "Thank you for your $ 45 gift to"
  puts "Donation Successfull"
  else
  puts "Donation Unsuccessfull"
end
puts "Entering comments - donor wall"
ie.text_field(:id, "testimonial").set("Best222")
ie.checkbox(:name, "post_to_facebook").clear
ie.link(:text,"Post Comment").click
sleep 20
ie.link(:text,"Go to My Profile").click
if ie.text.include? "Best222"
  puts "Comment got posted in my profile"
else
  puts "Comment Error"
end
sleep 2
ie.goto url
if ie.text.include? "Best222"
  puts "Comment in the Org Wall"
else
  puts "Comment Error"
end
sleep 5
puts "<<<<<<Revealing identity - both>>>>>>>"
puts "Step 4: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
if ie.text.include? "Donate"
  puts "Moved to Donation Page"
else
  puts "Error"
end
puts "Donating without comments"
puts "Entering credit card details"
ie.div(:id, "newCard").click
puts "Entering credit card information(Master Card)"
ie.text_field(:name, "card[address1]").set("1915 I street")
ie.text_field(:name, "card[city]").set("Washington")
ie.text_field(:name, "card[state]").set("District of Columbia")
ie.text_field(:name, "card[postal]").set("20006")
ie.text_field(:name, "card[phone]").set("8063681580")
ie.text_field(:name, "card[number]").set("378282246310005")
ie.text_field(:name, "card[exp_month]").set("08")
ie.text_field(:name, "card[exp_year]").set("11")
ie.text_field(:name, "card[csc]").set("0719")
ie.checkbox(:name, "remember").clear
ie.checkbox(:name, "donation[disclosure]").clear
#ie.checkbox(:name, "donation[admin_disclosure]").clear
puts "Step 2: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 35
if ie.text.include? "Thank you for your $55 gift to"
  puts "Donation Successfull"
  else
  puts "Donation Unsuccessfull"
end
ie.link(:text,"No Thanks").click
ie.link(:text,"LOG OUT").click
puts "Testing is done!"
puts "Closing the browser"
ie.close