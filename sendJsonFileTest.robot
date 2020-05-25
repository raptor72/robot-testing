*** Settings ***
Documentation       Test of json.
Library             Collections
Library             OperatingSystem
Library             RequestsLibrary


*** Variables ***
${base_url}         http://localhost:8080


*** Test Cases ***
Example of how to load JSON
    ${json}=    Get file    files/Score3.json
    Log to Console    ${json}

    # convert the data to a python object
    ${object}=    Evaluate    json.loads('''${json}''')    json
    Log to Console    ${object}

    # log the data
    log    Hello, my name is ${object["account"]} ${object["login"]} | WARN
    log to Console    Hello, my account is ${object["account"]} and login ${object["login"]}

    Create Session    ScoringAPI     ${base_url}
    &{headers}=       Create Dictionary    Content-Type=application/json

    ${resp}=          Post Request  ScoringAPI  /method  data=${json}    headers=${headers}
    Log               ${resp}
    Log To Console    ${resp.content}
    Log To Console    ${resp.json()}
    Request Should Be Successful            ${resp}