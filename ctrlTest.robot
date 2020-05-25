*** Settings ***

Library         HttpCtrl.Client
Library         HttpCtrl.Server

Test Setup       Initialize HTTP Client And Server
Test Teardown    Terminate HTTP Server


*** Test Cases ***
Receive And Reply To POST
    ${request body}=   Set Variable   { "message": "Hello!" }
    ${connection}=    Send HTTP Request Async   POST   /post   ${request body}

    Wait For Request
    Reply By   200

    ${method}=   Get Request Method
    ${url}=      Get Request Url
    ${body}=     Get Request Body


    ${response}=        Get Async Response        ${connection}   5
    ${response body}=   Get Body From Response    ${response}
    Log To Console    ${response body}

    Should Be Equal   ${method}   POST
    Should Be Equal   ${url}      /post
    Should Be Equal   ${body}     ${request body}

*** Keywords ***
Initialize HTTP Client And Server
    [Tags]              First
    Initialize Client   127.0.0.1   8000
    Start Server        127.0.0.1   8000

    ${response body}=   Set Variable   { "status": "accepted" }
    Reply By   200   ${response body}

Terminate HTTP Server
    Stop Server