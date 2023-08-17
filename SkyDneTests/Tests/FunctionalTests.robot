*** Settings ***
Documentation  To cover the functional test scenarios for APIS in https://gorest.co.in/

Library     RequestsLibrary

*** Variables ***

${base_url}     https://gorest.co.in/

*** Test Cases ***

Verify response has Pagination
    create session      session1  ${base_url}     disable_warnings=1
    ${endpoint}     set variable    /public/v2/users
    ${response}=     get on session      session1        ${endpoint}
    log to console  ${response.headers}
    log to console  ${response.status_code}
    log to console  ${response.content}
    log     ${response.content}

    #Status code check
    ${status_code}=     convert to string   ${response.status_code}
    should be equal     ${status_code}      200

    #Check if response header has Pagination Value
    ${header_value}=    get from dictionary     ${response.headers}     X-Pagination-Page
    should not be empty     ${header_value}

Verify valid json data
    create session      session1  ${base_url}     disable_warnings=1
    ${endpoint}     set variable    /public/v2/users
    ${response}=     get on session      session1        ${endpoint}
    log to console  ${response.headers}
    log     ${response.headers}

    ${header_value}=    get from dictionary     ${response.headers}     Content-Type
    should contain      ${header_value}     json

