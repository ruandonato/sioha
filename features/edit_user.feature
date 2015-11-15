Feature: Edit a user profile

	Scenario: Fill all the correct fields

		The user edit your profile by filling out the fields properly

		Given that I'm a registered user
		Given I'm logged
		Given I'm on the page to edit my profile
		When I fill all the correct fields
		And click the button Alterar Informações
		Then the system should a message 'Informações alteradas!'


	Scenario: Fill the password field with a short password

		The user fills a password field with a short password

		Given that I'm a registered user
		Given I'm logged
		Given I'm on the page to edit my profile
		When I fill the password field with a short password
		And click the button Alterar Informações
		Then the system should a message 'Password is too short (minimum is 6 characters)'

	Scenario: Fill an email field with an invalid email

		The user fills an email field with an invalid email

		Given that I'm a registered user
		Given I'm logged
		Given I'm on the page to edit my profile
		When I fill an email field with an invalid email
		And click the button Alterar Informações
		Then the system should a message 'Email is invalid'
