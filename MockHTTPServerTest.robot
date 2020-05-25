*** Settings ***
Documentation       Test of POST request.
Library             Collections
#Library             HTTPServer               # https://www.relaysoft.net/wp-content/uploads/2019/03/HTTPServer.html#Start%20HTTP%20Server
Library             HttpLibrary.HTTP         # http://peritus.github.io/robotframework-httplibrary/HttpLibrary.html
#Library             HttpCtrl.Client
#Library             HTTPDLibrary    port=5060

*** Variables ***
${base_url}         http://localhost:8888

*** Test Cases ***
FirstTest
#    Create HTTP Context    ${base_url}    http
    Log    Hello World...

*** Keywords ***
Initialize HTTP Client And Server
    Initialize HTTP Server	  8888
    Start HTTP Server
    Set Default Response	content=Hello	statusCode=${201}	contentType=text/plain

Terminate HTTP Server
    Stop HTTP Server