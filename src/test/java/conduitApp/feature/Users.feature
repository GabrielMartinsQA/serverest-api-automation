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