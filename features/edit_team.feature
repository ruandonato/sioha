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