Feature: Tests for users

  Background: Define URL
    Given url 'https://serverest.dev/'

  Scenario: Get all users
    Given path 'usuarios'
    When method get
    Then status 200
    And print 'Response is: ', response
    
  Scenario: Get user by id
    Given path 'usuarios'
    And params { "_id" : "0uxuPY0cbmQhpEz1" }
    When method get
    Then status 200
    And print 'Response is: ', response

  Scenario: get user by name
    Given path 'usuarios'
    And params { "nome" : "Dumb Joe" }
    When method get
    Then status 200
    And print 'Response: ', response

  Scenario: get user by email
    Given path 'usuarios'
    And params { "email" : "adanbui@uorak.com" }
    When method get
    Then status 200
    And print 'Response is: ', response

  Scenario: get user by password
    Given path 'usuarios'
    And params { "password" : "teste" }
    When method get
    Then status 200
    And print 'Response is: ', response

  Scenario: get user by administrator
    Given path 'usuarios'
    And params { "administrador" : "false" }
    When method get
    Then status 200
    And print 'Response is: ', response

  Scenario: get user by id with an incorrect id
    Given path 'usuarios'
    And params { "id" : "0uxuPY0cbmQhp" }
    When method get
    Then status 400
    And print 'Response is: ', response
    And match response == { "id" : "id não é permitido" }

  Scenario: get user by name with an incorrect name
    Given path 'usuarios'
    And params { "name" : "gabriel martins" }
    When method get
    Then status 400
    And print 'Response is: ', response
    And match response == { "name" : "name não é permitido" }

  Scenario: get user by email with an invalid email
    Given path 'usuarios'
    And params { "email" : "gabrielqa.tester.com.br" }
    When method get
    Then status 400
    And print 'Response is: ', response
    And match response == { "email" : "email deve ser um email válido" }