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
${more options menu}                    xpath=//*[@content-desc='More options']
${txt_FAQlocator}                       xpath=//*[@text='${FAQ}']
${btn_Airboxlocator}                    xpath=//*[contains(@resource-id,'faq_tv_airbox')]
${btn_Airboxautolocator}                xpath=//*[contains(@resource-id,'faq_tv_airbox_auto')]
${btn_flyboxlocator}                    xpath=//*[contains(@resource-id,'faq_tv_flybox')]
${txt content FAQ_Airbox}               xpath=//*[contains(@resource-id,'faq_tv_text')]
${backlocator}                          xpath=//*[@content-desc='Navigate up']
${btn_Airbox Auto locator}              xpath=//*[contains(@resource-id,'faq_tv_airbox_auto')]
${btn_FlyBox locator}                   xpath=//*[contains(@resource-id,'faq_tv_flybox')]

*** Keywords ***
Settings Suite Setup
    Launch air box App
    Do Login    admin     ${DASHBOARD}
    click element  ${more options menu}
    wait until page contains   ${FAQ}
    page should contain text  ${General info}
    click element   ${txt_FAQlocator}
Navigate and compare contents
    [Arguments]     ${element to navigate to}       ${element to read it}       ${file name to compare to}
    wait until page contains element        ${element to navigate to}
    click element       ${element to navigate to}
    ${content}=     get element attribute       ${element to read it}       text
    ${content}=     String to comparable        ${content}
    ${file conrtents}=      get file        ${file name to compare to}        UTF-8        ignore
    ${file conrtents}=      String to comparable        ${file conrtents}
    should contain      ${content}      ${file conrtents}
    

Check FAQ
    ${txt_FAQ}     get element attribute     ${txt_FAQlocator}      enabled
    click element   ${txt_FAQlocator}
*** Test Cases ***
Check FAQ_Airbox
    [Teardown]        click element      ${backlocator}
    navigate and compare contents       ${btn_Airboxlocator}        ${txt content FAQ_Airbox}       ./FAQs_Airbox.txt

Check FAQ_Airbox Auto
    [Teardown]        click element      ${backlocator}
    navigate and compare contents       ${btn_Airbox Auto locator}        ${txt content FAQ_Airbox}       ./FAQs_AirboxAuto.txt

Check FAQ_flybox
  [Teardown]        click element      ${backlocator}
    navigate and compare contents       ${btn_FlyBox locator}        ${txt content FAQ_Airbox}      ./FAQs_Flybox.txt

Check General info
      log   gust a place holder

#Check FAQ_Airbox
#    [Teardown]        click element      ${backlocator}
#    ${btn_Airbox}     get element attribute     ${btn_Airboxlocator}        clickable
#    should be equal     ${btn_Airbox}       true
#    click element  ${btn_Airboxlocator}
#    wait until page contains element  ${txt content FAQ_Airbox}
#    ${content}=     get element attribute  ${txt content FAQ_Airbox}        text
#    ${file FAQ_Airbox}=     get file        ./FAQs_Airbox.txt
#    should contain    ${content}        ${file FAQ_Airbox}

