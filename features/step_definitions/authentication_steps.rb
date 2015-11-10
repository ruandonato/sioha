Given(/^I'm on the page '\/'$/) do
	visit "\/"
end

When(/^the user enters an invalid url$/) do
	visit '/invalidURL'
end

Then(/^the system should display a page not found message$/) do
	page.should have_content (404)
end

When(/^the user tries to access a non\-existent user in the database$/) do
	visit '/users/50000'
end

Then(/^the sytem should dysplay that the data is missing$/) do
	page.should have_content (500)
end

When(/^the user tries to acess a non\-existente team in the database$/) do
	visit '/teams/50000'
end

When(/^the user tries to acess a non\-existente requirement in the database$/) do
	visit 'requirements/500000'
end




