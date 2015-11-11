Given(/^I'm on the home page$/) do
	visit '/'
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

Given(/^I'm on the signup page$/) do
	visit "/signup"
end

When(/^I complete all fields correctly$/) do

	fill_in "user_name", :with=> "Teste"
	fill_in 'user_email', :with=> "Teste@gmail.com"
	fill_in 'user_password', :with=> "Teste123"
	fill_in 'user_password_confirmation', :with=> "Teste123"
end

When(/^click the button Create User$/) do
	click_button 'Create User'
end

Then(/^I must be registered$/) do
	page.should have_content("Teste")
end

When(/^I fill in the email field with invalid data$/) do
	fill_in "user_name", :with=> "Teste"
	fill_in 'user_email', :with=> "InvalidEMAIL"
	fill_in 'user_password', :with=> "Teste123"
	fill_in 'user_password_confirmation', :with=> "Teste123"
end

Then(/^the system displays a message 'Email is invalid'$/) do
	page.should have_content("Email is invalid")
end

When(/^I fill in the password field with a short password$/) do
	fill_in "user_name", :with=> "Teste"
	fill_in 'user_email', :with=> "InvalidEMAIL"
	fill_in 'user_password', :with=> "short"
	fill_in 'user_password_confirmation', :with=> "short"
end

Then(/^the system displays a message 'Password is too short \(minimum is (\d+) characters\)'$/) do |arg1|
		page.should have_content("Password is too short (minimum is 6 characters)")
end
	
When(/^I did not fill the password field$/) do
	fill_in "user_name", :with=> "Teste"
	fill_in 'user_email', :with=> "InvalidEMAIL"
	fill_in 'user_password', :with=> ""
	fill_in 'user_password_confirmation', :with=> "short"
end

Then(/^the system displays a message 'Password can't be blank'$/) do
	page.should have_content("Password can't be blank")
end


When(/^I did not fill the password confirmation field equal to password field$/) do
	fill_in "user_name", :with=> "Teste"
	fill_in 'user_email', :with=> "InvalidEMAIL"
	fill_in 'user_password', :with=> "Teste1"
	fill_in 'user_password_confirmation', :with=> "Teste2"
end

Then(/^the system displays a message 'Password confirmation doesn't match Password'$/) do
	page.should have_content("Password confirmation doesn't match Password")
end

Given(/^that I'm a registered user$/) do
	@user = User.new;
	@user.email = 'rhianna@bruen.org'
	@user.password = 'Teste123'
	@user.password_confirmation = 'Teste123'

	@user.save
end

Given(/^I'm on the login page$/) do
	visit '/signin'
end

When(/^I fill in the fields with the registered data$/) do
	fill_in 'session_email', :with=> "rhianna@bruen.org"
	fill_in 'session_password', :with=> "Teste123"
end

When(/^click te button Save Session$/) do
	click_button 'Save Session'
end

Then(/^I'm logged in$/) do
	page.should have_content ("Seus Times")
end

When(/^I fill the fields with unregistered data$/) do
	fill_in 'session_email', :with=> "unregisteredData@teste.com"
	fill_in 'session_password', :with=> "Invalid"
end

Then(/^the system should displays a message 'Invalid Combination'$/) do
	page.should have_content ("Invalid combination.")
end

When(/^I click the button Lista de Times$/) do
	click_link 'Lista de Times'
end

When(/^click the button Criar Time$/) do
	click_link 'Criar Time'
end

When(/^fill in all fields correctly$/) do
		fill_in 'team_name', :with=> "TeamTeste"
		fill_in 'team_description', :with=> "Time feito para teste"
		fill_in 'team_email', :with=> "Teste@teste.com"
		page.find(:radio_button, 'team_public_to_members_true').set(true)
		page.find(:radio_button, 'team_methodology_safe').set(true)

end

Then(/^the team should be created$/) do
	page.should have_content("Owner")
end

Given(/^that I filled all fields correctly$/) do
	fill_in 'session_email', :with=> "rhianna@bruen.org"
	fill_in 'session_password', :with=> "Teste123"
end

Given(/^clicked the button Save Session$/) do
	click_button 'Save Session'
end

When(/^click the button Criar Time again$/) do
	click_button 'Criar Time'
end








