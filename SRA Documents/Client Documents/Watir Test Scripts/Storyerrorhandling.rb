require "firewatir"
include FireWatir
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
ff.link(:text,"LOG IN").click
puts "Step 2: Entering user credentials to log in"
ff.text_field(:id, "session_username").set("your user name")
ff.text_field(:id, "session_password").set("your pwd") 
ff.button(:value,"Log In").click
if ff.text.include? "Profile"
  puts "Step 2 Passed"
  else
  puts "Step 2 Failed"
end
puts "Step 2: Searching for Harvard College"
ff.link(:text,"BROWSE").click
ff.text_field(:id, "parametricKeyword").set("Hahvad College")
sleep 4
ff.link(:text,"Hahvad College").click
if ff.text.include? "Hahvad"
  puts "NPO Page Reached"
else
  puts "Error in reaching NPO Page"
end
puts "Step 3: Create FR"
ff.button(:id, "storyFundraiseButton").click
sleep 2
puts "<<<<<<<<Story Page Error Handling Scenarios>>>>>>>>>>>>>"
puts "Scenario 1. title, summary and video missing"
ff.text_field(:id, "story_title").set("")
ff.text_field(:id, "story_blurb").set("")
ff.text_field(:id, "story_story").set("I am going to tell the story")
ff.radio(:id, "videoBox", "Video").set
ff.text_field(:id, "youtubeField").set("")
ff.text_field(:id, "story_designation").set("Havard College")
ff.text_field(:name, "level_amount[0]").set("10")
ff.text_field(:name, "level_description[0]").set("Books")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[1]").set("20")
ff.text_field(:name, "level_description[1]").set("Furniture")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[2]").set("30")
ff.text_field(:name, "level_description[2]").set("Others")
ff.text_field(:name, "story[goal]").set("300")
ff.text_field(:id, "story_end_date").set("October 30, 2009")
ff.button(:value,"Create Fundraiser").click
if ff.text.include? "Please fix the following errors and try again"
  puts "Scenario 1 Failed"
else
  puts "Scenario 1 Passed"
end
sleep 15
puts "Scenario 2. title missing"
ff.text_field(:id, "story_title").set("")
ff.text_field(:id, "story_blurb").set("This is the summary")
ff.text_field(:id, "story_story").set("I am going to tell the story")
ff.radio(:id, "videoBox", "Video").set
ff.text_field(:id, "youtubeField").set("http://www.youtube.com/watch?v=AP5VIhbJwFs")
ff.text_field(:id, "story_designation").set("Havard College")
ff.text_field(:name, "level_amount[0]").set("10")
ff.text_field(:name, "level_description[0]").set("Books")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[1]").set("20")
ff.text_field(:name, "level_description[1]").set("Furniture")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[2]").set("30")
ff.text_field(:name, "level_description[2]").set("Others")
ff.text_field(:name, "story[goal]").set("300")
ff.text_field(:id, "story_end_date").set("October 30, 2009")
ff.button(:value,"Create Fundraiser").click
if ff.text.include? "Please fix the following errors and try again"
  puts "Scenario 2 Failed"
else
  puts "Scenario 2 Passed"
end
sleep 15
puts "Scenario 3. summary missing"
ff.text_field(:id, "story_title").set("Test Page")
ff.text_field(:id, "story_blurb").set("")
ff.text_field(:id, "story_story").set("I am going to tell the story")
ff.radio(:id, "videoBox", "Video").set
ff.text_field(:id, "youtubeField").set("http://www.youtube.com/watch?v=AP5VIhbJwFs")
ff.text_field(:id, "story_designation").set("Havard College")
ff.text_field(:name, "level_amount[0]").set("10")
ff.text_field(:name, "level_description[0]").set("Books")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[1]").set("20")
ff.text_field(:name, "level_description[1]").set("Furniture")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[2]").set("30")
ff.text_field(:name, "level_description[2]").set("Others")
ff.text_field(:name, "story[goal]").set("300")
ff.text_field(:id, "story_end_date").set("October 30, 2009")
ff.button(:value,"Create Fundraiser").click
if ff.text.include? "Please fix the following errors and try again"
  puts "Scenario 3 Failed"
