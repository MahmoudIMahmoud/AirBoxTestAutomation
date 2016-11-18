*** Settings ***
Library     OperatingSystem
Library     String
Library     AppiumLibrary
Resource    repository.robot
Resource    CommonKWRds.robot
Suite Setup  Setup for Messages Tests
Suite Teardown  Close air box App
*** Variables ***
${Inbox element locator}        xpath=//*[contains(@resource-id,'id/messages_type_box_view')]
${Messages locator}             xpath=//*[contains(@resource-id,'id/action_messages')]
${navigate back}                xpath=//*[@content-desc='Navigate up']

*** Keywords ***
Setup for Messages Tests    
    Launch air box App
    Do Login    admin     ${DASHBOARD}
    click element  ${Messages locator}
    sleep       1s
    Page Should Contain Element        ${Inbox element locator}

*** Test Cases ***
Check inbox
    [Teardown]  click element  ${navigate back}
    Click Element    ${Inbox element locator}[1]
    sleep        1s
    Capture Page Screenshot    inbox.png

