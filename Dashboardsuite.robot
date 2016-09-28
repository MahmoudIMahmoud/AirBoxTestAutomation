*** Settings ***
Library     OperatingSystem
Library     String
Library     AppiumLibrary
Resource    repository.robot
Resource    CommonKWRds.robot
Suite Setup  Setup For DASHBOARD Tests
Suite Teardown  Close air box App
*** Variables ***
${dashboardlocator}=        xpath=//*[@text='DASHBOARD']
${nwtypelocator}=       xpath=//*[@resource-id='${pkgName}:id/txt_network_type']
${bataryLevelLocator}=      xpath=//*[contains(@resource-id,'txt_battery_level')]
${connectionTimeLocator}=      xpath=//*[contains(@resource-id,'txt_data_traffic_since_value')]
${dataUsageLocator}=      xpath=//*[contains(@resource-id,'txt_data_traffic_value')]
${qoutaUnitLocator}=      xpath=//*[contains(@resource-id,'txt_data_traffic_unit')]
${moreDetailsLocator}=     xpath=//*[contains(@resource-id,'btn_data_traffic_more_details')]
${txt_national_totalLocator}=      xpath=//*[contains(@resource-id,'txt_national_total')]
${txt_international_totalLocator}=      xpath=//*[contains(@resource-id,'txt_international_total')]
${txt_national_downloadLocator}=        xpath=//*[contains(@resource-id,'txt_national_download')]
${txt_national_uploadLocator}=      xpath=//*[contains(@resource-id,'txt_national_upload')]
${buttonCloseLocator}=      xpath=//*[contains(@resource-id,'buttonDefaultPositive')]
${txt_international_downloadLocator}=       xpath=//*[contains(@resource-id,'txt_international_download')]
${txt_international_uploadLocator}=     xpath=//*[contains(@resource-id,'txt_international_upload')]
${btn_wifi_display_key}=        xpath=//*[contains(@resource-id,'btn_wifi_display_key')]
${txt_wifi_key}=        xpath=//*[contains(@resource-id,'txt_wifi_key')]
${btn_close}=       xpath=//*[contains(@resource-id,'buttonDefaultPositive')]
${btn_share}=       xpath=//*[contains(@resource-id,'buttonDefaultNeutral')]
${txt_wifi_ssid}=       xpath=//*[contains(@resource-id,'txt_wifi_ssid')]
${txt_guest_wifi_ssid}=     xpath=//*[contains(@resource-id,'txt_guest_wifi_ssid')]
${guest wifi detail title}=        xpath=//*[@resource-id='com.orange.airboxflybox:id/title']
${btn_guest_wifi_display_key}=      xpath=//*[contains(@resource-id,'btn_guest_wifi_display_key')]

#Labels
${Mobile data traffic}=     Mobile data traffic
${Monthly data traffic}=        Monthly data traffic
${national label}=      National
${roaming label}=       Roaming

*** Keywords ***
Setup For DASHBOARD Tests
    Launch air box App
    Do Login    admin     DASHBOARD
    click element  ${dashboardlocator}
    #custome scroll up
*** Test Cases ***
Check connection type
    ${status}=     get element attribute     ${dashboardlocator}    selected
    log         ${status}
    should be equal     ${status}       true
    ${nwtype}     get element attribute     ${nwtypelocator}      text
    log     ${nwtype}
    should contain      3G 4G      ${nwtype}
    #scroll      xpath=//*[@text='Mobile connection']        xpath=//*[@text='Wi-Fi']

Check batarry level
    ${bataryLevel}=     get element attribute       ${bataryLevelLocator}       text
    should match regexp     ${bataryLevel}       \\d+%

Check data traffic
    ${dataTrafficTime}=     get element attribute       ${connectionTimeLocator}       text
    log     ${dataTrafficTime}
    ${dataUsage}=       get element attribute       ${dataUsageLocator}     text
    log     ${dataUsage}
    ${qoutaUnit}=       get element attribute       ${qoutaUnitLocator}     text
    log     ${qoutaUnit}
    should match regexp  ${dataTrafficTime}     \\d+d\\s\\d+h
    should match regexp  ${dataUsage}       [\\d*\\.*\\d*]+
    should match regexp  ${qoutaUnit}       [KMG]{1}B
    page should contain text    ${Mobile data traffic}

Test more details national
    click element       ${moreDetailsLocator}
    wait until page contains        ${Monthly data traffic}     10s
    ${txt_national_total}=      get element attribute       ${txt_national_totalLocator}        text
    log     ${txt_national_total}
    should match regexp     ${txt_national_total}       [\\d*\\.*\\d*]+\\s[MKG]*B
    page should contain text  ${national label}
    ${txt_national_download}=       get element attribute       ${txt_national_downloadLocator}         text
    should match regexp     ${txt_national_download}        [\\d*\\.*\\d*]+\\s[MKG]*B
    ${txt_national_upload}=     get element attribute       ${txt_national_uploadLocator}       text
    should match regexp     ${txt_national_upload}        [\\d*\\.*\\d*]+\\s[MKG]*B
    click element   ${buttonCloseLocator}
    wait until page contains        DASHBOARD       10s

Test more details roaming
    click element       ${moreDetailsLocator}
    page should contain text  ${roaming label}
    ${txt_international_total}=     get element attribute       ${txt_international_totalLocator}        text
    should match regexp     ${txt_international_total}      [\\d*\\.*\\d*]+\\s[MKG]*B
    ${txt_international_download}=        get element attribute     ${txt_international_downloadLocator}        text
    should match regexp     ${txt_international_download}       [\\d*\\.*\\d*]+\\s[MKG]*B
    ${txt_international_upload}=        get element attribute       ${txt_international_uploadLocator}      text
    click element   ${buttonCloseLocator}
    wait until page contains        DASHBOARD       10s

Test wi-fi display key
    ${wi-fi-ssid}=      get element attribute       ${txt_wifi_ssid}        text
    click element       ${btn_wifi_display_key}
    wait until page contains element        ${wi-fi-ssid}
    page should contain text        ${txt_wifi_ssid}
    ${key for AirBox}=      get element attribute       ${txt_wifi_key}     text
    should match regexp     ${txt_wifi_key}     \\w+
    click element       ${btn_close}

Test wi-fi display share
    click element       ${btn_wifi_display_key}
    wait until page contains element        ${txt_wifi_key}
    click element       ${btn_share}
    wait until page contains    Share using
    page should contain text    Share using
    custome keyboard back
    #click element       ${btn_close}
    page should contain element     ${dashboardlocator}



Test guest wi-fi display share
    [Setup]     custome scroll up
    click element       ${btn_wifi_display_key}
    wait until page contains element        ${txt_wifi_key}
    click element       ${btn_share}
    wait until page contains    Share using
    page should contain text    Share using
    custome keyboard back
    #click element       ${btn_close}
    page should contain element     ${dashboardlocator}
#
# Review
#
Test guest wi-fi display key
    [Teardown]    custome scroll up
    #custome scroll down
    ${output}=      run     adb shell input swipe 0 682 20 202 100
    sleep  1s
    ${guest-wi-fi-ssid}=      get element attribute       ${txt_guest_wifi_ssid}        text
    log to console      ${guest-wi-fi-ssid}
    click element       ${btn_guest_wifi_display_key}
    sleep       1s
    #Read Title:
    ${msgboxtitile}=     get element attribute       ${guest wifi detail title}        text
    log       message\ box's\ title\ ${msgboxtitile}
    ${key for AirBox}=      get element attribute       ${txt_wifi_key}     text
    should match regexp     ${txt_wifi_key}     \\w+
    click element       ${btn_close}