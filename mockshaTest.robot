*** Settings ***
Documentation       Test of POST request.
Library             Collections
Library             OperatingSystem
Library             RequestsLibrary

*** Variables ***
${base_url}         http://localhost:8089

*** Test Cases ***
Проверить how to send POST
    Create Session    mocksha     ${base_url}
    &{headers}=       Create Dictionary    Content-Type=application/json
    ${file}=    Get file    files/strictMocksha1.json
    ${json}=     Evaluate     json.loads("""${file}""")    json

    ${resp}=          Post Request    mocksha    /many_people    data=${json}    headers=${headers}
    Log               ${resp}
    Log To Console    ${resp.content}
    Request Should Be Successful            ${resp}
    ${json_response}=  Convert To String    ${resp.status_code}
    Should Be True    type(${resp.content}) is dict
    Should Be Equal    ${json_response}     200
    ${json_dict}=  Convert To String    ${resp.content}
    Log To Console    ${json_dict}
#    Compare To Expected String    ${json_dict}    {'code': 200, 'response': {'score': 3.0}}
#    Should Be Equal    ${json_dict}    {"code": 200, "response": {"score": 3.0}}
#    Dictionary Should Contain Value  ${resp.json()}       Maksim Tarasov


For-Loop-In-Range
    FOR    ${INDEX}    IN RANGE    0    400
        Log To Console       ${INDEX}
        Create Session    mocksha     ${base_url}
        &{headers}=       Create Dictionary    Content-Type=application/json
        ${file}=    Get file    files/strictMocksha1.json
        ${json}=     Evaluate     json.loads("""${file}""")    json
        ${resp}=          Post Request    mocksha    /many_people    data=${json}    headers=${headers}
        Log To Console    ${resp.content}
        Request Should Be Successful            ${resp}
        ${json_response}=  Convert To String    ${resp.status_code}
        Should Be True    type(${resp.content}) is dict
        Should Be Equal    ${json_response}     200
    END