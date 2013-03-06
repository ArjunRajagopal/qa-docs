require "firewatir"
include FireWatir
url = "http://www-stage.razoo.com/story/Support-Harvard"
test_site = "http://stage:krug1916@www-stage.razoo.com/"
ff=Firefox.new
puts "Beginning of test: Log into Razoo Alpha Stage"
puts "Step 1: Go to the Razoo production site: " + test_site
ff.goto test_site
if ff.text.include? "40,000 members"
  puts "Step 1 Passed"
  else
  puts "Step 1 failed"
end
ff.link(:text,"BROWSE").click
puts "Step 3: Searching for Project: Support Harvard"
ff.text_field(:id, "parametricKeyword").set("Support Harvard")
sleep 5
ff.link(:text,"Support Harvard").click
if ff.text.include? "Support"
  puts "Project Page Reached"
else
  puts "Error in reaching Support Harvard Page"
end
puts "<<<<<<Not Revealing identity - both>>>>>>>"
puts "Step 4: Clicking donate button"
ff.radio(:id, "customDonationLevel", "custom").set
ff.text_field(:id, "donation_amount").set("45")
ff.button(:id,"storyDonateButton").click
#ff.img(:name,"storyDonateForm").click
if ff.text.include? "Donate"
  puts "Moved to Donation Page"
else
  puts "Error"
end
puts "Entering credit card details"
#ff.div(:id, "newCard").click
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
ff.checkbox(:name, "remember").clear
ff.checkbox(:name, "donation[disclosure]").click
ff.checkbox(:name, "donation[admin_disclosure]").click
puts "Step 2: Click Donate Now button"
ff.image(:id,"donationSubmit").click
sleep 8
if ff.text.include? "Thank you for your $ 45 gift to"
  puts "Donation Successfull"
  else
  puts "Donation Unsuccessfull"
end
puts "Entering comments - donor wall"
ff.text_field(:id, "testimonial").set("Best1")
ff.checkbox(:name, "post_to_facebook").clear
ff.link(:text,"Post Comment").click
sleep 2
ff.link(:text,"Go to My Profile").click
if ff.text.include? "Best1"
  puts "Comment got posted in my profile"
else
  puts "Comment Error"
end
sleep 2
ff.goto url
if ff.text.include? "Best1"
  puts "Comment in the Org Wall"
else
  puts "Comment Error"
end
sleep 5
puts "<<<<<<Revealing identity - both>>>>>>>"
puts "Step 4: Clicking donate button"
ff.radio(:id, "customDonationLevel", "custom").set
ff.text_field(:id, "donation_amount").set("55")
ff.button(:id,"storyDonateButton").click
if ff.text.include? "Donate"
  puts "Moved to Donation Page"
else
  puts "Error"
end
puts "Donating without comments"
puts "Entering credit card details"
#ff.div(:id, "newCard").click
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
ff.checkbox(:name, "remember").clear
ff.checkbox(:name, "donation[disclosure]").clear
ff.checkbox(:name, "donation[admin_disclosure]").clear
puts "Step 2: Click Donate Now button"
ff.image(:id,"donationSubmit").click
sleep 8
if ff.text.include? "Thank you for your $55 gift to"
  puts "Donation Successfull"
  else
  puts "Donation Unsuccessfull"
end
ff.goto url
puts "<<<<<<<<<<<Not Revealing info to Org alone>>>>>>"
puts "Step 4: Clicking donate button"
ff.radio(:id, "customDonationLevel", "custom").set
ff.text_field(:id, "donation_amount").set("65")
ff.button(:id,"storyDonateButton").click
if ff.text.include? "Donate"
  puts "Moved to Donation Page"
else
  puts "Error"
end
puts "Donating without comments"
puts "Entering credit card details"
#ff.div(:id, "newCard").click
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
ff.checkbox(:name, "remember").clear
ff.checkbox(:name, "donation[disclosure]").click
ff.checkbox(:name, "donation[admin_disclosure]").clear
puts "Step 2: Click Donate Now button"
ff.image(:id,"donationSubmit").click
sleep 8
if ff.text.include? "Thank you for your $55 gift to"
  puts "Donation Successfull"
  else
  puts "Donation Unsuccessfull"
end
ff.goto url
puts "<<<<<<<<<<<Not Revealing info to Project creator alone>>>>>>"
puts "Step 4: Clicking donate button"
ff.radio(:id, "customDonationLevel", "custom").set
ff.text_field(:id, "donation_amount").set("75")
ff.button(:id,"storyDonateButton").click
if ff.text.include? "Donate"
  puts "Moved to Donation Page"
else
  puts "Error"
end
puts "Donating without comments"
puts "Entering credit card details"
#ff.div(:id, "newCard").click
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
ff.checkbox(:name, "remember").clear
ff.checkbox(:name, "donation[disclosure]").clear
ff.checkbox(:name, "donation[admin_disclosure]").click
puts "Step 2: Click Donate Now button"
ff.image(:id,"donationSubmit").click
sleep 8
if ff.text.include? "Thank you for your $55 gift to"
  puts "Donation Successfull"
  else
  puts "Donation Unsuccessfull"
end
puts "Not entering any comment on donor wall.Clicking No Thanks"
ff.link(:text,"No Thanks").click
ff.link(:text,"LOG OUT").click
puts "Testing is done!"
puts "Closing the browser"
ff.close