*** Settings ***
Library     OperatingSystem
Library     String
Library     AppiumLibrary
Resource    repository.robot
Resource    CommonKWRds.robot
Library     Collections
Suite Setup  Settings Suite Setup
Suite Teardown  Close air box App

*** Variables ***
${users menu}           xpath=//*[contains(@resource-id,'action_users')]
${connected users}      xpath=//*[contains(@resource-id,'client_row_header_name')]
${users list item}      xpath=//*[contains(@resource-id,'client_row_name')]
${mac addr value}       xpath=//*[contains(@resource-id,'dialog_client_mac')]
${ip addr value}        xpath=//*[contains(@resource-id,'dialog_client_ip')]
${close btn}            xpath=//*[contains(@resource-id,'buttonDefaultNegative')]
${block btn}            xpath=//*[contains(@resource-id,'buttonDefaultPositive')]
${list of users}        xpath=//*[contains(@resource-id,'client_row_name')]
${page title locator}   xpath=//*[contains(@resource-id,':id/title')]
${dialogue mac locator}    xpath=//*[contins(@resource-id,'dialog_client_mac')]

*** Keywords ***
Settings Suite Setup
    Launch air box App
    Do Login    admin     ${DASHBOARD}
    click element  ${users menu}
    wait until page contains element        ${connected users}

*** Test Cases ***
Test valid connected users list
#    @{users list}       create list
#    ${users list}=      get elements        ${users list item}      False   False
    ${user txt}=        get element attribute       ${users list item}      text
    should match regexp     ${user txt}     android-\\w+

Test valid user info
    ${user txt}=        get element attribute       ${users list item}      text
    ${user}=        get elements        ${users list item}
    click element  ${users list item}[1]
    wait until page contains        ${user txt}
    page should contain text    ${MAC address}
    page should contain text    ${IP address}
    page should contain text    ${wi fi}
    ${mac addr}=        get element attribute       ${MAC addr value}       text
    should match regexp     ${mac addr}     ([0-9A-Fa-f]{2}[:]){5}([0-9A-Fa-f]{2})
    ${ip addr}=        get element attribute       ${ip addr value}       text
    should match regexp     ${ip addr}      ^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$
    page should contain element     ${block btn}
    click element       ${close btn}
    wait until page contains element        ${users list item}
#    ^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$