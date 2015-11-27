Feature: Edit information of a team

	Scenario: Fill all the correct fields

		The user edit a team completing the fields correctly

		Given that I'm a registered user
		Given I'm logged
		Given I'm created a team
		When I click the link 'Seus Times'
		And click the name team
		And click the button 'Editar'
		And fill in the fields correctly
		And click the button 'Alterar Informações'
		Then the system should display a message 'Informações alteradas'



	Scenario: Fill the name field with a short name

		The user try to edit a team with the short name

		Given that I'm a registered user
		Given I'm logged
		Given I'm created a team
		When I click the link 'Seus Times'
		And click the name team
		And click the button 'Editar'
		And fill in the name team field with a short name
		And click the button 'Alterar Informações'
		Then the system should a message 'Name is too short (minimum is 6 characters)'

	Scenario: Fill the description field with a short description

		The user try to edit a team with the short description

		Given that I'm a registered user
		Given I'm logged
		Given I'm created a team
		When I click the link 'Seus Times'
		And click the name team
		And click the button 'Editar'
		And fill in the description field with a short description
		And click the button 'Alterar Informações'
		Then the system should a message 'Description is too short (minimum is 10 characters)'

