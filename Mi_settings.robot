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
${settingslocator}                              xpath=//*[@text='${SETTINGS}']
${txt_network_settingslocator}                  xpath=//*[@resource-id='${pkgName}:id/subheader_wifi']
${btn_wifinetworklocator}                       xpath=//*[contains(@resource-id,'ll_settings_wifi')]
${txt_wifinetworklocator}                       xpath=//*[contains(@text,'${Wi-Fi network}')]
${txt_wifinetwork_ssidlocator}                  xpath=//*[@resource-id='${pkgName}:id/tv_setting_wifi_ssid']
${txt_wifinetwork_ssidedtlocator}               xpath=//*[@resource-id='${pkgName}:id/edt_ssid']
${btn_canclelocator}                            xpath=//*[@resource-id='${pkgName}:id/buttonDefaultNegative']
${btn_savelocator}                              xpath=//*[@resource-id='${pkgName}:id/buttonDefaultPositive']
${btn_wifipasswordlocator}                      xpath=//*[@resource-id='${pkgName}:id/tv_setting_wifi_key']
${EditText_wifipasswordlocator}                 xpath=//*[@resource-id='${pkgName}:id/edt_key']
${chkbox_Show passwordlocator}                  xpath=//*[@resource-id='${pkgName}:id/cb_show_key']
${btn_Guset_wifinetworklocator}                 xpath=//*[contains(@resource-id,'ll_settings_guest_wifi')]
${txt_Guset_wifinetworklocator}                 xpath=//*[contains(@text,'${Guest Wi-Fi network}')]
${txt_Guset_wifinetwork_ssidlocator}            xpath=//*[@resource-id='${pkgName}:id/tv_setting_wifi_guest_ssid']
${txt_Guset_wifinetwork_ssidedtlocator}         xpath=//*[@resource-id='${pkgName}:id/edt_ssid']
${btn_Guset_wifisecuritylocator}                xpath=//*[@resource-id='${pkgName}:id/tv_setting_wifi_guest_key']
${btn_switch_wpa2locator}                       xpath=//*[@resource-id='${pkgName}:id/switch_wpa2']
${btn_AccessPointNamelocator}                   xpath=//*[@resource-id='${pkgName}:id/tv_setting_apn']
${btn_ImageButton_backlocator}                  xpath=//*[contains(@class,'android.widget.ImageButton')]
${LinearLayoutlocator}                          xpath=//*[contains(@class,'android.widget.LinearLayout')]
${apn_profile_namelocator}                      xpath=//*[@resource-id='${pkgName}:id/apn_profile_name']
${apn_profile_apnlocator}                       xpath=//*[@resource-id='${pkgName}:id/apn_profile_apn']
${Rbtn_apn_profile_actiflocator}                xpath=//*[@resource-id='${pkgName}:id/apn_profile_actif']
${txt_Security_settingslocator}                 xpath=//*[@resource-id='${pkgName}:id/subheader_security']
${btn_Adminpasswordlocator}                     xpath=//*[@resource-id='${pkgName}:id/tv_settings_password']
${edt_current_passwordlocator}                  xpath=//*[@resource-id='${pkgName}:id/edt_current_password']
${edt_new_passwordlocator}                      xpath=//*[@resource-id='${pkgName}:id/edt_new_password']
${chkbox_Show passwordslocators}                xpath=//*[@resource-id='${pkgName}:id/cb_show_password']
${btn_pincodelocator}                           xpath=//*[@resource-id='${pkgName}:id/tv_setting_pin']
${edt_current_pinlocator}                       xpath=//*[@resource-id='${pkgName}:id/edt_current_pin']
${edt_new_pinlocator}                           xpath=//*[@resource-id='${pkgName}:id/edt_new_pin']
${chkbox_Show pinlocator}                       xpath=//*[@resource-id='${pkgName}:id/cb_show_pin']
${txt_Other_settingslocator}                    xpath=//*[@resource-id='${pkgName}:id/subheader_other']
${btn_boxlanguagelocator}                       xpath=//*[@resource-id='${pkgName}:id/ll_settings_language']
${txt_English_languagelocator}                  xpath=//*[@text='${English}']
${txt_French_languagelocator}                   xpath=//*[@text='${French}']
${txt_Spanish_languagelocator}                  xpath=//*[@text='${Spanish}']
${txt_Box languagelocator}                      xpath=//*[@resource-id='${pkgName}:id/tv_setting_language']
${txt_current_languagelocator}                  xpath=//*[@resource-id='${pkgName}:id/tv_current_language']
${btn_aboutmyboxlocator}                        xpath=//*[@resource-id='${pkgName}:id/txt_setting_about']
${txt_boxnamelocator}                           xpath=//*[@resource-id='${pkgName}:id/tv_box_name']
${txt_imeilocator}                              xpath=//*[@resource-id='${pkgName}:id/tv_imei']
${txt_imsilocator}                              xpath=//*[@resource-id='${pkgName}:id/tv_imsi']
${txt_simphonenumberlocator}                    xpath=//*[@resource-id='${pkgName}:id/tv_sim_phone_num']
${txt_hardwareversionlocator}                   xpath=//*[@resource-id='${pkgName}:id/tv_hw_version']
${txt_softwareversionlocator}                   xpath=//*[@resource-id='${pkgName}:id/tv_soft_version']
${txt_uiversionlocator}                         xpath=//*[@resource-id='${pkgName}:id/tv_ui_version']
${txt_macaddresslocator}                        xpath=//*[@resource-id='${pkgName}:id/tv_lan_mac_addr']
${txt_ipaddresslocator}                         xpath=//*[@resource-id='${pkgName}:id/tv_wan_ip_addr']
${txt_ipv6addresslocator}                       xpath=//*[@resource-id='${pkgName}:id/tv_wan_ipv6_addr']
*** Keywords ***
Settings Suite Setup
    Launch air box App
    Do Login    admin     ${DASHBOARD}
    click element  ${settingslocator}
    ${status}=     get element attribute     ${settingslocator}    selected
    should be equal     ${status}       true

