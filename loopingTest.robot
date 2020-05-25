*** Settings ***
Documentation       Test of POST request.
Library             Collections
Library             String
Library             OperatingSystem
Library             RequestsLibrary

*** Variables ***
${base_url}         http://localhost:8080

*** Keywords ***
Create Json ${f}
    ${file}=     Get file    files/${f}
    ${json}=     Evaluate    json.loads("""${file}""")    json
    [Return]     ${json}

Create List Count ${c} from ${f}
    ${file}=     Get file    files/${f}
    ${json}=     Evaluate    json.loads("""${file}""")    json

    ${outer_list}=     Create List
    FOR    ${INDEX}    IN RANGE    ${c}
        Log To Console    ${c}
        Append To List       ${outer_list}    ${INDEX}
    END
    [Return]    ${outer_list}


Create Simple List Count ${c}
    ${outer_list}=     Create List
    FOR    ${INDEX}    IN RANGE     ${c}
        Log To Console    echo  count
        Log To Console    ${c}
        Append To List       ${outer_list}    ${INDEX}
    END
    [Return]    ${outer_list}


*** Test Cases ***
For-Loop-In-Range
    FOR    ${INDEX}    IN RANGE    0    3
        Log To Console       ${INDEX}
        ${RANDOM_STRING}=    Generate Random String    ${INDEX}  #Generate random string length of ${INDEX}
        Log To Console       ${RANDOM_STRING}
#        Should Be Equal      ${RANDOM_STRING}        None
    END

For-Loop-In-Json
    ${json}    Create Json ManyScores.json
    FOR    ${ELEMENT}    IN    ${json[0]['account']}
        Log To Console   ${ELEMENT}
    END

For-Loop-In-List
    ${list}    Create List Count 2 from ManyScores.json
    FOR    ${ELEMENT}    IN    @{list}
        Log To Console   ${ELEMENT}
        Log To Console   Breaker
#        &{headers}=       Create Dictionary    Content-Type=application/json
#        Create Session    dso-match-person-service     ${base_url}
#        ${resp}=          Post Request  url    /method    data=${ELEMENT}    headers=${headers}
#        Should Be True     type(${resp.json()})     is dict
#        Should Be True     len(${resp.json()})      > 1
#        Log To Console    ${resp.json()}
#        Should Be Equal    ${inner_text}        None
    END

For-Loop-In-Simple-List
    ${list}    Create Simple List Count 2
    Log To Console     ${list}
    FOR    ${ELEMENT}    IN    @{list}
        Log To Console   ${ELEMENT}
    END
