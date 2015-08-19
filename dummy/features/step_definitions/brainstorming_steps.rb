When /^delete the first brainstorming$/ do
  page.evaluate_script("$('.remove_brainstorming_link')[0].click();")
end