*** Test Cases ***
Check network settings
    ${txt_network_settings}     get element attribute     ${txt_network_settingslocator}      text
    should contain      ${Network}      ${txt_network_settings}

Wi-Fi network
    ${btn_wifinetwork}     get element attribute     ${btn_wifinetworklocator}    clickable
    should be equal     ${btn_wifinetwork}       true
    ${txt_wifinetwork}    get element attribute     ${txt_wifinetworklocator}     text
    should contain      ${Wi-Fi network}   ${txt_wifinetwork}
    ${txt_wifinetwork_ssid}    get element attribute     ${txt_wifinetwork_ssidlocator}     text
    should match regexp  ${txt_wifinetwork_ssid}        \\w+
    click element  ${btn_wifinetworklocator}
    page should contain text  ${Wi-Fi network}
    ${txt_wifinetwork_ssidedt}    get element attribute     ${txt_wifinetwork_ssidedtlocator}     text
    should be equal  ${txt_wifinetwork_ssid}         ${txt_wifinetwork_ssidedt}
    page should contain text  ${By changing the Wi-Fi SSID}
    page should contain text  ${CANCEL}
    page should contain text  ${SAVE}
    ${btn_cancel}     get element attribute     ${btn_canclelocator}    enabled
    should be equal      ${btn_cancel}        true
    click element  ${btn_canclelocator}

