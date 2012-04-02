When /^I (?:go to|visit) the (.+) page$/ do |page_name|
    visit path_to(page_name)
end

Then /^I should be on the (.+) page$/ do |page_name|
    current_url.should == path_to(page_name)
end
