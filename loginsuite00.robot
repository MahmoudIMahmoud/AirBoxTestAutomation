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
    wait until page contains element  xpath=//*[@resource-id='${pkgName}:id/edt_login']   10s
    clear text  xpath=//*[@resource-id='com.orange.airboxflybox:id/edt_password']
    input text  xpath=//*[@resource-id='com.orange.airboxflybox:id/edt_password']   wrongpw
    custome keyboard done
#    click element  xpath=//*[@text='Login']
    wait until page contains  Wrong credentials.
    page should contain text  Wrong credentials.

Login as Guest
    wait until page contains element        xpath=//*[@resource-id='${pkgName}:id/btn_continue_as_guest']   10s
    click element  xpath=//*[@text='Continue as guest']
    wait until page contains  DASHBOARD
    page should contain text  DASHBOARD
    custome keyboard back

Login success
#    launch air box app
    ${output}       run  adb shell am start -n ${pkgName}/${pkgName}.ui.LoginActivity
    wait until page contains element  xpath=//*[@resource-id='${pkgName}:id/edt_login']   10s
    clear text  xpath=//*[@resource-id='com.orange.airboxflybox:id/edt_password']
    input text  xpath=//*[@resource-id='com.orange.airboxflybox:id/edt_password']   admin
    custome keyboard done
#    click element  xpath=//*[@text='Login']
    wait until page contains  DASHBOARD
    page should contain text  DASHBOARD



*** Keywords ***
Launch Air Box App
    Open Application  ${REMOTE_URL}   platformName=Android  deviceName=${devicename}  app=${CURDIR}/Apps/app-espagne-debug.apk
    ${output}       run  adb shell am start -n ${pkgName}/${pkgName}.ui.LoginActivity
    #log to console  ${output}
    #should contain  ${output}  Starting: Intent

Close air box App
    ${output}       run  adb shell am force-stop ${pkgName}
#    ${output}       run  adb shell pm clear ${pkgName}
    close application
    log to console  finished

custome keyboard done
    sleep  1s
    ${output}       run  adb shell input keyevent 66 keyevent 66
#    sleep  3s
#    ${output}       run  adb shell input keyevent 66

custome keyboard back
    sleep  1s
    ${output}       run  adb shell input keyevent 4