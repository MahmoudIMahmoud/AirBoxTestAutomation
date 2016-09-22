*** Settings ***
Library     Collections

*** Test Cases ***
Create List Test Case
    [Tags]    CollectionsTest
    @{MyList}=    Create List    item1    item2    item3
    Append To List      ${MyList}       item4   item5
    Log List    ${MyList}
    List Should Contain Value    ${MyList}    item4
    @{Lst2}=    create list  a  b   c
    append to list  ${MyList}   ${Lst2}
    log list  ${mylist}
    list should contain value  ${mylist}    ${lst2}


Test Combine lists
    @{Lst1}=    Create List     a   b       c
    @{Lst2}=    Create List     1   2       3
    @{Lst3}=    combine lists   ${Lst1}     ${Lst2}
    log list    ${Lst3}
    List Should Contain Value    ${Lst3}    3

Test Convert elemet to list
    @{Lst3}=        create list  q      w       e
    @{LstFromItem}=     convert to list     A
    @{LstFromItem}=     combine lists  ${LstFromItem}   ${Lst3}
    log list  ${LstFromItem}
    list should contain value   ${LstFromItem}  A


Test Convert tuple To List
    ${tup1}    Set Variable    a    b    c    d    sm
    @{MyList}=    Convert To List    ${tup1}
    Log List    ${MyList}
    ${ListLength}=    Get Length    ${MyList}
    Log    'List Size is : ' ${ListLength}
    List Should Contain Value    ${MyList}    sm


Test Copy list
    @{Lst1}=        create list  Alpha      Beta       Gama
    @{LstFromItem}=     convert to list     A
    @{LstFromItem}=     combine lists  ${LstFromItem}   ${Lst1}
    log list  ${LstFromItem}
    @{LstCpy}       copy list       ${LstFromItem}
    log list  ${LstCpy}
    list should contain value   ${LstCpy}  A

Test Count values in a list
    @{Lst1}=        create list  Alpha      Beta       Gama
    log list  ${Lst1}
    @{LstCpy}       copy list       ${Lst1}
    ${L0}=  get length  ${Lst1}
    append to list  ${LstCpy}  Zeta
    ${L1}=      evaluate  ${L0}+1
    log list  ${LstCpy}
    should be equal as integers     ${L1}   4
    list should contain value   ${LstCpy}  Zeta

Test Sort The list
    @{Lst1}=        create list  1      11        01
    append to list      ${Lst1}     001     2       02
    log list    ${Lst1}
    @{sorted}=      sort list  ${Lst1}
    ${item}=        get from list   ${Lst1}     0
    log     ${item}
    log list  ${Lst1}
    log list  ${sorted}
    log     it will not return the sorted list instead it sorts the list it self :)

Test Addressing list items
    @{Lst}  create list  b  d   a
    log list  ${Lst}
    ${item0}    get from list  ${lst}   0
    log  ${item0}
    sort list  ${Lst}
    ${item0}    get from list  ${lst}   0
    log  ${item0}
    should be equal  ${item0}   a
    reverse list  ${lst}
    ${item0}    get from list  ${lst}   0
    should be equal  ${item0}   d
    ${myslice}    get slice from list  ${lst}  0  1
    log list  ${myslice}
