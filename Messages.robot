*** Settings ***
Library     OperatingSystem
Library     String
Library     AppiumLibrary
Resource    repository.robot
Resource    CommonKWRds.robot
Suite Setup  Setup for Messages Tests
Suite Teardown  Close air box App
*** Variables ***
${dashboardlocator}=		    xpath=//*[@text='${DASHBOARD}']
${Messages locator}=            xpath=//*[contains(@resource-id,'action_messages')]
${new message btn}=             xpath=//*[contains(@resource-id,'messages_action_new')]

${total inbox messages}=        xpath=//*[contains(@resource-id,'messages_type_box_count_total')]
${Inbox locator}=               xpath=//*[@text='${Inbox}']
${inbox page header}=           xpath=//*[@class='android.widget.TextView' and @text='${Inbox}']
${draft page header}=           xpath=//*[@class='android.widget.TextView' and @text='${Draft}']

${navigate back}                xpath=//*[@content-desc='Navigate up']
${msg list view}=               xpath=//*[contains(@resource-id,'message_row_circle_view')]

${btn close locator}=           xpath=//*[contains(@resource-id,'buttonDefaultNeutral')]
${outbox locator}=              xpath=//*[@text='${Outbox}']
${draft locator}=               xpath=//*[@text='${Draft}']
${draft msg list}=              xpath=//*[contains(@resource-id,'id/message_row_text')]
${message recepiant}=           xpath=//*[contains(@resource-id,'message_new_recipients_edittext')]
${message body}=                xpath=//*[contains(@resource-id,'message_new_message_edittext')]
#Lable
${New message}=                 xpath=//*[@text='New message']


*** Keywords ***
Setup for Messages Tests
    Launch air box App
    Do Login    admin     DASHBOARD
    click element  ${Messages locator}
    sleep       1s
    page should contain text        ${Inbox}
    #custome scroll up
*** Test Cases ***

Check page contents
    page should contain element     ${Inbox locator}
    page should contain element     ${Outbox locator}
    page should contain element     ${Draft locator}
    page should contain element     ${new message btn}
    ####Exprimental:
    #### Xpaths Metkalefah :)
    ${txt}=     get element attribute       xpath=//*[@text='Outbox']/../*[contains(@resource-id,'messages_type_box_count_total')]     text
    log     Outbox:${txt}
    ${txt}=     get element attribute       xpath=//*[@text='Draft']/../*[contains(@resource-id,'messages_type_box_count_total')]     text
    log     Draft:${txt}

Check inbox
    [Teardown]  click element  ${navigate back}
    ${total inbox}=     get element attribute       ${total inbox messages}     text
    ###Return From Keyword If        '${total inbox}'=='0'
    click element       ${total inbox messages}
    wait until page contains element        ${inbox page header}
    page should contain element         ${new message btn}
    @{msgs}=        get elements        ${msg list view}
    log list    ${msgs}
    ${msgs list count}=     get length      ${msgs}
    log  ${msgs list count}
    should be equal as numbers  ${msgs list count}  ${total inbox}

check outbox
    [Teardown]  click element  ${navigate back}
    ${txt}=     get element attribute       xpath=//*[@text='Outbox']/../*[contains(@resource-id,'messages_type_box_count_total')]     text
    click element       ${total inbox messages}
    log    the feature is not implemented as it has a major issue
    Fail    Error in the outbox list


Check inbox open a message
    [Teardown]      click element  ${navigate back}
    click element       ${total inbox messages}
    wait until page contains element        ${inbox page header}
    page should contain element         ${new message btn}
    click element       ${msg list view}[1]
    sleep       1s
    page should contain text        ${CLOSE}
    page should contain text        ${DELETE}
    page should contain text        ${REPLY}
    click element       ${btn close locator}
    
Check Outbox and open a mesage
    [Teardown]      click element  ${navigate back}
    Click Element    ${outbox locator}
    Wait Until Page Contains    ${Outbox}
        

Check draft and open a mesage
    [Teardown]      click element  ${navigate back}
    Click Element    ${draft locator}
    wait until page contains element        ${draft page header}
    page should contain element         ${new message btn}
    click element       ${msg list view}[1]
    sleep       1s
    page should contain text        ${CLOSE}
    page should contain text        ${DELETE}
    page should contain text        ${EDIT}
    click element       ${btn close locator}
    

Check draft and compose a mesage
    [Teardown]      click element  ${navigate back}
    Click Element    ${draft locator}
    wait until page contains element        ${draft page header}
    page should contain element         ${new message btn}
    Click Element        ${new message btn}
    # click element        ${btn close locator}
    Wait Until Page Contains Element    ${message recepiant}
    Page Should Contain Element	    ${message body}
    click element        ${navigate back}
    
    

check draft
    [Tags]      debugme
    [Teardown]  click element  ${navigate back}
    ${total draft}=     get element attribute       xpath=//*[@text='Draft']/../*[contains(@resource-id,'messages_type_box_count_total')]     text
    log    ${total draft}
    Click Element    ${draft locator}
    @{msgs}=        get elements        ${draft msg list}
    ${msgs list count}=     get length      ${msgs}
    log  ${msgs list count}
    should be equal as numbers  ${msgs list count}  ${total draft}

    