else
  puts "Scenario 3 Passed"
end  
sleep 15
puts "Scenario 4. youtube link missing"
ff.text_field(:id, "story_title").set("Test Page")
ff.text_field(:id, "story_blurb").set("This is the summary")
ff.text_field(:id, "story_story").set("I am going to tell the story")
ff.radio(:id, "videoBox", "Video").set
ff.text_field(:id, "youtubeField").set("")
ff.text_field(:id, "story_designation").set("Harvard College")
ff.text_field(:name, "level_amount[0]").set("10")
ff.text_field(:name, "level_description[0]").set("Books")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[1]").set("20")
ff.text_field(:name, "level_description[1]").set("Furniture")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[2]").set("30")
ff.text_field(:name, "level_description[2]").set("Others")
ff.text_field(:name, "story[goal]").set("300")
ff.text_field(:id, "story_end_date").set("October 30, 2009")
ff.button(:value,"Create Fundraiser").click
if ff.text.include? "Please fix the following errors and try again"
  puts "Scenario 4 Failed"
else
  puts "Scenario 4 Passed"
end
sleep 15
puts "Scenario 5. donation amount contain alphabets"
ff.text_field(:id, "story_title").set("Test Page")
ff.text_field(:id, "story_blurb").set("This is the summary")
ff.text_field(:id, "story_story").set("I am going to tell the story")
ff.radio(:id, "videoBox", "Video").set
ff.text_field(:id, "youtubeField").set("http://www.youtube.com/watch?v=AP5VIhbJwFs")
ff.text_field(:id, "story_designation").set("Harvard College")
ff.text_field(:name, "level_amount[0]").set("abc")
ff.text_field(:name, "level_description[0]").set("Books")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[1]").set("bce")
ff.text_field(:name, "level_description[1]").set("Furniture")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[2]").set("cde")
ff.text_field(:name, "level_description[2]").set("Others")
ff.text_field(:name, "story[goal]").set("300")
ff.text_field(:id, "story_end_date").set("October 31, 2009")
ff.button(:value,"Create Fundraiser").click
if ff.text.include? "Please fix the following errors and try again"
  puts "Scenario 5 Failed"
else
  puts "Scenario 5 Passed"
end
sleep 15
puts "Scenario 6. Campaign end date - past date"
ff.text_field(:id, "story_title").set("Test Page")
ff.text_field(:id, "story_blurb").set("This is the summary")
ff.text_field(:id, "story_story").set("I am going to tell the story")
ff.radio(:id, "videoBox", "Video").set
ff.text_field(:id, "youtubeField").set("http://www.youtube.com/watch?v=AP5VIhbJwFs")
ff.text_field(:id, "story_designation").set("Harvard College")
ff.text_field(:name, "level_amount[0]").set("10")
ff.text_field(:name, "level_description[0]").set("Books")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[1]").set("20")
ff.text_field(:name, "level_description[1]").set("Furniture")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[2]").set("30")
ff.text_field(:name, "level_description[2]").set("Others")
ff.text_field(:name, "story[goal]").set("300")
ff.text_field(:id, "story_end_date").set("October 10, 2009")
ff.button(:value,"Create Fundraiser").click
if ff.text.include? "Please fix the following errors and try again"
  puts "Scenario 6 Failed"
else
 puts "Scenario 6 Passed"
end
sleep 15
 puts "Scenario 7. Exceed number of characters in summary field and story field"
