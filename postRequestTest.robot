*** Settings ***
Documentation       Test of POST request.
Library             Collections
Library             OperatingSystem
Library             RequestsLibrary

*** Variables ***
${base_url}         http://localhost:8080

*** Test Cases ***
Проверить how to send POST
    Create Session    ScoringAPI     ${base_url}
    &{headers}=       Create Dictionary    Content-Type=application/json
    ${arguments}=     Evaluate    {"phone": "79177002040", "email": "ipetrov@gmail.com", "first_name": "Ivan", "birthday": "01.01.1990"}
    ${data}=    Create Dictionary
    Set To Dictionary    ${data}    account      horns&hoofs
    Set To Dictionary    ${data}    login        h&f
    Set To Dictionary    ${data}    method       online_score
    Set To Dictionary    ${data}    token        55cc9ce545bcd144300fe9efc28e65d415b923ebb6be1e19d2750a2c03e80dd209a27954dca045e5bb12418e7d89b6d718a9e35af34e14e1d5bcd5a08f21fc95
    Set To Dictionary    ${data}    arguments    ${arguments}
    Log To Console    ${data}
#    ${data} =    Evaluate    {"account": "horns&hoofs", "login": "h&f", "method": "online_score", "token": "55cc9ce545bcd144300fe9efc28e65d415b923ebb6be1e19d2750a2c03e80dd209a27954dca045e5bb12418e7d89b6d718a9e35af34e14e1d5bcd5a08f21fc95", "arguments": ${arguments}}
    Log               ${data}
    ${resp}=          Post Request  ScoringAPI  /method  data=${data}    headers=${headers}
    Log               ${resp}
    Log To Console    ${resp.content}
    Log To Console    ${resp.json()}
    Request Should Be Successful            ${resp}
    ${json_response}=  Convert To String    ${resp.status_code}
    Should Be True    type(${resp.content}) is dict
    Should Be Equal    ${json_response}     200
    ${json_dict}=  Convert To String    ${resp.content}
    Log To Console    ${json_dict}
#    Compare To Expected String    ${json_dict}    {'code': 200, 'response': {'score': 3.0}}
    Should Be Equal    ${json_dict}    {"code": 200, "response": {"score": 3.0}}
#    Dictionary Should Contain Value  ${resp.json()}       Maksim Tarasov
