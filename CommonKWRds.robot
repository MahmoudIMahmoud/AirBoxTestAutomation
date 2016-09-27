*** Settings ***
Library     OperatingSystem
Library     String
Library     AppiumLibrary
Library     Collections
Resource    repository.robot
*** Keywords ***
Do Login
    [Arguments]     ${passwd}   ${assertionstr}
    wait until page contains element  ${loginasguestbtn}   10s
    clear text  ${passwdlocator}
    input text  ${passwdlocator}   ${passwd}
    custome keyboard done
    wait until page contains  ${assertionstr}
    page should contain text  ${assertionstr}

Launch Air Box App
    ${connectedDev}=    get device name
    log to console      ${connectedDev}
    Open Application  ${REMOTE_URL}   platformName=Android  deviceName=${connectedDev}  app=${CURDIR}/Apps/app-espagne-debug.apk

ADB Launch App
    ${output}       run  adb shell am start -n ${pkgName}/${pkgName}.ui.LoginActivity

Close air box App
    ${output}       run  adb shell am force-stop ${pkgName}
    close application
    log to console  finished

Custome keyboard done
    sleep  1s
    ${output}       run  adb shell input keyevent 66 keyevent 66


Custome keyboard back
    sleep  1s
    ${output}       run  adb shell input keyevent 4

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
    ${output}=      run     adb shell input trackball roll 0 ${dy}

