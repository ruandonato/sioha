Feature: Dealing Exception

	Scenario: Get a route invalidates

		The User attempts to access a route invalid, an exception should arise.

		Given I'm on the page '/'
		When the user enters an invalid url
		Then the system should display a page not found message

	Scenario: Access a user that doesn't exist in the database

		The user tries to access through URL a user that does not exist in the database, an exception should arise.

		Given I'm on the page '/'
		When the user tries to access a non-existent user in the database
		Then the sytem should dysplay that the data is missing

	Scenario: Acess a team that doesn't exist in the database

		The user tries to access through the url a team that does not exist in the database, an exception should arise.

		Given I'm on the page '/'
		When the user tries to acess a non-existente team in the database
		Then the sytem should dysplay that the data is missing

	Scenario: Acess a requirement tha doens't exist in the database

		The user tries to access through the url a requirement that does not exist in the database, an exception should arise.

		Given I'm on the page '/'
		When the user tries to acess a non-existente requirement in the database
		Then the sytem should dysplay that the data is missing

