*** Settings ***
Library     OperatingSystem
Library     String
Library     AppiumLibrary
Library     Collections
Resource    repository.robot
*** Variables ***
${AppiumURL}                            http://localhost:4723/wd/hub
${passwdlocator}                        xpath=//*[contains(@resource-id,'edt_password')]
${appfile}                              airbox-espagne.apk
${device}                               29bfe0b7
*** Keywords ***
Do Login
    [Arguments]     ${passwd}   ${assertionstr}
    wait until page contains element  ${passwdlocator}   10s
    clear text  ${passwdlocator}
    input text  ${passwdlocator}   ${passwd}
    custome keyboard done
    wait until page contains  ${assertionstr}
    page should contain text  ${assertionstr}

Launch Air Box App
    ${connectedDev}=    get device name
    log to console      ${connectedDev}
    ${connectedDev}=    Set Variable        ${device}
    ${apk path}         Set Variable        ${CURDIR}${/}Apps${/}${appfile}
    Log To Console      app path:${apk path}
    Open Application  ${AppiumURL}   platformName=Android  deviceName=${connectedDev}  app=${apk path}

ADB Launch App
    ${output}       run  adb -s ${device} shell am start -n ${pkgName}/${pkgName}.ui.LoginActivity

Close air box App
    ${output}       run  adb -s ${device} shell am force-stop ${pkgName}
    close application
    log to console  finished

Custome keyboard done
    sleep  1s
    ${output}       run  adb -s ${device} shell input keyevent 66 keyevent 66


Custome keyboard back
    sleep  1s
    ${output}       run  adb -s ${device} shell input keyevent 4

Get device name
    ${devices}=     run     adb devices
    ${matches}=     Get Lines Matching Regexp       ${devices}      (\\w+)\\s+device$
#    log to console  "====> "${matches}
    @{device}=      Get Regexp Matches      ${matches}      (\\w+)\\s+device        1
#    log to console  "My Device : =>>>"${device}
    ${dd}=      get from list  ${device}    0
    return from keyword      ${dd}

Custome scroll down
    [Arguments]     ${dy}=10
    ${output}=      run     adb -s ${device} shell input swipe 24 682 20 202 100

Custome scroll up
    [Arguments]     ${dy}=-10
    ${output}=      run     adb -s ${device} shell input swipe 24 202 20 682 100

String to comparable
    [Arguments]    ${str}
    ${result}=        Convert To Lowercase    ${str}
    ${result}=        Replace String Using Regexp    ${result}    \\s        \
    ${result}=        Replace String Using Regexp    ${result}    [^a-zA-Z\\d\\s:]        \
    Return From Keyword    ${result}
