*** Variables ***
${REMOTE_URL}  http://localhost:4723/wd/hub
${devicename}=  29bfe0b7
${pkgName}=     com.orange.airboxflybox
${passwdlocator}		xpath=//*[@resource-id='com.orange.airboxflybox:id/edt_password']
${loginasguestbtn}		xpath=//*[@resource-id='${pkgName}:id/btn_continue_as_guest']