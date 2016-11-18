*** Settings ***
Library     OperatingSystem
Library     String
Library     AppiumLibrary
Resource    repository.robot
Resource    CommonKWRds.robot
#Resource    FAQ.robot
Library     Collections
Suite Setup  Settings Suite Setup
Suite Teardown  Close air box App


*** Variables ***
${more options menu}=                       xpath=//*[@content-desc='More options']
${txt_General infolocator}=                 xpath=//*[@text='${General info}']
${txt_Legal noticelocator}=                 xpath=//*[@text='Legal notice']
${txt_Improvement programlocator}=          xpath=//*[contains(@text,"${Improvement program}")]
${txt content Legal notice}=                xpath=//*[contains(@content-desc,'${Button Legal notice}')]
${txt content Improvement program}=         xpath=//*[contains(@resource-id,'textImprovementDescription')]
${btn_improvementCustomTogglelocator}=      xpath=//*[contains(@resource-id,'improvementCustomToggleButton')]
${backlocator}=                             xpath=//*[@content-desc='Navigate up']
${txt_versionlocator}=                      xpath=//*[contains(@resource-id,'about_menufragment_appframe_appversion')]
${txt Legal notice contents}=               xpath=//*[contains(@content-desc,'Informations légales')]


*** Keywords ***
Settings Suite Setup
    Launch air box App
    Do Login    admin     ${DASHBOARD}
    click element  ${more options menu}
    wait until page contains   ${FAQ}
    page should contain text  ${general info}

Navigate and compare contents
    [Arguments]     ${element to navigate to}       ${element to read it}       ${file name to compare to}
    wait until page contains element        ${element to navigate to}
    click element       ${element to navigate to}
    ${content}=     get element attribute       ${element to read it}       text
    ${file conrtents}=      get file        ${file name to compare to}
    should contain      ${content}      ${file conrtents}

*** Test Cases ***
Check General info
#    [Tags]      fordebug
    ${txt_General info}     get element attribute     ${txt_General infolocator}      enabled
    click element   ${txt_General infolocator}
    page should contain text  ${info}
    sleep      1s
    page should contain text  ${My Airbox}
    ${txt_version}    get element attribute     ${txt_versionlocator}     text
    should match regexp  ${txt_version}        Version\\:\\s*.+
    page should contain text  Copyright Orange. All rights reserved.

Check Legal notice
    #[Teardown]        click element      ${backlocator}
    [Teardown]        custome keyboard back
#    click element   ${txt_General infolocator}
#    wait until page contains    General info
    click element       xpath=//*[@content-desc='${Button Legal notice}']
    custome scroll down
    #${out}=     run     adb shell input swipe 24 682 20 202 100
    sleep       1s
    #${out}=     run     adb shell input swipe 24 202 20 682 100
    custome scroll up
    page should contain text        ${Editor}
    page should contain text        ${Société}

#    page should contain text  General info
#    page should contain text  Legal notice
#    wait until page contains element        ${txt content Legal notice}
#    click element        ${txt content Legal notice}
#    @{page elements}=       get elements        ${txt Legal notice contents}
#    :For     ${hamada}       in  ${page elements}
#     \       log to console     ${hamada.text}
     #\      ${All texts}
#    navigate and compare contents       ${txt content Legal notice}      ${txt Legal notice contents}       ./Legal_notice.txt

Check Improvement program
    [Tags]      fordebug
    [Teardown]    click element      ${backlocator}
#   click element   ${txt_General infolocator}
#   wait until page contains    ${General info}
#   wait until page contains  ${Improvement program}
    click element   ${txt_General infolocator}
    log     ${txt_Improvement programlocator}
    wait until page contains element        ${txt_Improvement programlocator}
    click element        ${txt_Improvement programlocator}
    wait until page contains element     ${btn_improvementCustomTogglelocator}
    ${btn_improvementCustomToggle}     get element attribute     ${btn_improvementCustomTogglelocator}    checked
    should be equal   ${btn_improvementCustomToggle}   true
    click element  ${btn_improvementCustomTogglelocator}
    ${btn_improvementCustomToggle}     get element attribute     ${btn_improvementCustomTogglelocator}    checked
    should be equal   ${btn_improvementCustomToggle}   false
    click element  ${btn_improvementCustomTogglelocator}
    navigate and compare contents       ${txt_Improvement programlocator}      ${txt content Improvement program}       ./Improvement\ program.txt