Wi-Fi password
    ${btn_wifipassword}     get element attribute     ${btn_wifipasswordlocator}    clickable
    should be equal     ${btn_wifipassword}       true
    ${btn_wifipassword}     get element attribute     ${btn_wifipasswordlocator}    text
    should contain  ${Wi-Fi password}  ${btn_wifipassword}
    click element  ${btn_wifipasswordlocator}
    page should contain text  ${Wi-Fi password}
    page should contain text    ${Password}
    ${EditText_wifipassword}     get element attribute     ${EditText_wifipasswordlocator}    enabled
    should be equal  ${EditText_wifipassword}    true
    ${chkbox_Show password}     get element attribute     ${chkbox_Show passwordlocator}    text
    should contain   ${Show password}  ${chkbox_Show password}
    ${chkbox_Show password}     get element attribute     ${chkbox_Show passwordlocator}    checkable
    should be equal   ${chkbox_Show password}   true
    page should contain text  ${By changing the Wi-Fi password}
    page should contain text  ${CANCEL}
    page should contain text  ${SAVE}
    ${btn_cancel}     get element attribute     ${btn_canclelocator}    enabled
    should be equal      ${btn_cancel}        true
    click element  ${btn_canclelocator}

Guest Wi-Fi network
    ${btn_Guset_wifinetwork}     get element attribute     ${btn_Guset_wifinetworklocator}    clickable
    should be equal     ${btn_Guset_wifinetwork}       true
    ${txt_Guset_wifinetwork}    get element attribute     ${txt_Guset_wifinetworklocator}     text
    should contain     ${Guest Wi-Fi network}   ${txt_Guset_wifinetwork}
    ${txt_Guset_wifinetwork_ssid}    get element attribute     ${txt_Guset_wifinetwork_ssidlocator}     text
    should match regexp  ${txt_Guset_wifinetwork_ssid}        \\w+
    click element  ${btn_Guset_wifinetworklocator}
    page should contain text  ${Wi-Fi network}
    page should contain text    ${Wi-Fi SSID}
    ${txt_Guset_wifinetwork_ssidedt}    get element attribute     ${txt_Guset_wifinetwork_ssidedtlocator}     text
    should be equal  ${txt_Guset_wifinetwork_ssid}         ${txt_Guset_wifinetwork_ssidedt}
    page should contain text  ${By changing the Wi-Fi SSID}
    page should contain text  ${CANCEL}
    page should contain text  ${SAVE}
    ${btn_cancel}     get element attribute     ${btn_canclelocator}    enabled
    should be equal      ${btn_cancel}        true
    click element  ${btn_canclelocator}

Guest Wi-Fi security
    ${btn_Guset_wifisecurity}     get element attribute     ${btn_Guset_wifisecuritylocator}    clickable
    should be equal     ${btn_Guset_wifisecurity}       true
    click element  ${btn_Guset_wifisecuritylocator}
    page should contain text  ${Guest Wi-Fi security}
    page should contain text    ${The current scurity level}
    page should contain text  ${WPA2}
    page should contain text    ${Improve the security level}
    ${btn_switch_wpa2}    get element attribute     ${btn_switch_wpa2locator}     text
    should contain     ${OFF}   ${btn_switch_wpa2}
    click element  ${btn_switch_wpa2locator}
    ${btn_switch_wpa2}    get element attribute     ${btn_switch_wpa2locator}     text
    should contain     ${ON}   ${btn_switch_wpa2}
    page should contain text     ${Password}
    ${EditText_wifipassword}     get element attribute     ${EditText_wifipasswordlocator}    enabled
    should be equal  ${EditText_wifipassword}    true
    ${chkbox_Show password}     get element attribute     ${chkbox_Show passwordlocator}    text
    should contain   ${Show password}  ${chkbox_Show password}
    ${chkbox_Show password}     get element attribute     ${chkbox_Show passwordlocator}    checkable
    should be equal   ${chkbox_Show password}   true
     page should contain text  ${By changing the Wi-Fi password}
    page should contain text  ${CANCEL}
    page should contain text  ${SAVE}
    ${btn_cancel}     get element attribute     ${btn_canclelocator}    enabled
    should be equal      ${btn_cancel}        true
    click element  ${btn_canclelocator}
    custome scroll down

