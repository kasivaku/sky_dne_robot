*** Settings ***
Documentation  To cover the functional test scenarios for APIS in https://gorest.co.in/

Library     RequestsLibrary
Library     Collections
Library     String
Library     JSONLibrary
Library     RequestsLibrary
Library     OperatingSystem
Library     jsonschema
Library     JsonValidator
Library     os

*** Variables ***
${base_url}     https://gorest.co.in/

*** Test Cases ***
Verify response codes
    create session      session1  ${base_url}     disable_warnings=1
    ${endpoint}     set variable    /public/v2/users
    ${response}=     get on session      session1        ${endpoint}
    log to console  ${response.status_code}

    #verify status codes
    should be true      '${response.status_code}'=='200'    or      '${response.status_code}'=='201'