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

	Scenario: Try to access the list of teams without being logged in

		The user try to access the list of teams without being logged in

		Given I'm on the home page
		When I click the button Lista de Times
		Then the system should dysplay a message 'Esta ação requer que o usuário esteja logado.'


	Scenario: Fill in the name field with a short name

		The user fills in the name field with a short name, and the rest of the fields correctly

		Given that I'm a registered user
		Given I'm on the login page
		Given that I filled all fields correctly
		And clicked the button Save Session
		When I click the button Lista de Times
		And click the button Criar Time
		And fill in the name field with a short name
		And click the button Criar Time again
		Then the system should display a message 'Name is too short (minimum is 6 characters)'


	Scenario: Fill in the description field with a short description

		The user fills in the description field with a short description, and the rest of the fields correctly

		Given that I'm a registered user
		Given I'm on the login page
		Given that I filled all fields correctly
		And clicked the button Save Session
		When I click the button Lista de Times
		And click the button Criar Time
		And fill in the description field with a description name
		And click the button Criar Time again
		Then the system should display a message 'Description is too short (minimum is 10 characters)'
