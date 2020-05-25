*** Settings ***
Documentation       Test of extension Libs
Library             ./libraries/HashGeneratorLib.py
Library             OperatingSystem
Library             RequestsLibrary


*** Test Cases ***
Look how self-made HashGeneratorLibrary.py works
    ${hash}=    Generate hash
    Log               ${hash}
    Log To Console    ${hash}
    ${time}=          Get Time
    Log To Console    ${time}