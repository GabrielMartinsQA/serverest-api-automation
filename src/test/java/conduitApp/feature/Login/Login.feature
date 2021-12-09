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

  Scenario Outline: Failure when logging into the application
    * def yaml = data.POST_LOGIN.negative
    * def body = yaml.<scenario>
    * def valid_response = yaml.<valid_status>
    Given path 'login'
    And request body
    When method post
    Then status <status_code>
    And match response == valid_response

  Examples:
    | scenario                         | valid_status                                    | status_code |
    | invalid_login                    | valid_response_invalid_login                    | 400         |
    | incorrect_login                  | valid_response_incorrect_login                  | 401         |
    | incorrect_credentials            | valid_response_incorrect_credentials            | 401         |
    | login_without_email              | valid_response_login_without_email              | 400         |
    | login_without_password           | valid_response_login_without_password           | 400         |
    | incorrect_email_without_password | valid_response_incorrect_email_without_password | 400         |