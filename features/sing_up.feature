Feature: Sign up an user

	Scenario: Fill all the correct fields

		The user fills in all fields correctly

		Given I'm on the signup page
		When I complete all fields correctly
		And click the button Create User
		Then I must be registered

	Scenario: Fill in the email field with invalid data

		The user fills in the email field with invalid data, and the rest of the fields correctly

		Given I'm on the signup page
		When I fill in the email field with invalid data
		And click the button Create User
		Then the system displays a message 'Email is invalid'

	Scenario: Fill in the password field with a short Password

		The user fills in the password field with a short password, and the rest of the fields correctly

		Given I'm on the signup page
		When I fill in the password field with a short password
		And click the button Create User
		Then the system displays a message 'Password is too short (minimum is 6 characters)'

	Scenario: Not fill the password field

		The user doesn't fills the password field, and fills the rest of the fields correctly

		Given I'm on the signup page
		When I did not fill the password field
		And click the button Create User
		Then the system displays a message 'Password can't be blank'

	Scenario: Not fill the password confirmation field equal to password field

		Given I'm on the signup page
		When I did not fill the password confirmation field equal to password field
		And click the button Create User
		Then the system displays a message 'Password confirmation doesn't match Password'