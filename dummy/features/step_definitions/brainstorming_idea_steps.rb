When /^I click the new idea link$/ do
  find(:xpath, '(//a[@class="new_brainstorming_idea_link"])[1]').click
end

When /^I click the edit link of the first idea$/ do
  find(:xpath, '(//a[@class="edit_brainstorming_idea_link"])[1]').click
end

When /^I click the remove link of the first idea$/ do
  find(:xpath, '(//a[@class="remove_brainstorming_idea_link"])[1]').click
end