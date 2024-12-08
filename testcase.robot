*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                          https://www.saucedemo.com/v1/index.html
${ID_USERNAME}                  //*[@id="user-name"]
${ID_PASSWORD}                  //*[@id="password"]
${ID_LOGIN}                     //*[@id="login-button"]
${ID_BACKPACK}                  //*[@id="inventory_container"]/div/div[1]/div[3]/button
${ID_SHIRTS}                    //*[@id="inventory_container"]/div/div[3]/div[3]/button
${ID_CART}                      //*[@id="shopping_cart_container"]/a
${ID_CHECKOUT}                  //*[@id="cart_contents_container"]/div/div[2]/a[2]
${ID_FIRSTNAME}                 //*[@id="first-name"]
${ID_LASTNAME}                  //*[@id="last-name"]
${ID_ZIP/POSTALCODE}            //*[@id="postal-code"]
${ID_CONTINUE}                  //*[@id="checkout_info_container"]/div/form/div[2]/input
${ID_FINISH}                    //div[@id='checkout_summary_container']/div/div[2]/div[8]/a[2]

*** Test Cases ***
Shopping at Swaglabs
    [Documentation]    Test shopping flow in Swaglabs application
    Login
    Add to Cart
    Input Personal Data Information
    Complete Checkout

*** Keywords ***
Login
    [Documentation]    Perform login to Swaglabs
    Open Browser        ${URL}    edge
    Maximize Browser Window
    Input Text          ${ID_USERNAME}    standard_user
    Input Text          ${ID_PASSWORD}    secret_sauce
    Click Button        ${ID_LOGIN}

Add to Cart
    [Documentation]    Add items to the shopping cart
    Wait Until Page Contains Element    ${ID_BACKPACK}    timeout=15s
    Scroll Element Into View            ${ID_BACKPACK}
    Click Button                        ${ID_BACKPACK}

    Wait Until Page Contains Element    ${ID_SHIRTS}      timeout=15s
    Scroll Element Into View            ${ID_SHIRTS}
    Click Button                        ${ID_SHIRTS}

    Wait Until Page Contains Element    ${ID_CART}        timeout=15s
    Scroll Element Into View            ${ID_CART}
    Click Element                       ${ID_CART}

    Wait Until Page Contains Element    ${ID_CHECKOUT}    timeout=15s
    Scroll Element Into View            ${ID_CHECKOUT}
    Click Element                       ${ID_CHECKOUT}

Input Personal Data Information
    [Documentation]    Input user personal data during checkout
    Wait Until Page Contains Element    ${ID_FIRSTNAME}    timeout=15s
    Input Text                           ${ID_FIRSTNAME}    Yudi
    Input Text                           ${ID_LASTNAME}     Anggriawan
    Input Text                           ${ID_ZIP/POSTALCODE}     666
    Click Button                         ${ID_CONTINUE}

Complete Checkout
    [Documentation]    Finalize the checkout process
    Wait Until Page Contains Element    ${ID_FINISH}    timeout=15s
    Wait Until Element Is Visible       ${ID_FINISH}    timeout=10s
    Click Element                        ${ID_FINISH}
