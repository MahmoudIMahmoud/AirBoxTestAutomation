*** Settings ***
Library     OperatingSystem
Library     String
Library     AppiumLibrary
Resource    repository.robot
Resource    CommonKWRds.robot
Library     Collections
Suite Setup  Launch air box App
Suite Teardown  Close air box App
*** Variables ***
${passwdlocator}                        xpath=//*[@resource-id='${pkgName}:id/edt_password']
${loginasguestbtn}                      xpath=//*[@resource-id='${pkgName}:id/btn_continue_as_guest'
${edt_login}                            xpath=//*[@resource-id='${pkgName}:id/edt_login']
${edt_password}                         xpath=//*[@resource-id='${pkgName}:id/edt_password']
${btn_continue_as_guest}                xpath=//*[@resource-id='${pkgName}:id/btn_continue_as_guest']
${btn_Login}                            xpath=//*[@text='${Login}']
*** Test Cases ***
Login Failed
    wait until page contains element  ${edt_login}   10s
    clear text  ${edt_password}
    input text  ${edt_password}   wrongpw
    custome keyboard done
    wait until page contains  ${Wrong credentials}
    page should contain text  ${Wrong credentials}

Login as Guest
    wait until page contains element        ${btn_continue_as_guest}   10s
    click element  ${btn_continue_as_guest}
    wait until page contains  ${DASHBOARD}
    page should contain text  ${DASHBOARD}
    custome keyboard back
    Close air box App

Login success
   launch air box app
    wait until page contains element  ${edt_login}   10s
    clear text  ${edt_password}
    input text  ${edt_password}   admin
    custome keyboard done
    wait until page contains   ${DASHBOARD}
    page should contain text   ${DASHBOARD}



