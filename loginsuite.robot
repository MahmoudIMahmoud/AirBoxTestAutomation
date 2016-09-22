*** Settings ***
Library     OperatingSystem
Library     String
Library     AppiumLibrary
Resource    repository.robot
Resource    CommonKWRds.robot
Suite Setup  Launch air box App
Suite Teardown  Close air box App

*** Variables ***

*** Test Cases ***
Login Failed
    Do Login  WrongPass     Wrong credentials.

Login as Guest
    wait until page contains element        ${loginasguestbtn}   10s
    click element  xpath=//*[@text='Continue as guest']
    wait until page contains  DASHBOARD
    page should contain text  DASHBOARD
    custome keyboard back

Login success
    ADB Launch App
    do login  admin     DASHBOARD





