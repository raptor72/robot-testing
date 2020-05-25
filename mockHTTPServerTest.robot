*** Settings ***
Documentation       Test of POST request.
Library             Collections
Library             OperatingSystem
Library             RequestsLibrary
Library             HttpCtrl.Client
Library             HttpCtrl.Server

Test Setup          Initialize HTTP Client And Server
Test Teardown       Terminate HTTP Server


*** Test Cases ***
send POST and check response
    ${file}=    Get file    files/Score3.json
    ${json}=    Evaluate    json.loads("""${file}""")    json

#    ${send}=    Create Dictionary
#    Set To Dictionary    ${send}    RequestID     ${json[0]['RequestID']}
#    Set To Dictionary    ${send}    SearchType    ${json[0]['SearchType']}
#    Set To Dictionary    ${send}    Rate          ${json[0]['Rate']}
#    ${lst}=     Create List
#    Append To List       ${lst}     ${json[0]['CustomerCandidate'][0]}
#    Set To Dictionary    ${send}    CustomerCandidate    ${lst}
#    Log               ${send}

    &{headers}=       Create Dictionary    Content-Type=application/json
    Create Session    scoring-mock-server     http://127.0.0.1:8000
    ${resp}=          Post Request  scoring-mock-server    /method    data=${json}    headers=${headers}

    Log               ${resp}
    Log To Console    Printing resp.json()
    Log To Console    ${resp.json()}

    Request Should Be Successful         ${resp}
    Should Be Equal As Strings           ${resp.status_code}    200

    Should Be True     type(${resp.json()})     is dict
    Should Be True     len(${resp.json()})      > 1

#    Dictionary Should Contain Value    ${resp.json()}       200
#    Should Be Equal                         ${resp.json()['FaultMessage'][0]['Code']}    0
#    ${outer_text}=     Convert To String    ${resp.json()['FaultMessage'][0]['Text']}
#    Should Be Equal    ${outer_text}        None



*** Keywords ***
Initialize HTTP Client And Server
    Initialize Client   127.0.0.1   8000
    Start Server        127.0.0.1   8000

#    ${response file}=    Get file     files/Score3resp.json
#    ${response body}=    Evaluate     json.loads("""${response file}""")    json

    ${response body}=    Set Variable    {"code": 200, "response": {"score": 3.0}}

    Log To Console       ${response body}
    Reply By   200       ${response body}

Terminate HTTP Server
    Stop Server


