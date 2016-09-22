*** Settings ***
Library         AppiumLibrary  run_on_failure=Log Source

*** Variables ***
${REMOTE_URL}  http://localhost:4723/wd/hub

*** Keywords ***
TestStart
    [Documentation]  just demo
    Open Application  ${REMOTE_URL}   platformName=Android  deviceName=HQ588YL07922  app=${CURDIR}/Apps/app-debug.apk
    wait until page contains  See\ details  5
    Capture Page Screenshot     app-debug.png
    input text  xpath=//*[@resource-id='com.orange.airboxflybox:id/edt_login']      admin
    close application

*** Test Cases ***
Appium Demo
    TestStart