Access Point Name (APN)
    ${btn_AccessPointName}     get element attribute     ${btn_AccessPointNamelocator}    clickable
    should be equal     ${btn_AccessPointName}       true
    click element  ${btn_AccessPointNamelocator}
    page should contain text  ${Access Point Name (APN)}
    ${btn_ImageButton_back}     get element attribute     ${btn_ImageButton_backlocator}    clickable
    should be equal     ${btn_ImageButton_back}       true
    click element  ${btn_ImageButton_backlocator}
    click element  ${btn_AccessPointNamelocator}

    ${apn_profile_name}    get element attribute     ${apn_profile_namelocator}     text
    should match regexp  ${btn_ImageButton_back}        \\w+
    ${apn_profile_apn}    get element attribute     ${apn_profile_apnlocator}     text
    should match regexp  ${apn_profile_apn}        \\w+
    ${Rbtn_apn_profile_actif}     get element attribute     ${Rbtn_apn_profile_actiflocator}    checkable
    should be equal     ${Rbtn_apn_profile_actif}       true
    click element  ${Rbtn_apn_profile_actiflocator}

Check security settings
    ${txt_Security_settings}    get element attribute     ${txt_Security_settingslocator}      text
    should contain     ${Security}       ${txt_Security_settings}

Admin Password
    ${btn_Adminpassword}     get element attribute     ${btn_Adminpasswordlocator}    clickable
    should be equal     ${btn_Adminpassword}       true
    click element  ${btn_Adminpasswordlocator}
    page should contain text  ${Admin password}
    page should contain text  ${Current password}
    ${edt_current_password}     get element attribute     ${edt_current_passwordlocator}    clickable
    should be equal     ${edt_current_password}       true
    click element  ${edt_current_passwordlocator}
    ${edt_new_password}     get element attribute     ${edt_new_passwordlocator}    clickable
    should be equal     ${edt_new_password}       true
    click element    ${edt_new_passwordlocator}
    page should contain text  ${New password}
    ${chkbox_Show passwords}     get element attribute     ${chkbox_Show passwordslocators}    text
    should contain   ${Show passwords}  ${chkbox_Show passwords}
    ${chkbox_Show passwords}     get element attribute     ${chkbox_Show passwordslocators}    checkable
    should be equal   ${chkbox_Show passwords}   true
    ${chkbox_Show passwords}     get element attribute     ${chkbox_Show passwordslocators}    checked
    should be equal   ${chkbox_Show passwords}   false
    click element    ${chkbox_Show passwordslocators}
    ${chkbox_Show passwords}     get element attribute     ${chkbox_Show passwordslocators}    checked
    should be equal   ${chkbox_Show passwords}   true
    click element    ${chkbox_Show passwordslocators}
    Custome keyboard back
    page should contain text  ${CANCEL}
    page should contain text  ${SAVE}
    click element  ${btn_canclelocator}

PIN code
    ${btn_pincode}     get element attribute     ${btn_pincodelocator}    clickable
    should be equal     ${btn_pincode}       true
    click element  ${btn_pincodelocator}
    page should contain text  ${PIN code}
    page should contain text  ${Current PIN}
    ${edt_current_pin}     get element attribute     ${edt_current_pinlocator}    clickable
    should be equal     ${edt_current_pin}       true
    ${edt_new_pin}     get element attribute     ${edt_new_pinlocator}    clickable
    should be equal     ${edt_new_pin}       true
    click element    ${edt_new_pinlocator}
    page should contain text  ${New PIN}
    ${chkbox_Show pin}     get element attribute     ${chkbox_Show pinlocator}    text
    should contain   ${Show PIN codes}  ${chkbox_Show pin}
    ${chkbox_Show pin}     get element attribute     ${chkbox_Show pinlocator}    checkable
    should be equal   ${chkbox_Show pin}   true
    ${chkbox_Show pin}     get element attribute     ${chkbox_Show pinlocator}    checked
    should be equal   ${chkbox_Show pin}   false
    click element     ${chkbox_Show pinlocator}
    ${chkbox_Show pin}     get element attribute     ${chkbox_Show pinlocator}    checked
    should be equal   ${chkbox_Show pin}   true
    click element     ${chkbox_Show pinlocator}
    page should contain text  ${CANCEL}
    page should contain text  ${SAVE}
    click element  ${btn_canclelocator}

