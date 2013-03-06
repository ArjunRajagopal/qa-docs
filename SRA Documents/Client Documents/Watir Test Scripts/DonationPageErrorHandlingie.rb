require "watir"
url = "http://www-stage.razoo.com/story/Tester"
test_site = "http://www-stage.razoo.com/"
ie = Watir::IE.new
puts "Beginning of test: Log into Razoo Alpha Stage"
puts "Step 1: Go to the Razoo production site: " + test_site
ie.goto test_site
if ie.text.include? "See More In"
  puts "Step 1 Passed"
  else
  puts "Step 1 failed"
end
ie.link(:text,"LOG IN").click
puts "Step 2: Entering user credentials to log in"
ie.text_field(:id, "session_username").set("your user name")
ie.text_field(:id, "session_password").set("your pwd") 
ie.button(:value,"Log In").click
if ie.text.include? "Profile"
  puts "Step 2 Passed"
  else
  puts "Step 2 Failed"
end
puts "Step 3: Searching Tester"
ie.link(:text,"BROWSE").click
ie.text_field(:id, "parametricKeyword").set("tester")
sleep 5
ie.link(:text,"tester").click
if ie.text.include? "tester"
  puts "Step 3 Passed"
else
  puts "Step 3 Failed"
end
puts "Step 4: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
if ie.text.include? "Donate without joining Razoo"
  puts "Step 4 Passed"
else
  puts "Step 4 Failed"
end
puts "#########################################################"
puts "Donation Page error handling Scenarios"
puts "#########################################################"
puts ">>>>Scenario 1: Non-numeric characters in the donate text box>>>>>"
ie.text_field(:id, "donation_amount").set("abc")
ie.div(:id, "newCard").click
puts "Step 1: Entering credit card information(AMEX Card)"
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
puts "Step 2: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 7
#if ie.div(:id, "donationErrors").include? 
 # puts "RESULT: Scenario 1 Failed"
#else 
  #puts "RESULT: Scenario 1 Passed"
#end
sleep 5
ie.goto url
puts ">>>>Scenario 2: No amount on the Donate box>>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.text_field(:id, "donation_amount").set("")
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(AMEX Card)"
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
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 7
#if ie.div(:id, "donationErrors").include? 
  #puts "RESULT: Scenario 2 Failed"
#else 
  #puts "RESULT: Scenario 2 Passed"
#end
sleep 5
ie.goto url
puts ">>>>Scenario 3: Name on the card left blank>>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(AMEX Card)"
ie.text_field(:name, "card[name_on_card]").set("")
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
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 7
#if ie.div(:id, "donationErrors").include? 
  #puts "RESULT: Scenario 3 Failed"
#else 
  #puts "RESULT: Scenario 3 Passed"
#end
sleep 5
ie.goto url
puts ">>>>Scenario 4: Numeric data on Name on the card textbox>>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(AMEX Card)"
ie.text_field(:name, "card[name_on_card]").set("123456")
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
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 7
#if ie.div(:id, "donationErrors").include? 
  #puts "RESULT: Scenario 4 Failed"
#else 
  #puts "RESULT: Scenario 4 Passed"
#end
sleep 5
ie.goto url
puts ">>>>Scenario 5: A combination of letters and special characters on Name on the card textbox>>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(AMEX Card)"
ie.text_field(:name, "card[name_on_card]").set("Bob$*!#")
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
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 7
#if ie.div(:id, "donationErrors").include? 
 # puts "RESULT: Scenario 5 Failed"
#else 
  #puts "RESULT: Scenario 5 Passed"
#end
sleep 5
ie.goto url
puts ">>>>Scenario 6: Zip code field left blank>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(AMEX Card)"
ie.text_field(:name, "card[address1]").set("1915 I street")
ie.text_field(:name, "card[city]").set("Washington")
ie.text_field(:name, "card[state]").set("District of Columbia")
ie.text_field(:name, "card[postal]").set("")
ie.text_field(:name, "card[phone]").set("8063681580")
ie.text_field(:name, "card[number]").set("378282246310005")
ie.text_field(:name, "card[exp_month]").set("08")
ie.text_field(:name, "card[exp_year]").set("11")
ie.text_field(:name, "card[csc]").set("0719")
ie.checkbox(:name, "remember").clear
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 7
#if ie.div(:id, "donationErrors").include? 
  #puts "RESULT: Scenario 6 Failed"
#else 
  #puts "RESULT: Scenario 6 Passed"
