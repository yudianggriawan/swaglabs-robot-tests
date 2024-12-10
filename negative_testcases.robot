*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                          https://www.saucedemo.com/v1/index.html
${ID_USERNAME}                  //*[@id="user-name"]
${ID_PASSWORD}                  //*[@id="password"]
${ID_LOGIN}                     //*[@id="login-button"]
${ID_BACKPACK}                  //*[@id="inventory_container"]/div/div[1]/div[3]/button
${ID_CART}                      //*[@id="shopping_cart_container"]/a
${ID_CHECKOUT}                  //*[@id="cart_contents_container"]/div/div[2]/a[2]
${ID_FIRSTNAME}                 //*[@id="first-name"]
${ID_LASTNAME}                  //*[@id="last-name"]
${ID_ZIP/POSTALCODE}            //*[@id="postal-code"]
${ID_CONTINUE}                  //*[@id="checkout_info_container"]/div/form/div[2]/input
${ERROR_CONTAINER}              //*[@data-test="error"]
${INVALID_USERNAME}             invalid_user
${INVALID_PASSWORD}             invalid_pass
${ERROR_MSG_INVALID_CREDENTIALS}  Epic sadface: Username and password do not match any user in this service
${ERROR_MSG_EMPTY_USERNAME}     Epic sadface: Username is required
${ERROR_MSG_EMPTY_PASSWORD}     Epic sadface: Password is required
${ERROR_MSG_MISSING_FIRSTNAME}  Error: First Name is required
${ERROR_MSG_MISSING_ZIP}        Error: Postal Code is required

*** Test Cases ***
Login with Invalid Credentials
    [Documentation]    Verify that login fails with invalid username and password
    Open Browser        ${URL}    edge
    Maximize Browser Window
    Input Text          ${ID_USERNAME}    ${INVALID_USERNAME}
    Input Text          ${ID_PASSWORD}    ${INVALID_PASSWORD}
    Click Button        ${ID_LOGIN}
    Wait Until Page Contains Element    ${ERROR_CONTAINER}    timeout=10s
    Element Text Should Be    ${ERROR_CONTAINER}    ${ERROR_MSG_INVALID_CREDENTIALS}
    Close Browser

Login with Empty Username
    [Documentation]    Verify that login fails when username is left empty
    Open Browser        ${URL}    edge
    Maximize Browser Window
    Clear Element Text  ${ID_USERNAME}
    Input Text          ${ID_PASSWORD}    secret_sauce
    Click Button        ${ID_LOGIN}
    Wait Until Page Contains Element    ${ERROR_CONTAINER}    timeout=10s
    Element Text Should Be    ${ERROR_CONTAINER}    ${ERROR_MSG_EMPTY_USERNAME}
    Close Browser

Login with Empty Password
    [Documentation]    Verify that login fails when password is left empty
    Open Browser        ${URL}    edge
    Maximize Browser Window
    Input Text          ${ID_USERNAME}    standard_user
    Clear Element Text  ${ID_PASSWORD}
    Click Button        ${ID_LOGIN}
    Wait Until Page Contains Element    ${ERROR_CONTAINER}    timeout=10s
    Element Text Should Be    ${ERROR_CONTAINER}    ${ERROR_MSG_EMPTY_PASSWORD}
    Close Browser

Checkout with Missing First Name
    [Documentation]    Verify that checkout fails when the first name is missing
    Open Browser        ${URL}    edge
    Maximize Browser Window
    Input Text          ${ID_USERNAME}    standard_user
    Input Text          ${ID_PASSWORD}    secret_sauce
    Click Button        ${ID_LOGIN}
    Wait Until Page Contains Element    ${ID_BACKPACK}    timeout=15s
    Click Button        ${ID_BACKPACK}
    Click Element       ${ID_CART}
    Click Element       ${ID_CHECKOUT}
    Clear Element Text  ${ID_FIRSTNAME}
    Input Text          ${ID_LASTNAME}     Anggriawan
    Input Text          ${ID_ZIP/POSTALCODE}    666
    Click Button        ${ID_CONTINUE}
    Wait Until Page Contains Element    ${ERROR_CONTAINER}    timeout=10s
    Element Text Should Be    ${ERROR_CONTAINER}    ${ERROR_MSG_MISSING_FIRSTNAME}
    Close Browser

Checkout with Missing ZIP Code
    [Documentation]    Verify that checkout fails when ZIP Code is missing
    Open Browser        ${URL}    edge
    Maximize Browser Window
    Input Text          ${ID_USERNAME}    standard_user
    Input Text          ${ID_PASSWORD}    secret_sauce
    Click Button        ${ID_LOGIN}
    Wait Until Page Contains Element    ${ID_BACKPACK}    timeout=15s
    Click Button        ${ID_BACKPACK}
    Click Element       ${ID_CART}
    Click Element       ${ID_CHECKOUT}
    Input Text          ${ID_FIRSTNAME}    Yudi
    Input Text          ${ID_LASTNAME}     Anggriawan
    Clear Element Text  ${ID_ZIP/POSTALCODE}
    Click Button        ${ID_CONTINUE}
    Wait Until Page Contains Element    ${ERROR_CONTAINER}    timeout=10s
    Element Text Should Be    ${ERROR_CONTAINER}    ${ERROR_MSG_MISSING_ZIP}
    Close Browser