Check other settings
    ${txt_Other_settings}    get element attribute     ${txt_Other_settingslocator}      text
    should contain      ${Other}      ${txt_Other_settings}

Box Language
    ${btn_boxlanguage}     get element attribute     ${btn_boxlanguagelocator}    clickable
    should be equal     ${btn_boxlanguage}       true
    ${txt_Box language}    get element attribute     ${txt_Box languagelocator}      text
    should contain      ${Box language}      ${txt_Box language}
    ${txt_current_language}    get element attribute     ${txt_current_languagelocator}     text
    should match regexp  ${txt_current_language}        \\w+
    click element   ${btn_boxlanguagelocator}
    ${txt_English_language}    get element attribute     ${txt_English_languagelocator}     text
    click element   ${txt_English_languagelocator}
#    should be equal  ${txt_current_language}         ${txt_English_language}
    click element   ${btn_boxlanguagelocator}
    ${txt_French_language}    get element attribute     ${txt_French_languagelocator}     text
    click element   ${txt_French_languagelocator}
    ${txt_current_language}    get element attribute     ${txt_current_languagelocator}     text
    should be equal as strings     ${French}          ${txt_current_language}
    click element   ${btn_boxlanguagelocator}
    page should contain text  ${Box language}
    page should contain text  ${English}
    page should contain text   ${French}
    page should contain text  ${Spanish}
    click element   ${txt_English_languagelocator}
    sleep   1s
    page should contain text    ${The language of the box}
    sleep  5s

About My Box
    ${btn_aboutmybox}     get element attribute     ${btn_aboutmyboxlocator}    clickable
    should be equal     ${btn_aboutmybox}       true
    click element   ${btn_aboutmyboxlocator}
    sleep   1s

About My Box_ Box name
    page should contain text    ${Box name}
    ${txt_boxname}    get element attribute     ${txt_boxnamelocator}     text
    should match regexp  ${txt_boxname}        [\\w-]+

About My Box_ IMEI
    page should contain text    ${IMEI}
    ${txt_IMEI}    get element attribute     ${txt_imeilocator}     text
    should match regexp  ${txt_IMEI}        ^(?!\\b(.)\\1+\\b)\\d{15}$

About My Box_ IMSI
    page should contain text    ${IMSI}
    ${txt_IMSI}    get element attribute     ${txt_imsilocator}     text
    should match regexp  ${txt_IMSI}        ^(?!\b(.)\\1+\\b)\\d{15}$

About My Box_ SIM phone number
    page should contain text    ${SIM phone number}
    ${txt_SIM_phone_number}    get element attribute     ${txt_simphonenumberlocator}     text
    should contain      ${unavailable}   ${txt_SIM_phone_number}

About My Box_ Hardware version
    page should contain text    ${Hardware version}
    ${txt_hardware_version}    get element attribute     ${txt_hardwareversionlocator}     text
    should match regexp  ${txt_hardware_version}        \\w+

About My Box_ Software version
    page should contain text    ${Software version}
    ${txt_software_version}    get element attribute     ${txt_softwareversionlocator}     text
    should match regexp  ${txt_software_version}        \\d+[\\.\\d+]+

About My Box_ UI version
    custome scroll down
    page should contain text    ${UI version}
    ${txt_ui_version}    get element attribute     ${txt_uiversionlocator}     text
    should match regexp  ${txt_ui_version}        \\d+[\\.\\d+]+

About My Box_ MAC address
    page should contain text    ${MAC address}
      ${txt_MAC_version}    get element attribute     ${txt_macaddresslocator}     text
    should match regexp  ${txt_MAC_version}        \\w+[\\:\\w+]+

About My Box_ IP address
    page should contain text    ${IP address}
    ${txt_IP_address}    get element attribute     ${txt_ipaddresslocator}     text
    should contain      ${unavailable}   ${txt_IP_address}

About My Box_ IPv6 address
    page should contain text    ${IPv6 address}
    ${txt_IPv6_address}    get element attribute     ${txt_ipv6addresslocator}     text
    should contain      ${unavailable}   ${txt_IPv6_address}


