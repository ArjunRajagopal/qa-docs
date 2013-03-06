require "watir"
url = "http://www-stage.razoo.com/story/Support-Harvard"
url1 = "http://www.facebook.com"
test_site = "http://www-stage.razoo.com/"
ie = Watir::IE.new
puts "Beginning of test: Log into Razoo Alpha Stage"
puts "Step 1: Go to the Razoo test site: " + test_site
ie.goto test_site
window = ie.ie.Document.parentWindow
if ie.text.include? "See More In"
  puts "Home Page Reached"
  else
    puts "Home Page Land Unsuccessfull"
end
ie.link(:text,"LOG IN").click
ie.image(:alt,"Connect with Facebook").click
ie.text_field(:id, "email").set("type your mail id")
ie.text_field(:id, "pass").set("your password") 
ie.button(:value,"Login").click
sleep 5
#ie.link(:text, "A New Razoo User")
puts "Step 2: Searching for Support-Harvard"
ie.link(:text,"BROWSE").click
ie.text_field(:id, "parametricKeyword").set("Support Harvard")
sleep 5
ie.link(:text,"Support Harvard").click
if ie.text.include? "Support"
  puts "FR Page Reached"
else
  puts "Error in reaching FR Page"
end
puts "Step 3: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("10")
ie.button(:id,"storyDonateButton").click
if ie.text.include? "Donate"
  puts "Moved to Donation Page"
else
  puts "Error"
end
puts "Step 4: Entering credit card information"
ie.div(:id, "newCard").click
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
ie.checkbox(:name, "donation[admin_disclosure]").click
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 35
if ie.text.include? "Thank you for your gift to"
  puts "Donation Successfull"
  else
  puts "Donation Unsuccessfull"
end
puts "Entering comments - donor wall"
ie.text_field(:id, "testimonial").set("Happy to contribute1")
ie.link(:text,"Post Comment").click
sleep 10
puts "Published on Facebook"
ie.link(:text,"Go to My Profile").click
if ie.text.include? "Happy to contribute1"
  puts "Comment got posted in my profile"
else
  puts "Comment Error"
end
sleep 6
ie.goto url
if ie.text.include? "Happy to contribute1"
  puts "Comment got posted in the Org Wall"
else
  puts "Comment Error"
end
sleep 5
puts "Let me go to Facebook and see if my comment has got posted"
puts "Here we go.... Facebook.com"
ie.goto url1
ie.link(:text,"Kyuway Razu").click
if ie.text.include? "Happy to contribute1"
  puts "Yippe! my comment is on fb...wonderful!!!"
  else
  puts "Oh Nooooooooooooooo"
end
sleep 5
ie.goto url
puts "Step 3: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("20")
ie.button(:id,"storyDonateButton").click
if ie.text.include? "Donate"
  puts "Moved to Donation Page"
else
  puts "Error"
end
puts "Step 4: Entering credit card information"
ie.div(:id, "newCard").click
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
ie.checkbox(:name, "donation[admin_disclosure]").clear
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 35
if ie.text.include? "Thank you for your gift to"
  puts "Donation Successfull"
  else
  puts "Donation Unsuccessfull"
end
puts "Entering comments - donor wall"
ie.text_field(:id, "testimonial").set("Happy to contribute2")
ie.link(:text,"Post Comment").click
sleep 10
puts "Published on Facebook"
ie.link(:text,"Go to My Profile").click
if ie.text.include? "Happy to contribute2"
  puts "Comment got posted in my profile"
else
  puts "Comment Error"
end
sleep 6
ie.goto url
if ie.text.include? "Happy to contribute2"
  puts "Comment got posted in the Org Wall"
else
  puts "Comment Error"
end
sleep 5
puts "Let me go to Facebook and see if my comment has got posted"
puts "Here we go.... Facebook.com"
ie.goto url1
ie.link(:text,"Kyuway Razu").click
if ie.text.include? "Happy to contribute2"
  puts "Yippe! my comment is on fb...wonderful!!!"
  else
  puts "Oh Nooooooooooooooo"
end
sleep 5
ie.goto url
puts "Step 3: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("30")
ie.button(:id,"storyDonateButton").click
if ie.text.include? "Donate"
  puts "Moved to Donation Page"
else
  puts "Error"
end
puts "Step 4: Entering credit card information"
ie.div(:id, "newCard").click
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
ie.checkbox(:name, "donation[admin_disclosure]").clear
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 35
if ie.text.include? "Thank you for your gift to"
  puts "Donation Successfull"
  else
  puts "Donation Unsuccessfull"
end
puts "Entering comments - donor wall"
ie.text_field(:id, "testimonial").set("Happy to contribute3")
ie.link(:text,"Post Comment").click
sleep 10
puts "Published on Facebook"
ie.link(:text,"Go to My Profile").click
if ie.text.include? "Happy to contribute3"
  puts "Comment got posted in my profile"
else
  puts "Comment Error"
end
sleep 6
ie.goto url
if ie.text.include? "Happy to contribute3"
  puts "Comment got posted in the Org Wall"
else
  puts "Comment Error"
end
sleep 5
puts "Let me go to Facebook and see if my comment has got posted"
puts "Here we go.... Facebook.com"
ie.goto url1
ie.link(:text,"Kyuway Razu").click
if ie.text.include? "Happy to contribute3"
  puts "Yippe! my comment is on fb...wonderful!!!"
  else
  puts "Oh Nooooooooooooooo"
end
sleep 5
ie.goto url
puts "Step 3: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("40")
ie.button(:id,"storyDonateButton").click
if ie.text.include? "Donate"
  puts "Moved to Donation Page"
else
  puts "Error"
end
puts "Step 4: Entering credit card information"
ie.div(:id, "newCard").click
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
ie.checkbox(:name, "donation[admin_disclosure]").click
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 35
if ie.text.include? "Thank you for your gift to"
  puts "Donation Successfull"
  else
  puts "Donation Unsuccessfull"
end
puts "Entering comments - donor wall"
ie.text_field(:id, "testimonial").set("Happy to contribute4")
ie.link(:text,"Post Comment").click
sleep 10
puts "Published on Facebook"
ie.link(:text,"Go to My Profile").click
if ie.text.include? "Happy to contribute4"
  puts "Comment got posted in my profile"
else
  puts "Comment Error"
end
sleep 6
ie.goto url
if ie.text.include? "Happy to contribute4"
  puts "Comment got posted in the Org Wall"
else
  puts "Comment Error"
end
sleep 5
puts "Let me go to Facebook and see if my comment has got posted"
puts "Here we go.... Facebook.com"
ie.goto url1
ie.link(:text,"Kyuway Razu").click
if ie.text.include? "Happy to contribute4"
  puts "Yippe! my comment is on fb...wonderful!!!"
  else
  puts "Oh Nooooooooooooooo"
end
sleep 5

ie.link(:text,"Logout").click
puts "Transfering to Razoo - Please wait"
ie.goto url
sleep 2
ie.link(:text,"LOG OUT").click
puts "Testing done!"
puts "Closing the browser"
ie.close()