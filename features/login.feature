Feature: Login an user

	Scenario: Log a registered user

		The user fills in all fields correctly with your data recorded

		Given that I'm a registered user
		Given I'm on the login page
		When I fill in the fields with the registered data 
		And click te button Save Session
		Then I'm logged in

	Scenario: Fill in the fields with unregistered data

		The user fills all fields with unregistered data

		Given I'm on the login page
		When I fill the fields with unregistered data
		And click te button Save Session
		Then the system should displays a message 'Invalid Combination'

