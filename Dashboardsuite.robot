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