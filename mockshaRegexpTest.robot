*** Settings ***
Documentation       Test of POST request.
Library             Collections
Library             String
Library             OperatingSystem
Library             RequestsLibrary
Library             FakerLibrary

*** Variables ***
${base_url}         http://localhost:8089

*** Test Cases ***
For-Loop-In-Range
    FOR    ${INDEX}    IN RANGE    0    20
        Log To Console       ${INDEX}

        ${k0}=    FakerLibrary.Word
        ${k1}=    FakerLibrary.Word
        ${k2}=    FakerLibrary.Word
        ${k3}=    FakerLibrary.Pystr     min_chars=1     max_chars=4

        ${v0}=    FakerLibrary.Word
        ${v1}=    FakerLibrary.Word
        ${v2}=    Generate Random String    2    [LETTERS]
        ${v3}=    FakerLibrary.Word
        ${v4}=    FakerLibrary.Word
        ${v5}=    FakerLibrary.Word

        ${arguments}=     Evaluate    {"${k0}": {"${k1}": "${v1}"}, "${k2}": "${v2}", "${k3}": ["${v3}", "${v4}", "${v5}"]}
        Log To Console    ${arguments}

        Create Session    mocksha     ${base_url}
        &{headers}=       Create Dictionary    Content-Type=application/json
        ${resp}=          Post Request    mocksha    /many_people    data=${arguments}    headers=${headers}
        Log To Console    ${resp.content}
        Request Should Be Successful            ${resp}
        ${json_response}=  Convert To String    ${resp.status_code}
        Should Be True    type(${resp.content}) is dict
        Should Be Equal    ${json_response}     200
    END