#end
sleep 5
ie.goto url
puts ">>>>Scenario 7: Incorrect US Zip code>>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(AMEX Card)"
ie.text_field(:name, "card[address1]").set("1915 I street")
ie.text_field(:name, "card[city]").set("Washington")
ie.text_field(:name, "card[state]").set("District of Columbia")
ie.text_field(:name, "card[postal]").set("1234567")
ie.text_field(:name, "card[phone]").set("8063681580")
ie.text_field(:name, "card[number]").set("378282246310005")
ie.text_field(:name, "card[exp_month]").set("08")
ie.text_field(:name, "card[exp_year]").set("11")
ie.text_field(:name, "card[csc]").set("0719")
ie.checkbox(:name, "remember").clear
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 7
#if ie.div(:id, "donationErrors").include? 
  #puts "RESULT: Scenario 7 Failed"
#else 
  #puts "RESULT: Scenario 7 Passed"
#end
sleep 5
ie.goto url
puts ">>>>Scenario 8: Country and State do not match>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(AMEX Card)"
ie.text_field(:name, "card[address1]").set("1915 I street")
ie.text_field(:name, "card[city]").set("Washington")
ie.text_field(:name, "card[state]").set("District of Columbia")
ie.text_field(:name, "card[postal]").set("20006")
ie.select_list(:name, "card[country]").select("Sweden")
ie.text_field(:name, "card[phone]").set("8063681580")
ie.text_field(:name, "card[number]").set("378282246310005")
ie.text_field(:name, "card[exp_month]").set("08")
ie.text_field(:name, "card[exp_year]").set("11")
ie.text_field(:name, "card[csc]").set("0719")
ie.checkbox(:name, "remember").clear
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 35
#if ie.text.include? "Thank you for your $55 gift to"
  #puts "Donation Successfull"
  #else
  #puts "Donation Unsuccessfull"
#end
sleep 5
ie.goto url
puts ">>>>Scenario 8: Incorrect State and city>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(AMEX Card)"
ie.text_field(:name, "card[address1]").set("1915 I street")
ie.text_field(:name, "card[city]").set("Washington")
ie.text_field(:name, "card[state]").set("Florida")
ie.text_field(:name, "card[postal]").set("20006")
ie.text_field(:name, "card[phone]").set("8063681580")
ie.text_field(:name, "card[number]").set("378282246310005")
ie.text_field(:name, "card[exp_month]").set("08")
ie.text_field(:name, "card[exp_year]").set("11")
ie.text_field(:name, "card[csc]").set("0719")
ie.checkbox(:name, "remember").clear
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 35
#if ie.text.include? "Thank you for your $55 gift to"
  #puts "Donation Successfull"
  #else
  #puts "Donation Unsuccessfull"
#end
sleep 5
ie.goto url
puts ">>>>Scenario 8: State is left blank>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(AMEX Card)"
ie.text_field(:name, "card[address1]").set("1915 I street")
ie.text_field(:name, "card[city]").set("Washington")
ie.text_field(:name, "card[state]").set("")
ie.text_field(:name, "card[postal]").set("20006")
ie.text_field(:name, "card[phone]").set("8063681580")
ie.text_field(:name, "card[number]").set("378282246310005")
ie.text_field(:name, "card[exp_month]").set("08")
ie.text_field(:name, "card[exp_year]").set("11")
ie.text_field(:name, "card[csc]").set("0719")
ie.checkbox(:name, "remember").clear
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 7
#if ie.div(:id, "donationErrors").include? 
  #puts "RESULT: Scenario 6 Failed"
#else 
  #puts "RESULT: Scenario 6 Passed"
#end
sleep 5
ie.goto url
puts ">>>>Scenario 8: City is left blank>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(AMEX Card)"
ie.text_field(:name, "card[address1]").set("1915 I street")
ie.text_field(:name, "card[city]").set("")
ie.text_field(:name, "card[state]").set("District of Columbia")
ie.text_field(:name, "card[postal]").set("20006")
ie.text_field(:name, "card[phone]").set("8063681580")
ie.text_field(:name, "card[number]").set("378282246310005")
ie.text_field(:name, "card[exp_month]").set("08")
ie.text_field(:name, "card[exp_year]").set("11")
ie.text_field(:name, "card[csc]").set("0719")
ie.checkbox(:name, "remember").clear
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 7
#if ie.div(:id, "donationErrors").include? 
  #puts "RESULT: Scenario 6 Failed"
#else 
  #puts "RESULT: Scenario 6 Passed"