ff.text_field(:id, "story_title").set("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer in nullam.")
ff.text_field(:id, "story_blurb").set("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec in enim augue, vulputate malesuada nibh. Aliquam ac sapien sit amet volutpat.")
ff.text_field(:id, "story_story").set("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis sed mauris nibh. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Etiam ullamcorper mi eget lacus elementum elementum ut nec massa. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; In hac habitasse platea dictumst. Fusce feugiat erat sit amet risus blandit feugiat. In id turpis ut purus imperdiet mattis. Duis vitae viverra eros. In porta eleifend nibh, a tincidunt dui elementum nec. Suspendisse nec ante et risus accumsan commodo quis id mi. In ac elit id sapien tristique vehicula et non dolor. Sed accumsan sem quis odio laoreet auctor. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aliquam adipiscing, magna ac commodo dapibus, elit ipsum eleifend purus, sit amet interdum leo metus nec purus. Donec ligula mauris, placerat a consectetur posuere, convallis et tellus. Vivamus ac quam non ipsum fringilla pharetra ut vel nibh. In hac habitasse platea dictumst. Ut est lorem, commodo quis faucibus id, placerat quis ligula. Curabitur purus nunc, dignissim quis feugiat ornare, volutpat nec dolor.

Donec fringilla venenatis orci, id congue massa feugiat quis. Nunc cursus mi non libero imperdiet mollis. Nam in eros et nibh venenatis pharetra et a metus. Ut lectus felis, tempor sit amet hendrerit non, vulputate quis lectus. Proin placerat imperdiet metus sed feugiat. Mauris non nulla sit amet ligula aliquam tempor. Praesent bibendum est quis arcu iaculis egestas. Nulla malesuada, justo vitae vulputate ullamcorper, dui nunc pulvinar dui, vitae viverra neque libero vitae mauris. Sed ut sem et turpis suscipit mattis ut vel tellus. Nulla ac orci id massa tempor venenatis eu vel urna. Etiam sed tellus nulla, quis aliquet ligula. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin condimentum scelerisque sagittis. Aliquam eu quam tellus. Nunc varius libero id augue imperdiet imperdiet ac sed diam. Sed ac elit libero, eget consectetur quam. Donec a consequat diam.

Curabitur ut metus vitae quam faucibus vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nullam in arcu est, ut tempor ipsum. In hac habitasse platea dictumst. Morbi viverra, mauris quis scelerisque interdum, elit orci commodo metus, eu vulputate arcu metus vitae quam. Sed auctor aliquet est, ac tristique massa aliquam eu. Vivamus auctor metus ultricies justo malesuada egestas. Nunc posuere urna eget odio scelerisque et egestas metus imperdiet. Vestibulum vitae eros felis. Pellentesque mi sapien, feugiat vitae auctor vulputate, eleifend vitae massa. Vivamus ac neque ac sapien volutpat commodo eu vel magna. Aliquam sem massa, molestie pellentesque imperdiet et, condimentum vel tellus. Quisque mattis euismod sapien, et pulvinar leo pulvinar eu. Sed adipiscing dolor sed tellus interdum volutpat. Pellentesque et mi id lorem fermentum lacinia eget in dui.

In in lacus feugiat nulla imperdiet laoreet. Integer vehicula risus et massa accumsan placerat. Sed nec odio dui, ac condimentum urna. Proin porta tortor dictum velit laoreet ullamcorper. Sed congue quam ac quam blandit nec laoreet arcu tincidunt. Phasellus nec odio felis, in congue turpis. In hac habitasse platea dictumst. Nulla eu commodo lacus. In malesuada lobortis erat, id consequat metus rutrum non. Nunc euismod imperdiet pellentesque. Aliquam erat volutpat. Ut eu leo in enim facilisis consectetur. Integer blandit hendrerit metus, non euismod ante varius gravida. Morbi nisi tellus, luctus vitae sagittis sed, cursus at nulla. Donec quis felis elit.

Praesent quis felis lacus, vel interdum quam. Nunc at nisi ac libero mattis rutrum a id nunc. Vestibulum ligula elit, fringilla id facilisis in, malesuada at lorem. Aliquam erat volutpat. Suspendisse eu sapien et risus eleifend scelerisque. Nulla a elit purus, sit amet posuere mi. Quisque eget nisi eget odio laoreet lobortis sed sed ipsum. Suspendisse a nunc vitae lorem interdum tempus. In aliquet vulputate feugiat. Suspendisse potenti. Phasellus fringilla pretium eleifend. Sed sed mi vitae ipsum egestas consequat. Nam in pharetra sapien.

Cras id sem eget elit convallis congue auctor et diam. Aenean ut diam eu mi pharetra rhoncus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Proin dolor neque, blandit vel facilisis eu, ornare vehicula orci. Pellentesque sem risus, ultrices sed ultricies ac, iaculis in libero. Vivamus eget lorem sem. Aliquam a lacus diam, id lacinia quam. Maecenas ac est eu justo condimentum rutrum vitae eget ante. Quisque congue eros sit amet dolor cursus sollicitudin. Cras id dolor augue, placerat gravida quam.

Suspendisse scelerisque tellus vehicula felis faucibus molestie. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Phasellus semper molestie consequat. Lorem ipsum dolor sit amet, consectetur adipiscing elit orci aliquam.")
ff.radio(:id, "videoBox", "Video").set
ff.text_field(:id, "youtubeField").set("http://www.youtube.com/watch?v=AP5VIhbJwFs")
ff.text_field(:id, "story_designation").set("Harvard College")
ff.text_field(:name, "level_amount[0]").set("10")
ff.text_field(:name, "level_description[0]").set("Books")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[1]").set("20")
ff.text_field(:name, "level_description[1]").set("Furniture")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[2]").set("30")
ff.text_field(:name, "level_description[2]").set("Others")
ff.text_field(:name, "story[goal]").set("300")
ff.text_field(:id, "story_end_date").set("October 30, 2009")
ff.button(:value,"Create Fundraiser").click
if ff.text.include? "Please fix the following errors and try again"
  puts "Scenario 7 Failed"
else
  puts "Scenario 7 Passed" 
end
sleep 15
puts "Scenario 8. other url other than youtube"
ff.text_field(:id, "story_title").set("Test Page")
ff.text_field(:id, "story_blurb").set("This is the summary")
ff.text_field(:id, "story_story").set("I am going to tell the story")
ff.radio(:id, "videoBox", "Video").set
ff.text_field(:id, "youtubeField").set("http://www.google.com")
ff.text_field(:id, "story_designation").set("Harvard College")
ff.text_field(:name, "level_amount[0]").set("10")
ff.text_field(:name, "level_description[0]").set("Books")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[1]").set("20")
ff.text_field(:name, "level_description[1]").set("Furniture")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[2]").set("30")
ff.text_field(:name, "level_description[2]").set("Others")
ff.text_field(:name, "story[goal]").set("300")
ff.text_field(:id, "story_end_date").set("October 30, 2009")
ff.button(:value,"Create Fundraiser").click
if ff.text.include? "Please fix the following errors and try again"
  puts "Scenario 8 Failed"
else
   puts "Scenario 8 Passed"
 end
 sleep 15
puts "Scenario 9. malformed youtube url"
ff.text_field(:id, "story_title").set("Test Page")
ff.text_field(:id, "story_blurb").set("This is the summary")
ff.text_field(:id, "story_story").set("I am going to tell the story")
ff.radio(:id, "videoBox", "Video").set
ff.text_field(:id, "youtubeField").set("http://www.youtube.com/watch?v=")
ff.text_field(:id, "story_designation").set("Harvard College")
ff.text_field(:name, "level_amount[0]").set("10")
ff.text_field(:name, "level_description[0]").set("Books")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[1]").set("20")
ff.text_field(:name, "level_description[1]").set("Furniture")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[2]").set("30")
ff.text_field(:name, "level_description[2]").set("Others")
ff.text_field(:name, "story[goal]").set("300")
ff.text_field(:id, "story_end_date").set("October 30, 2009")
ff.button(:value,"Create Fundraiser").click
if ff.text.include? "Please fix the following errors and try again"
  puts "Scenario 9 Failed"
else
 puts "Scenario 9 Passed"
end
sleep 15
puts "Scenario 10. donation amount contain special characters"
ff.text_field(:id, "story_title").set("Test Page")
ff.text_field(:id, "story_blurb").set("This is the summary")
ff.text_field(:id, "story_story").set("I am going to tell the story")
ff.radio(:id, "videoBox", "Video").set
ff.text_field(:id, "youtubeField").set("http://www.youtube.com/watch?v=AP5VIhbJwFs")
ff.text_field(:id, "story_designation").set("Harvard College")
ff.text_field(:name, "level_amount[0]").set("43$")
ff.text_field(:name, "level_description[0]").set("Books")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[1]").set("$%d4")
ff.text_field(:name, "level_description[1]").set("Furniture")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[2]").set("$$$")
ff.text_field(:name, "level_description[2]").set("Others")
ff.text_field(:name, "story[goal]").set("300")
ff.text_field(:id, "story_end_date").set("October 31, 2009")
ff.button(:value,"Create Fundraiser").click
if ff.text.include? "Please fix the following errors and try again"
  puts "Scenario 10 Failed"
else
  puts "Scenario 10 Passed"
end
sleep 15
puts "Scenario 11. donation amount specified but desc missed"
ff.text_field(:id, "story_title").set("Test Page")
ff.text_field(:id, "story_blurb").set("This is the summary")
ff.text_field(:id, "story_story").set("I am going to tell the story")
ff.radio(:id, "videoBox", "Video").set
ff.text_field(:id, "youtubeField").set("http://www.youtube.com/watch?v=AP5VIhbJwFs")
ff.text_field(:id, "story_designation").set("Havard College")
ff.text_field(:name, "level_amount[0]").set("10")
ff.text_field(:name, "level_description[0]").set("")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[1]").set("20")
ff.text_field(:name, "level_description[1]").set("")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[2]").set("30")
ff.text_field(:name, "level_description[2]").set("")
ff.text_field(:name, "story[goal]").set("300")
ff.text_field(:id, "story_end_date").set("October 30, 2009")
ff.button(:value,"Create Fundraiser").click
if ff.text.include? "Please fix the following errors and try again"
  puts "Scenario 11 Failed"
else
  puts "Scenario 11 Passed"
end
sleep 15
puts "Scenario 12. donation goal contains alphabets"
ff.text_field(:id, "story_title").set("Test Page")
ff.text_field(:id, "story_blurb").set("This is the summary")
ff.text_field(:id, "story_story").set("I am going to tell the story")
ff.radio(:id, "videoBox", "Video").set
ff.text_field(:id, "youtubeField").set("http://www.youtube.com/watch?v=AP5VIhbJwFs")
ff.text_field(:id, "story_designation").set("Havard College")
ff.text_field(:name, "level_amount[0]").set("10")
ff.text_field(:name, "level_description[0]").set("dfg")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[1]").set("20")
ff.text_field(:name, "level_description[1]").set("sdf")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[2]").set("30")
ff.text_field(:name, "level_description[2]").set("scf")
ff.text_field(:name, "story[goal]").set("abc")
ff.text_field(:id, "story_end_date").set("October 30, 2009")
ff.button(:value,"Create Fundraiser").click
if ff.text.include? "Please fix the following errors and try again"
  puts "Scenario 12 Failed"
else
  puts "Scenario 12 Passed"
end
sleep 15
puts "Scenario 13. donation goal contains special characters"
ff.text_field(:id, "story_title").set("Test Page")
ff.text_field(:id, "story_blurb").set("This is the summary")
ff.text_field(:id, "story_story").set("I am going to tell the story")
ff.radio(:id, "videoBox", "Video").set
ff.text_field(:id, "youtubeField").set("http://www.youtube.com/watch?v=AP5VIhbJwFs")
ff.text_field(:id, "story_designation").set("Havard College")
ff.text_field(:name, "level_amount[0]").set("10")
ff.text_field(:name, "level_description[0]").set("dfg")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[1]").set("20")
ff.text_field(:name, "level_description[1]").set("sdf")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[2]").set("30")
ff.text_field(:name, "level_description[2]").set("scf")
ff.text_field(:name, "story[goal]").set("$$$")
ff.text_field(:id, "story_end_date").set("October 30, 2009")
ff.button(:value,"Create Fundraiser").click
if ff.text.include? "Please fix the following errors and try again"
  puts "Scenario 13 Failed"
else
  puts "Scenario 13 Passed"
end
sleep 15
puts "Scenario 14. donation desc is the same for all the three amt specified"
ff.text_field(:id, "story_title").set("Test Page")
ff.text_field(:id, "story_blurb").set("This is the summary")
ff.text_field(:id, "story_story").set("I am going to tell the story")
ff.radio(:id, "videoBox", "Video").set
ff.text_field(:id, "youtubeField").set("http://www.youtube.com/watch?v=AP5VIhbJwFs")
ff.text_field(:id, "story_designation").set("Havard College")
ff.text_field(:name, "level_amount[0]").set("10")
ff.text_field(:name, "level_description[0]").set("dfg")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[1]").set("20")
ff.text_field(:name, "level_description[1]").set("dfg")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[2]").set("30")
ff.text_field(:name, "level_description[2]").set("dfg")
ff.text_field(:name, "story[goal]").set("300")
ff.text_field(:id, "story_end_date").set("October 30, 2009")
ff.button(:value,"Create Fundraiser").click
if ff.text.include? "Please fix the following errors and try again"
  puts "Scenario 14 Failed"
else
  puts "Scenario 14 Passed"
end
sleep 15
ff.link(:text,"Edit Page").click
puts "Scenario 14. To check the layout if title, designation, summary and story (max limit)"
ff.text_field(:id, "story_title").set("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer in nullam.")
ff.text_field(:id, "story_blurb").set("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec in enim augue, vulputate malesuada nibh. Aliquam ac sapien sit amet volutpat.")
ff.text_field(:id, "story_story").set("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis sed mauris nibh. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Etiam ullamcorper mi eget lacus elementum elementum ut nec massa. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; In hac habitasse platea dictumst. Fusce feugiat erat sit amet risus blandit feugiat. In id turpis ut purus imperdiet mattis. Duis vitae viverra eros. In porta eleifend nibh, a tincidunt dui elementum nec. Suspendisse nec ante et risus accumsan commodo quis id mi. In ac elit id sapien tristique vehicula et non dolor. Sed accumsan sem quis odio laoreet auctor. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aliquam adipiscing, magna ac commodo dapibus, elit ipsum eleifend purus, sit amet interdum leo metus nec purus. Donec ligula mauris, placerat a consectetur posuere, convallis et tellus. Vivamus ac quam non ipsum fringilla pharetra ut vel nibh. In hac habitasse platea dictumst. Ut est lorem, commodo quis faucibus id, placerat quis ligula. Curabitur purus nunc, dignissim quis feugiat ornare, volutpat nec dolor.

Donec fringilla venenatis orci, id congue massa feugiat quis. Nunc cursus mi non libero imperdiet mollis. Nam in eros et nibh venenatis pharetra et a metus. Ut lectus felis, tempor sit amet hendrerit non, vulputate quis lectus. Proin placerat imperdiet metus sed feugiat. Mauris non nulla sit amet ligula aliquam tempor. Praesent bibendum est quis arcu iaculis egestas. Nulla malesuada, justo vitae vulputate ullamcorper, dui nunc pulvinar dui, vitae viverra neque libero vitae mauris. Sed ut sem et turpis suscipit mattis ut vel tellus. Nulla ac orci id massa tempor venenatis eu vel urna. Etiam sed tellus nulla, quis aliquet ligula. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin condimentum scelerisque sagittis. Aliquam eu quam tellus. Nunc varius libero id augue imperdiet imperdiet ac sed diam. Sed ac elit libero, eget consectetur quam. Donec a consequat diam.

Curabitur ut metus vitae quam faucibus vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nullam in arcu est, ut tempor ipsum. In hac habitasse platea dictumst. Morbi viverra, mauris quis scelerisque interdum, elit orci commodo metus, eu vulputate arcu metus vitae quam. Sed auctor aliquet est, ac tristique massa aliquam eu. Vivamus auctor metus ultricies justo malesuada egestas. Nunc posuere urna eget odio scelerisque et egestas metus imperdiet. Vestibulum vitae eros felis. Pellentesque mi sapien, feugiat vitae auctor vulputate, eleifend vitae massa. Vivamus ac neque ac sapien volutpat commodo eu vel magna. Aliquam sem massa, molestie pellentesque imperdiet et, condimentum vel tellus. Quisque mattis euismod sapien, et pulvinar leo pulvinar eu. Sed adipiscing dolor sed tellus interdum volutpat. Pellentesque et mi id lorem fermentum lacinia eget in dui.

In in lacus feugiat nulla imperdiet laoreet. Integer vehicula risus et massa accumsan placerat. Sed nec odio dui, ac condimentum urna. Proin porta tortor dictum velit laoreet ullamcorper. Sed congue quam ac quam blandit nec laoreet arcu tincidunt. Phasellus nec odio felis, in congue turpis. In hac habitasse platea dictumst. Nulla eu commodo lacus. In malesuada lobortis erat, id consequat metus rutrum non. Nunc euismod imperdiet pellentesque. Aliquam erat volutpat. Ut eu leo in enim facilisis consectetur. Integer blandit hendrerit metus, non euismod ante varius gravida. Morbi nisi tellus, luctus vitae sagittis sed, cursus at nulla. Donec quis felis elit.

Praesent quis felis lacus, vel interdum quam. Nunc at nisi ac libero mattis rutrum a id nunc. Vestibulum ligula elit, fringilla id facilisis in, malesuada at lorem. Aliquam erat volutpat. Suspendisse eu sapien et risus eleifend scelerisque. Nulla a elit purus, sit amet posuere mi. Quisque eget nisi eget odio laoreet lobortis sed sed ipsum. Suspendisse a nunc vitae lorem interdum tempus. In aliquet vulputate feugiat. Suspendisse potenti. Phasellus fringilla pretium eleifend. Sed sed mi vitae ipsum egestas consequat. Nam in pharetra sapien.

Cras id sem eget elit convallis congue auctor et diam. Aenean ut diam eu mi pharetra rhoncus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Proin dolor neque, blandit vel facilisis eu, ornare vehicula orci. Pellentesque sem risus, ultrices sed ultricies ac, iaculis in libero. Vivamus eget lorem sem. Aliquam a lacus diam, id lacinia quam. Maecenas ac est eu justo condimentum rutrum vitae eget ante. Quisque congue eros sit amet dolor cursus sollicitudin. Cras id dolor augue, placerat gravida quam.

Suspendisse scelerisque tellus vehicula felis faucibus molestie. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Phasellus semper molestie consequat. Lorem ipsum dolor sit amet, consectetur adipiscing elit orci aliquam.")
ff.radio(:id, "videoBox", "Video").set
ff.text_field(:id, "youtubeField").set("http://www.youtube.com/watch?v=")
ff.text_field(:id, "story_designation").set("sjdfoqjewpofjewpojfreiwgoindskvneihgfiodnskvnoirehniogvnrojenfjnvoefnoivben")
ff.text_field(:name, "level_amount[0]").set("10")
ff.text_field(:name, "level_description[0]").set("Books")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[1]").set("20")
ff.text_field(:name, "level_description[1]").set("Furniture")
ff.link(:text, "add another amount").click
sleep 1
ff.text_field(:name, "level_amount[2]").set("30")
ff.text_field(:name, "level_description[2]").set("Others")
ff.text_field(:name, "story[goal]").set("300")
ff.text_field(:id, "story_end_date").set("October 30, 2009")
ff.button(:value,"Create Fundraiser").click
if ff.text.include? "Please fix the following errors and try again"
  puts "Scenario 14 Failed"
else
 puts "Scenario 14 Passed"
end





