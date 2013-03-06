require "firewatir"
include FireWatir
url = "http://www-stage.razoo.com/story/Support-Harvard"
url1 = "http://www.facebook.com"
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
ff.image(:alt,"Connect with Facebook").click
ff.text_field(:id, "email").set("type your nail id")
ff.text_field(:id, "pass").set("type your password") 
ff.button(:value,"Login").click
sleep 5
ff.link(:text, "A New Razoo User")
puts "Step 2: Searching for Support-Harvard"
ff.link(:text,"BROWSE").click
ff.text_field(:id, "parametricKeyword").set("Support Harvard")
sleep 5
ff.link(:text,"Support Harvard").click
if ff.text.include? "Support"
  puts "FR Page Reached"
else
  puts "Error in reaching FR Page"
end
puts "Step 3: Clicking donate button"
ff.radio(:id, "customDonationLevel", "custom").set
ff.text_field(:id, "donation_amount").set("10")
ff.button(:id,"storyDonateButton").click
if ff.text.include? "Donate"
  puts "Moved to Donation Page"
else
  puts "Error"
end
puts "Step 4: Entering credit card information"
ff.div(:id, "newCard").click
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
puts "Step 3: Click Donate Now button"
ff.image(:id,"donationSubmit").click
sleep 35
if ff.text.include? "Thank you for your gift to"
  puts "Donation Successfull"
  else
  puts "Donation Unsuccessfull"
end
puts "Entering comments - donor wall"
ff.text_field(:id, "testimonial").set("Happy to contribute")
ff.link(:text,"Post Comment").click
sleep 20
puts "Published on Facebook"
ff.link(:text,"Go to My Profile").click
if ff.text.include? "Happy to contribute"
  puts "Comment got posted in my profile"
else
  puts "Comment Error"
end
sleep 6
ff.goto url
if ff.text.include? "Happy to contribute"
  puts "Comment got posted in the Org Wall"
else
  puts "Comment Error"
end
sleep 5
puts "Let me go to Facebook and see if my comment has got posted"
puts "Here we go.... Facebook.com"
ff.goto url1
ff.link(:text,"Kyuway Razu").click
if ff.text.include? "Happy to contribute"
  puts "Yippe! my comment is on fb...wonderful!!!"
  else
  puts "Oh Nooooooooooooooo"
end
sleep 5
ff.goto url
puts "Step 3: Clicking donate button"
ff.radio(:id, "customDonationLevel", "custom").set
ff.text_field(:id, "donation_amount").set("20")
ff.button(:id,"storyDonateButton").click
if ff.text.include? "Donate"
  puts "Moved to Donation Page"
else
  puts "Error"
end
puts "Step 4: Entering credit card information"
ff.div(:id, "newCard").click
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
puts "Step 3: Click Donate Now button"
ff.image(:id,"donationSubmit").click
sleep 25
if ff.text.include? "Thank you for your gift to"
  puts "Donation Successfull"
  else
  puts "Donation Unsuccessfull"
end
puts "Entering comments - donor wall"
ff.text_field(:id, "testimonial").set("Happy to contribute")
ff.link(:text,"Post Comment").click
sleep 20
puts "Published on Facebook"
ff.link(:text,"Go to My Profile").click
if ff.text.include? "Happy to contribute"
  puts "Comment got posted in my profile"
else
  puts "Comment Error"
end
sleep 6
ff.goto url
if ff.text.include? "Happy to contribute"
  puts "Comment got posted in the Org Wall"
else
  puts "Comment Error"
end
sleep 5
puts "Let me go to Facebook and see if my comment has got posted"
puts "Here we go.... Facebook.com"
ff.goto url1
ff.link(:text,"Kyuway Razu").click
if ff.text.include? "Happy to contribute"
  puts "Yippe! my comment is on fb...wonderful!!!"
  else
  puts "Oh Nooooooooooooooo"
end
sleep 5
ff.goto url
puts "Step 3: Clicking donate button"
ff.radio(:id, "customDonationLevel", "custom").set
ff.text_field(:id, "donation_amount").set("30")
ff.button(:id,"storyDonateButton").click
if ff.text.include? "Donate"
  puts "Moved to Donation Page"
else
  puts "Error"
end
puts "Step 4: Entering credit card information"
ff.div(:id, "newCard").click
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
puts "Step 3: Click Donate Now button"
ff.image(:id,"donationSubmit").click
sleep 25
if ff.text.include? "Thank you for your gift to"
  puts "Donation Successfull"
  else
  puts "Donation Unsuccessfull"
end
puts "Entering comments - donor wall"
ff.text_field(:id, "testimonial").set("Happy to contribute")
ff.link(:text,"Post Comment").click
sleep 20
puts "Published on Facebook"
ff.link(:text,"Go to My Profile").click
if ff.text.include? "Happy to contribute"
  puts "Comment got posted in my profile"
else
  puts "Comment Error"
end
sleep 6
ff.goto url
if ff.text.include? "Happy to contribute"
  puts "Comment got posted in the Org Wall"
else
  puts "Comment Error"
end
sleep 5
puts "Let me go to Facebook and see if my comment has got posted"
puts "Here we go.... Facebook.com"
ff.goto url1
ff.link(:text,"Kyuway Razu").click
if ff.text.include? "Happy to contribute"
  puts "Yippe! my comment is on fb...wonderful!!!"
  else
  puts "Oh Nooooooooooooooo"
end
sleep 5
ff.goto url
puts "Step 3: Clicking donate button"
ff.radio(:id, "customDonationLevel", "custom").set
ff.text_field(:id, "donation_amount").set("30")
ff.button(:id,"storyDonateButton").click
if ff.text.include? "Donate"
  puts "Moved to Donation Page"
else
  puts "Error"
end
puts "Step 4: Entering credit card information"
ff.div(:id, "newCard").click
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
puts "Step 3: Click Donate Now button"
ff.image(:id,"donationSubmit").click
sleep 25
if ff.text.include? "Thank you for your gift to"
  puts "Donation Successfull"
  else
  puts "Donation Unsuccessfull"
end
puts "Entering comments - donor wall"
ff.text_field(:id, "testimonial").set("Happy to contribute")
ff.link(:text,"Post Comment").click
sleep 20
puts "Published on Facebook"
ff.link(:text,"Go to My Profile").click
if ff.text.include? "Happy to contribute"
  puts "Comment got posted in my profile"
else
  puts "Comment Error"
end
sleep 6
ff.goto url
if ff.text.include? "Happy to contribute"
  puts "Comment got posted in the Org Wall"
else
  puts "Comment Error"
end
sleep 5
puts "Let me go to Facebook and see if my comment has got posted"
puts "Here we go.... Facebook.com"
ff.goto url1
ff.link(:text,"Kyuway Razu").click
if ff.text.include? "Happy to contribute"
  puts "Yippe! my comment is on fb...wonderful!!!"
  else
  puts "Oh Nooooooooooooooo"
end
sleep 5

ff.link(:text,"Logout").click
puts "Transfering to Razoo - Please wait"
ff.goto url
sleep 2
ff.link(:text,"LOG OUT").click
puts "Testing done!"
puts "Closing the browser"
ff.close