#end
sleep 5
ie.goto url
puts ">>>>Scenario 8: Telephone number is left blank>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(AMEX Card)"
ie.text_field(:name, "card[address1]").set("1915 I street")
ie.text_field(:name, "card[city]").set("Washington")
ie.text_field(:name, "card[state]").set("District of Columbia")
ie.text_field(:name, "card[postal]").set("20006")
ie.text_field(:name, "card[phone]").set("")
ie.text_field(:name, "card[number]").set("378282246310005")
ie.text_field(:name, "card[exp_month]").set("08")
ie.text_field(:name, "card[exp_year]").set("11")
ie.text_field(:name, "card[csc]").set("0719")
ie.checkbox(:name, "remember").clear
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 7
#if ie.div(:id, "donationErrors").include? 
  #puts "RESULT: Scenario 6 Failed"
#else 
  #puts "RESULT: Scenario 6 Passed"
#end
sleep 5
ie.goto url
puts ">>>>Scenario 8: International Address>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(AMEX Card)"
ie.text_field(:name, "card[address1]").set("18 A Akshaya Colony")
ie.text_field(:name, "card[city]").set("Chennai")
ie.text_field(:name, "card[state]").set("TamilNadu")
ie.text_field(:name, "card[postal]").set("600050")
ie.select_list(:name, "card[country]").select("India")
ie.text_field(:name, "card[phone]").set("+919840737455")
ie.text_field(:name, "card[number]").set("4111111111111111")
ie.text_field(:name, "card[exp_month]").set("08")
ie.text_field(:name, "card[exp_year]").set("11")
ie.text_field(:name, "card[csc]").set("071")
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 35
#if ie.text.include? "Thank you for your $55 gift to"
  #puts "Donation Successfull"
  #else
  #puts "Donation Unsuccessfull"
#end
sleep 5
ie.goto url
puts ">>>>Scenario 8: International Address but Country is Sweden>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(AMEX Card)"
ie.text_field(:name, "card[address1]").set("18 A Akshaya Colony")
ie.text_field(:name, "card[city]").set("Chennai")
ie.text_field(:name, "card[state]").set("TamilNadu")
ie.text_field(:name, "card[postal]").set("600050")
ie.select_list(:name, "card[country]").select("Sweden")
ie.text_field(:name, "card[phone]").set("+919840737455")
ie.text_field(:name, "card[number]").set("4111111111111111")
ie.text_field(:name, "card[exp_month]").set("08")
ie.text_field(:name, "card[exp_year]").set("11")
ie.text_field(:name, "card[csc]").set("071")
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 35
if ie.text.include? "Thank you for your $55 gift to"
  puts "Donation Successfull"
  else
  puts "Donation Unsuccessfull"
end
sleep 5
ie.goto url
puts ">>>>Scenario 8: Credit card number less than 16-digits>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(AMEX Card)"
ie.text_field(:name, "card[address1]").set("1915 I street")
ie.text_field(:name, "card[city]").set("Washington")
ie.text_field(:name, "card[state]").set("District of Columbia")
ie.text_field(:name, "card[postal]").set("20006")
ie.text_field(:name, "card[phone]").set("8063681580")
ie.text_field(:name, "card[number]").set("3782822463005")
ie.text_field(:name, "card[exp_month]").set("08")
ie.text_field(:name, "card[exp_year]").set("11")
ie.text_field(:name, "card[csc]").set("0719")
ie.checkbox(:name, "remember").clear
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 7
#if ie.div(:id, "donationErrors").include? 
 # puts "RESULT: Scenario 8 Failed"
#else 
  #puts "RESULT: Scenario 8 Passed"
#end
sleep 5
ie.goto url
puts ">>>>Scenario 9: Alphabets in credit card number>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(AMEX Card)"
ie.text_field(:name, "card[address1]").set("1915 I street")
ie.text_field(:name, "card[city]").set("Washington")
ie.text_field(:name, "card[state]").set("District of Columbia")
ie.text_field(:name, "card[postal]").set("20006")
ie.text_field(:name, "card[phone]").set("8063681580")
ie.text_field(:name, "card[number]").set("378282e46t10005")
ie.text_field(:name, "card[exp_month]").set("08")
ie.text_field(:name, "card[exp_year]").set("11")
ie.text_field(:name, "card[csc]").set("0719")
ie.checkbox(:name, "remember").clear
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 7
#if ie.div(:id, "donationErrors").include? 
  #puts "RESULT: Scenario 9 Failed"
#else 
  #puts "RESULT: Scenario 9 Passed"
