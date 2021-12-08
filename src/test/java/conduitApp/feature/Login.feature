Feature: Tests for login

  Background: Define URL
    Given url 'https://serverest.dev/'

  Scenario: Login into the application with right credentials
    Given path 'login'
    And request { "email": "fulano@qa.com", "password": "teste" }
    When method post
    Then status 200
    And print 'Response is: ', response

  Scenario: Login into the application with an invalid email
    Given path 'login'
    And request { "email": "fulanoqa.com", "password": "teste" }
    When method post
    Then status 400
    And print 'Response is: ', response

  Scenario: Login into the application with an incorrect email
    Given path 'Login'
    And request { "email": "fulano@qaqaqa.com.br", "password": "teste" }
    When method post
    Then status 401
    And print 'Response is: ', response

  Scenario: Login into the application with an incorrect password
    Given path 'login'
    And request { "email": "fulano@qa.com", "password": "testeqaqa" }
    When method post
    Then status 401
    And print 'Response is: ', response

  Scenario: Login into the application with both incorrect credentials
    Given path 'login'
    And request { "email": "fulanoqa@qaqaqa.com.br", "password": "teste123" }
    When method post
    Then status 401
    And print 'Response is: ', response

  Scenario: Login into the application without email
    Given path 'Login'
    And request { "email": "", "password": "teste" }
    When method post
    Then status 400
    And print 'Response is: ', response

  Scenario: Login into the application without password
    Given path 'Login'
    And request { "email": "fulano@qa.com", "password": "" }
    When method post
    Then status 400
    And print 'Response is: ', response

    Scenario: Login into the application with an incorrect email and with no password
      Given path 'Login'
      And request { "email": "fulaninho@qa.com", "password": "" }
      When method post
      Then status 400
      And print 'Response is: ', response