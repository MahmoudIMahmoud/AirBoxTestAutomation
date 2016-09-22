*** Settings ***
Library     OperatingSystem
Library     String
Library     AppiumLibrary
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
    Open Application  ${REMOTE_URL}   platformName=Android  deviceName=${devicename}  app=${CURDIR}/Apps/app-espagne-debug.apk

ADB Launch App
    ${output}       run  adb shell am start -n ${pkgName}/${pkgName}.ui.LoginActivity

Close air box App
    ${output}       run  adb shell am force-stop ${pkgName}
    close application
    log to console  finished

custome keyboard done
    sleep  1s
    ${output}       run  adb shell input keyevent 66 keyevent 66


custome keyboard back
    sleep  1s
    ${output}       run  adb shell input keyevent 4