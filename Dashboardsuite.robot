*** Settings ***
Library     OperatingSystem
Library     String
Library     AppiumLibrary
Resource    repository.robot
Resource    CommonKWRds.robot
Suite Setup  Launch air box App
Suite Teardown  Close air box App
*** Variables ***
${dashboardlocator}=		xpath=//*[@text='DASHBOARD']
${nwtypelocator}=		xpath=//*[@resource-id='${pkgName}:id/txt_network_type']
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
#Labels
${Mobile data traffic}=     Mobile data traffic
${Monthly data traffic}=        Monthly data traffic
${national label}=      National
${roaming label}=       Roaming
*** Test Cases ***
Check connection type
    Do Login    admin     DASHBOARD
    click element  ${dashboardlocator}
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
