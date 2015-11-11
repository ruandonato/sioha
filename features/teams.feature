Feature: Create a team

	Scenario: Fill all the correct fields

		The user fills in all fields correctly for create a new team

		Given that I'm a registered user
		Given I'm on the login page
		Given that I filled all fields correctly
		And clicked the button Save Session
		When I click the button Lista de Times
		And click the button Criar Time
		And fill in all fields correctly
		And click the button Criar Time again
		Then the team should be created