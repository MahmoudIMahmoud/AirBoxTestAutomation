*** Settings ***
Library     OperatingSystem
Library     String
Library     AppiumLibrary

*** Variables ***
${REMOTE_URL}  http://localhost:4723/wd/hub
${devicename}=  29bfe0b7
${pkgName}=     com.orange.airboxflybox
*** Test Cases ***
Test Adb devices
    ${output}       run  adb devices
    log to console  ${output}
    should contain  ${output}   List of devices attached


Test Adb insall
    ${output}       run  adb install -r .\\Apps\\app-espagne-debug.apk
    log to console  ${output}
    should contain  ${output}  Success

Test Adb launch
     Open Application  ${REMOTE_URL}   platformName=Android  deviceName=${devicename}  app=${CURDIR}/Apps/unlock_apk-debug.apk
     launchAirApp
     wait until page contains element  xpath=//*[@resource-id='${pkgName}:id/edt_login']   10s
     input text  xpath=//*[@resource-id='com.orange.airboxflybox:id/edt_password']     admin

*** Keywords ***
launchAirApp
    ${output}       run  adb shell am start -n com.orange.airboxflybox/com.orange.airboxflybox.ui.LoginActivity
    log to console  ${output}
    should contain  ${output}  Starting: Intent