*** Settings ***
Documentation       Пример smoke-автотеста.
Library             Collections
Library             RequestsLibrary

*** Variables ***
${base_url}         https://en.wikipedia.org/wiki
${url}              /

*** Test Cases ***
Проверить доступность Wiki
    Create Session    github         http://api.github.com    disable_warnings=1
    Create Session    google         http://www.google.com
    ${resp}=          Get Request    google               /
    Status Should Be  200            ${resp}
    ${resp}=          Get Request    github               /users/raptor72
    Request Should Be Successful     ${resp}
    Log    ${resp}
    Dictionary Should Contain Value  ${resp.json()}       Maksim Tarasov
