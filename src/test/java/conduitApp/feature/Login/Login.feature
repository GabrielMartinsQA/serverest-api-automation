Feature: Tests for login

  Background: Define URL
    Given url 'https://serverest.dev/'
    * def data = read('classpath:conduitApp/feature/Login/Data/Data.yaml')

  Scenario: Login into the application with right credentials
    * def body = data.POST_LOGIN.positive.valid_login
    Given path 'login'
    And request body
    When method post
    Then status 200
    And print 'Response is: ', response

  Scenario Outline: Login into the application with an invalid email
    * def yaml = data.POST_LOGIN.negative
    * def body = yaml.<scenario>
    * def valid_response = yaml.<valid_status>
    Given path 'login'
    And request body
    When method post
    Then status <status_code>
    And match response == valid_response

    Examples:
      | scenario        | valid_status                   | status_code |
      | invalid_login   | valid_response_invalid_login   | 400         |
      | incorrect_login | valid_response_incorrect_login | 401         |

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