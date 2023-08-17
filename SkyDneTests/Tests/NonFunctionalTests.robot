*** Settings ***
Documentation  To cover the Non functional test scenarios for APIS in https://gorest.co.in/

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
${non_ssl_base_url}     http://gorest.co.in/

*** Test Cases ***
Verify response codes
    create session      session1  ${base_url}     disable_warnings=1
    ${endpoint}     set variable    /public/v2/users
    ${response}=     get on session      session1        ${endpoint}
    log to console  ${response.status_code}

    #verify status codes
    should be true      '${response.status_code}'=='200'    or      '${response.status_code}'=='201'

Verify rest service without Authentication
    create session      session1  ${base_url}     disable_warnings=1
    ${endpoint}     set variable    /public/v2/users
    ${body}=    create dictionary   name=test1  email=test1@test.com    gender=mail status=active
    ${header}=  create dictionary   Content-Type=application/json
    ${response}=    post on session     session1    ${endpoint}     data=${body}    headers=${header}
    ${code}=    convert to string   ${response.status_code}
    should be equal     ${code}     401

verify non ssl behaviour
    create session      session1    ${non_ssl_base_url}
    ${endpoint}     set variable    /public/v1/users
    ${response}=     get on session      session1        ${endpoint}    verify=${True}
    log to console      ${response.content}


