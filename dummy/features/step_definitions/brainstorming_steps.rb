Given /^a brainstorming$/ do
  @brainstorming = FactoryGirl.create(:brainstorming, name: 'Dummy', user: @me)
end
  
When /^delete the first brainstorming$/ do
  find(:xpath, '(//a[@class="remove_brainstorming_link"])[1]').click
end