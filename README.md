# FasterPayTest

MVVM, CoreData, Native Code, No outside Libraries installed.

Notes:- 

Used core data for saving user data and user payments history.

Used Codable with core data for coding and decoding data for fast response and easy usage.

Used propertyWrapper for cashing userData.

Used DesignSystem principle in UI design.

Used multiple Storyboards for UI Splitting responsibilities.

Used json file to save mock data for test users.

Used unit testing on login and register viewmodel

Used validation on login and registration screen.
    (For example: Password must be at least 8 characters,Must include at least: (1 uppercase, 1 digit,1 symbol ,1 lowercase)).
    
Used currency factor to convert between currencies.
    (For example: if you want to pay in EUR and your balance is in USD you will pay the evaluated value for EUR in USD)

-------------------------------------------------------------------------------------------------------------------
QR Codes:
There is 6 different generated QR codes in side project folder in folder named "Saved QR"

In Order To genrate a new one, go to any qr code on line generator for example:
https://www.the-qrcode-generator.com

QR sample Model in JSON for example:

{
  "companyName": "Elhayes British",
  "currency": "GBP",
  "productName": "British product 2",

  "total": 50,
  "subTotal": 30,
  "fee": 20
}

-------------------------------------------------------------------------------------------------------------------
Test Users:

"mail":"Moh@essam.com",
"password":"Moh@essam.123",


"mail":"Moh@essam.net",
"password":"Moh@essam.123",


"mail":"Moh@essam.eg",
"password":"Moh@essam.123",


"mail":"Moh@essam.test",
"password":"Moh@essam.123",


-------------------------------------------------------------------------------------------------------------------


Note: Balance and Currency are random for every new user.

To Run To simulator or device:
  Just build and run :)
