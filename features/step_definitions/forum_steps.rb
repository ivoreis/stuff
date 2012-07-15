def not_inside_forum
  visit "/"
end



Given /^I am not inside forum$/ do
  not_inside_forum
end

When /^I go to the forum path$/ do
  visit forum_rooms_path
end

Then /^I see the available rooms$/ do
  pending # express the regexp above with the code you wish you had
end