#end
sleep 5
ie.goto url
puts ">>>>Scenario 10: Special Characters in credit card number>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(AMEX Card)"
ie.text_field(:name, "card[address1]").set("1915 I street")
ie.text_field(:name, "card[city]").set("Washington")
ie.text_field(:name, "card[state]").set("District of Columbia")
ie.text_field(:name, "card[postal]").set("20006")
ie.text_field(:name, "card[phone]").set("8063681580")
ie.text_field(:name, "card[number]").set("37#2822^6310$05")
ie.text_field(:name, "card[exp_month]").set("08")
ie.text_field(:name, "card[exp_year]").set("11")
ie.text_field(:name, "card[csc]").set("0719")
ie.checkbox(:name, "remember").clear
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 7
#if ie.div(:id, "donationErrors").include? 
  #puts "RESULT: Scenario 10 Failed"
#else 
  #puts "RESULT: Scenario 10 Passed"
#end
sleep 5
ie.goto url
puts ">>>>Scenario 11: Spaces and dashes in credit card number, strip the spaces and run the donation if all other info are correct>>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(AMEX Card)"
ie.text_field(:name, "card[address1]").set("1915 I street")
ie.text_field(:name, "card[city]").set("Washington")
ie.text_field(:name, "card[state]").set("District of Columbia")
ie.text_field(:name, "card[postal]").set("20006")
ie.text_field(:name, "card[phone]").set("8063681580")
ie.text_field(:name, "card[number]").set("3782 822463 10005")
ie.text_field(:name, "card[exp_month]").set("08")
ie.text_field(:name, "card[exp_year]").set("11")
ie.text_field(:name, "card[csc]").set("0719")
ie.checkbox(:name, "remember").clear
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 35
if ie.text.include? "Thank you for your gift to"
  puts "Donation Successfull"
  else
  puts "Donation Unsuccessfull"
end
sleep 5
ie.goto url
puts ">>>>Scenario 12: Periods in name of the card, strip the period and run the donation if all other info are correct>>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(AMEX Card)"
ie.text_field(:name, "card[name_on_card]").set("Brian T. Fujito")
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
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 35
if ie.text.include? "Thank you for your gift to"
  puts "Donation Successfull"
  else
  puts "Donation Unsuccessfull"
end
sleep 5
ie.goto url
puts ">>>>Scenario 13: Incorrect expiration year>>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(AMEX Card)"
ie.text_field(:name, "card[address1]").set("1915 I street")
ie.text_field(:name, "card[city]").set("Washington")
ie.text_field(:name, "card[state]").set("District of Columbia")
ie.text_field(:name, "card[postal]").set("20006")
ie.text_field(:name, "card[phone]").set("8063681580")
ie.text_field(:name, "card[number]").set("378282246310005")
ie.text_field(:name, "card[exp_month]").set("06")
ie.text_field(:name, "card[exp_year]").set("06")
ie.text_field(:name, "card[csc]").set("0719")
ie.checkbox(:name, "remember").clear
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 7
#if ie.div(:id, "donationErrors").include? 
  #puts "RESULT: Scenario 13 Failed"
#else 
  #puts "RESULT: Scenario 13 Passed"
#end
sleep 5
ie.goto url
puts ">>>>Scenario 14: CVV left blank>>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(AMEX Card)"
ie.text_field(:name, "card[address1]").set("1915 I street")
ie.text_field(:name, "card[city]").set("Washington")
ie.text_field(:name, "card[state]").set("District of Columbia")
ie.text_field(:name, "card[postal]").set("20006")
ie.text_field(:name, "card[phone]").set("8063681580")
ie.text_field(:name, "card[number]").set("378282246310005")
ie.text_field(:name, "card[exp_month]").set("08")
ie.text_field(:name, "card[exp_year]").set("11")
ie.text_field(:name, "card[csc]").set("")
ie.checkbox(:name, "remember").clear
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 7
#if ie.div(:id, "donationErrors").include? 
  #puts "RESULT: Scenario 14 Failed"
#else 
  #puts "RESULT: Scenario 14 Passed"
#end
sleep 5
ie.goto url
puts ">>>>Scenario 15: CVV is alphabets>>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(AMEX Card)"
ie.text_field(:name, "card[address1]").set("1915 I street")
ie.text_field(:name, "card[city]").set("Washington")
ie.text_field(:name, "card[state]").set("District of Columbia")
ie.text_field(:name, "card[postal]").set("20006")
ie.text_field(:name, "card[phone]").set("8063681580")
ie.text_field(:name, "card[number]").set("378282246310005")
ie.text_field(:name, "card[exp_month]").set("08")
ie.text_field(:name, "card[exp_year]").set("11")
ie.text_field(:name, "card[csc]").set("abc")
ie.checkbox(:name, "remember").clear
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 7
#if ie.div(:id, "donationErrors").include? 
  #puts "RESULT: Scenario 15 Failed"
