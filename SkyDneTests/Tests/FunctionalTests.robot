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

Verify response data has email address
    create session      session1  ${base_url}     disable_warnings=1
    ${endpoint}     set variable    /public/v2/users
    ${response}=     get on session      session1        ${endpoint}

    #Converting output to Json for extracting email
    ${json_response}=       set variable    ${base_url}     disable_warnings=1
    #log to console     {$json_response}
    ${email_data}=      get value from json     {json_response}     $[0].email
    log to console      ${email_data}

    #Validation to check if the email data is present
    should not be empty     ${email_data}

Verify all entries on list data have similar attributes
    create session      session1  ${base_url}     disable_warnings=1
    ${endpoint}     set variable    /public/v2/users
    ${response}=     get on session      session1        ${endpoint}

    #Converting output to json for extracting email
    ${json_response}=   set variable    ${response.json()}

    FOR ${item}     IN      @{json_response}
        dictionary should contain key   ${item}     id
        dictionary should contain key   ${item}     name
        dictionary should contain key   ${item}     email
        dictionary should contain key   ${item}     gender
     #   dictionary should contain key   ${item}     status
    END

