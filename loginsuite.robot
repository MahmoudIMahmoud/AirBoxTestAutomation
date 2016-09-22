*** Settings ***
Library     OperatingSystem
Library     String
Library     AppiumLibrary
Resource    repository.robot
Suite Setup  Launch air box App
Suite Teardown  Close air box App

*** Variables ***

*** Test Cases ***
Login Failed
    wait until page contains element  ${loginasguestbtn}   10s
    clear text  ${passwdlocator}
    input text  ${passwdlocator}   wrongpw
    custome keyboard done
    wait until page contains  Wrong credentials.
    page should contain text  Wrong credentials.

Login as Guest
    wait until page contains element        ${loginasguestbtn}   10s
    click element  xpath=//*[@text='Continue as guest']
    wait until page contains  DASHBOARD
    page should contain text  DASHBOARD
    custome keyboard back

Login success
    ADB Launch App
    wait until page contains element  ${loginasguestbtn}   10s
    clear text  ${passwdlocator}
    input text  ${passwdlocator}   admin
    custome keyboard done
    wait until page contains  DASHBOARD
    page should contain text  DASHBOARD



*** Keywords ***
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