#else 
  #puts "RESULT: Scenario 15 Passed"
#end
sleep 5
ie.goto url
puts ">>>>Scenario 16: AMEX Card and enters three digit CVV>>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(AMEX Card)"
ie.text_field(:name, "card[address1]").set("1915 I street")
ie.text_field(:name, "card[city]").set("Washington")
ie.text_field(:name, "card[state]").set("District of Columbia")
ie.text_field(:name, "card[postal]").set("20006")
ie.text_field(:name, "card[phone]").set("8063681580")
ie.text_field(:name, "card[number]").set("378282246310005")
ie.text_field(:name, "card[exp_month]").set("08")
ie.text_field(:name, "card[exp_year]").set("11")
ie.text_field(:name, "card[csc]").set("079")
ie.checkbox(:name, "remember").clear
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 7
#if ie.div(:id, "donationErrors").include? 
  #puts "RESULT: Scenario 16 Failed"
#else 
  #puts "RESULT: Scenario 16 Passed"
#end
sleep 5
ie.goto url
puts ">>>>Scenario 17: Visa Card and enters four digit CVV>>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(Visa Card)"
ie.text_field(:name, "card[address1]").set("1915 I street")
ie.text_field(:name, "card[city]").set("Washington")
ie.text_field(:name, "card[state]").set("District of Columbia")
ie.text_field(:name, "card[postal]").set("20006")
ie.text_field(:name, "card[phone]").set("8063681580")
ie.text_field(:name, "card[number]").set("4111111111111111")
ie.text_field(:name, "card[exp_month]").set("08")
ie.text_field(:name, "card[exp_year]").set("11")
ie.text_field(:name, "card[csc]").set("0719")
ie.checkbox(:name, "remember").clear
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 7
#if ie.div(:id, "donationErrors").include? 
  #puts "RESULT: Scenario 17 Failed"
#else 
  #puts "RESULT: Scenario 17 Passed"
#end
sleep 5
ie.goto url
puts ">>>>Scenario 18: Master Card and enters four digit CVV>>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(Master Card)"
ie.text_field(:name, "card[address1]").set("1915 I street")
ie.text_field(:name, "card[city]").set("Washington")
ie.text_field(:name, "card[state]").set("District of Columbia")
ie.text_field(:name, "card[postal]").set("20006")
ie.text_field(:name, "card[phone]").set("8063681580")
ie.text_field(:id, "card[number]").set("5555555555554444")
ie.text_field(:name, "card[exp_month]").set("08")
ie.text_field(:name, "card[exp_year]").set("11")
ie.text_field(:name, "card[csc]").set("0719")
ie.checkbox(:name, "remember").clear
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 7
#if ie.div(:id, "donationErrors").include? 
  #puts "RESULT: Scenario 18 Failed"
#else 
  #puts "RESULT: Scenario 18 Passed"
#end
sleep 5
ie.goto url
puts ">>>>Scenario 19: Selecting Recurring deposit and unchecking save the card for next use>>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.select_list(:name, "scheduled_donation[period]").select("Weekly")
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(Master Card)"
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
ie.checkbox(:id, "remember").click
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 7
#if ie.div(:id, "donationErrors").include? 
  #puts "RESULT: Scenario 19 Failed"
#else 
  #puts "RESULT: Scenario 19 Passed"
#end
sleep 5
ie.goto url
puts ">>>>Scenario 20: Selecting a card that is already saved and then make the donation>>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.div(:id, "card1104370").click
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 35
if ie.text.include? "Thank you for your gift to"
  puts "Donation Successfull"
  else
  puts "Donation Unsuccessfull"
end
sleep 5
ie.goto url
puts ">>>>Scenario 21: All the information given is correct>>>>>>>"
puts "Step 1: Clicking donate button"
ie.radio(:id, "customDonationLevel", "custom").set
ie.text_field(:id, "donation_amount").set("55")
ie.button(:id,"storyDonateButton").click
ie.div(:id, "newCard").click
puts "Step 2: Entering credit card information(Master Card)"
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
puts "Step 3: Click Donate Now button"
ie.image(:id,"donationSubmit").click
sleep 35
if ie.text.include? "Thank you for your $55 gift to"
  puts "Donation Successfull"
  else
  puts "Donation Unsuccessfull"
end
sleep 5
ie.goto url
ie.link(:text,"LOG OUT").click
puts "Testing done!"
puts "Closing the browser"
ie.close