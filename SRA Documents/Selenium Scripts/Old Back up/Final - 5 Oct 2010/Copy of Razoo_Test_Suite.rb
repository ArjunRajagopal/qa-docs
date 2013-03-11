#-----------------------------------------------------------------------------#
# Driver.rb
#
# Author: EBI,SDR and SID
# Date: 4-OCT-2010
# Description:  Includes all the methods that are required to execute the test cases in IE.
#
# Change history:
#4-OCT-2010 - Initial Development
# 
#-----------------------------------------------------------------------------#
require "test/unit"
require "rubygems"
require "selenium/client"
require "Razoo_Test_Cases.rb"

#-------------------------------------------------------------#
#  RazooTestSuite Class
#
# Author: EBI,SDR and SID
# Date: 4-OCT-2010
# Description:  It is a Class which contains all the methods thats need to be Executed
#
# Change history:
# 4-OCT-2010 - Initial Development
# -------------------------------------------------------------#
class RazooTestSuite < Test::Unit::TestCase


#This method helps to invoke the Razoo Site
def test_00_setup_razoo()
	invokeRazooSite()	
end

#SCENARIO 1
#~ def test_01_guestuser_donation()
	#~ searchStory("Harvard College")
	#~ donationUsingNewCard("10", "Mr Oct5", "2nd Street", "Washington DC", 
			    #~ "Washington", "95008", "4111111111111111", "123", "GuestUser@aol.com",
			    #~ "Your donation was successful! We've sent you a confirmation email receipt.")
	#~ viewComments()
	#~ createRazooAccount("Mr", "Oct", "oct5@gmail.com", "123456")
	# puts "*****************END OF SCENARIO 1**********************"
#~ end
	
def test_02_normaluser_donation()
	login("oct5@aol.com", "123456")
	searchStory("Harvard College")
	createFundraise("Harvard College", "FR3 for Harvard College", "Summary Part ", "Story Part", 
	"http://www.youtube.com/watch?v=HNVSI_r9SVg" , "With Designation", "11", "Suggested Description",
	"100",  "link=31")
end
	
def test_03_scenario()
puts "Inside Scenario 3"
$browser.stop
#logout()
end

end
    
