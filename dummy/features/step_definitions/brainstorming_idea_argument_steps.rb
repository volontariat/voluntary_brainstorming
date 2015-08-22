When /^I click the new argument link$/ do
  find(:xpath, '(//a[@class="new_brainstorming_idea_argument_link"])[1]').click
end

When /^I click the edit link of the first argument/ do
  find(:xpath, '(//a[@class="edit_brainstorming_idea_argument_link"])[1]').click
end

When /^I click the remove link of the first argument/ do
  find(:xpath, '(//a[@class="remove_brainstorming_idea_argument_link"])[1]').click
end