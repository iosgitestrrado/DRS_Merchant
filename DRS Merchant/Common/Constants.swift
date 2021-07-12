//
//  Constants.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/4/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit
class ConstMsg: UIViewController {
    
}

class Constants: NSObject {
    static let textColor =  UIColor(red: 95.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0)
    static let textRedColor =  UIColor(red: 218.0/255.0, green: 55.0/255.0, blue: 50.0/255.0, alpha: 1.0)
    
    static let textBGColor =  UIColor(red: 244.0/255.0, green: 245.0/255.0, blue: 247.0/255.0, alpha: 1.0)
    
    static let textChColor =  UIColor(red: 91.0/255.0, green: 59.0/255.0, blue: 27.0/255.0, alpha: 1.0)
    
    
    static let PlaceholderColorReg =  UIColor(red: 125.0/255.0, green: 144.0/255.0, blue: 170.0/255.0, alpha: 1.0)
    
    static let noRecordsFoundE = "No records found."
    static let noRecordsFoundB = "မှတ်တမ်းမရှိပါ"
    
    static let APP_NAME_BUR = "DRS ကုန်သည်"
    
    static let timedOutMsgE = "Request timed out! Please try again!"
    static let intenalServerE = "Internal server error! Please try again!"
    static let contactServerE = "Server error! Please contact support!"
    
    static let timedOutMsgB = "အချိန်ကုန်ခံတောင်းဆိုမှု! ကျေးဇူးပြု၍ ထပ်မံကြိုးစားပါ"
       static let intenalServerB = "အတွင်းဆာဗာမှားယွင်းမှု! ကျေးဇူးပြု၍ ထပ်မံကြိုးစားပါ"
       static let contactServerB = "ဆာဗာအမှား! ထောက်ခံမှုကိုဆက်သွယ်ပါ။"
    
    
    static let TxtPwdPlaceholder = "Enter Password"
    static let TxtUserPlaceholder = "Enter Username"
    static let APP_ALERT_TITLE = "DRS Merchant"
    static let LOGIN_VALIDATION_MSG = "Username and Password cannot be left empty"
    static let FORGOTPWD_VALIDATION_MSG = "Phone number cannot be left empty"
    static let APP_NO_NETWORK = "Please check the network connection!"
    //https://drssystem.co.uk/uat/api/
    // https://drssystem.co.uk/api/
    
    
    //static let baseURL = "https://estrradodemo.com/drs/api/merchant/"//
    //static let baseURL = "https://estrradodemo.com/drs/uat/api/merchant/" // stagging
    
    
//    static let baseURL = "https://drssystem.co.uk/uat/api/merchant/"// stagging
//    static let baseChatURL = "https://drssystem.co.uk/uat/api/" //live stagging
    
    static let baseURL = "https://drssystem.co.uk/api/merchant/"//live
    static let baseChatURL = "https://drssystem.co.uk/api/" //live

    
    static let InvalidAccessEng = "Invalid access token"
    static let InvalidAccessBur = "မမှန်ကန်သောဆက်သွယ်မှုလက္ခဏာသက်သေ"
    
    static let ReqTimedOutEng = "Request timed out! Please try again!"
    static let ReqTimedOutBur = "အချိန်ကုန်ခံတောင်းဆိုမှု! ကျေးဇူးပြု၍ ထပ်မံကြိုးစားပါ"
    
    static let ServerErrorEng = "Server error! Please contact support!"
    static let ServerErrorBur = "ဆာဗာအမှား! ထောက်ခံမှုကိုဆက်သွယ်ပါ။"
    
    static let IntServerErrorEng = "Internal server error! Please try again!!"
    static let IntServerErrorBur = "အတွင်းဆာဗာမှားယွင်းမှု! ကျေးဇူးပြု၍ ထပ်မံကြိုးစားပါ"
    
    
    static let NotificationList = "notificatinos"
    static let NewsEventDetail = "news"
    
    static let ImageUpdateURL = "/account/image/update"
    static let versionURL = "version"

    static let loginURL = "signin"
    static let forgotPwdURL = "forgot_password"
    static let CountriesURL = "countries"
    static let CategoryURL = "categories"
    static let RegionURL = "regions"
    static let DayURL = "weekdays"
    static let AccountInfoURL = "business_info"
    static let GenInfoURL = "general_info"
    static let BankInfoURL = "bank_info"
    static let ResendOTPURL = "resend_otp"
    static let ResetPwdURL = "reset_password"
    static let VerifyURL = "otp_verify"
    static let DashboardURL = "dashboard"
    static let SignupDropDownURL = "signupdropdowns"
    static let AccountURL = "account"
    static let ProfitURL = "profitlist"
    static let ServiceTaxURL = "servicetaxlist"
    static let GovTaxURL = "govtaxlist"
    static let SignupURL = "ios/signup"
    static let SignOutURL = "signout"
    static let ProfileUpdateURL = "account/update"
    static let VersionURL = "version"
    static let QrURL = "payment/paycode"
    
    static let WithDrawalPageLoadURL = "wallet/withdrawal_page"
    static let WithDrawalPageRequestURL = "wallet/withdrawal_request"
    static let WithDrawalPageHistoryURL = "wallet/withdrawal_history"
    
    static let TranssationHistoryURL = "transaction/history"
    
    static let TranssationDetailViewURL = "transaction/view"
    
    static let SalesReportURL =  "transaction/report"
    
    static let DeleteURL = "support/delete"
    static let MessageDetailURL = "support/message"
    static let SupportMessageListURL = "support/list"
    static let CreateNewChatURL = "support/create"
    static let SendChatURL = "support/send/message"
    
    
    static let LoginEmptyValidation = "Enter Loginid"
    static let EmailEmptyValidation = "Enter emailid"
    static let PwdEmptyValidation = "Enter password"
    static let PinEmptyValidation = "Enter payment pin code"
    static let BNameEmptyValidation = "Enter business name"
    static let BCNumEmptyValidation = "Enter business contact number"
    
    static let BCNumValidation = "The business contact number must be between 7 and 12 digits"
    static let TermsValidation = "Accept terms and conditions"
    
    static let PlaceHolderLoginID = "Your Login ID"
    static let PlaceHolderPWD = "Password"
    static let PlaceHolderEmail = "Email Address"
    static let PlaceHolderDRSRef = "DRS Referral ID *if any"
    static let PlaceHolderDRSUserID = "Your DRS User ID *if any"
    
    static let PlaceHolderBusName = "Business Name"
    static let PlaceHolderBusAddress = "Business Address"
    static let PlaceHolderCountry   = "Country"
    static let PlaceHolderRegion   = "Region"
    static let PlaceHolderCat   = "Category"
    static let PlaceHolderContact   = "Contact Number"
    static let PlaceHolderOperation   = "Operation Hour"
    static let PlaceHolderOffDay   = "Off Day"
    static let PlaceHolderCompanyLogo   = "Company Logo"
    static let PlaceHolderUpload1   = "Upload Image 1"
    static let PlaceHolderUpload2   = "Upload Image 2"
    static let PlaceHolderUpload3   = "Upload Image 3"
    static let PlaceHolderUpload4   = "Upload Image 4"
    static let PlaceHolderSerTax   = "Do you apply service tax?"
    static let PlaceHolderGovTax   = "Do you apply government tax?"
    static let PlaceHolderProfit   = "Profit Sharing"
    static let PlaceHolderCondition   = "Special Condition"
    static let PlaceHolderCert   = "Business Certificate"
    static let PlaceHolderDirector   = "Director Name"
    static let PlaceHolderDirectorICNum   = "Director IC Number"
    static let PlaceHolderCharge   = "Person in Charge Name"
    static let PlaceHolderCName   = "Contact Name"
    static let PlaceHolderBName   = "Branch Name"
    static let PlaceHolderBAddress   = "Branch Address"
    static let PlaceHolderSwiftCode   = "Bank Swift Code"
    static let PlaceHolderBankHoName   = "Bank Holder Name"
    static let PlaceHolderBankAcNum   = "Bank Account Number"
    static let PlaceHolderPin   = "Enter Your Code"
    
    
    
    
    static let UI = "Payment details"
    static let APP_NAME = "DRS"
    // Create a password page
    static let CreatePwdPageHead = "Create a password"
    static let CreatePwdPageSubHead = "Create a password with 6 number to safe guard your DRS"
    static let CreatePwdPagePassword = "Enter password"
    static let CreatePwdPageRePassword = "Re-enter password"
    static let CreatePwdPageReferal = "Referrral ID * if Any"
    static let CreatePwdPageSubmit = "ENTER"
    // Login page
    static let LoginPageHead = "Welcome"
    
    static let LoginSignBtn = "SIGN IN"
    static let BtnForgotPwd = "Forgot Password"
    // Payment Detail OTP page
    static let PaymentDetailsPageTitle = "Payment details"
    static let PaymentDetailsDone = "DONE"
    static let PaymentDetailsPageMainTitle = "Verification codes"
    static let PaymentDetailsPageSubTitle = "Please ask Merchant to Key In Payment Pin Code codes"
    // Payment Detail OTP page
    static let TransactionDetPageTitle = "Transaction Details"
    static let TransactionDetPageSubTitle = "Payment Successful"
    static let TransactionDetPageSubTitleSec = "Payment Unsuccessful"
    static let TransactionDetPageTotal = "Total"
    static let TransactionDetPageMName = "Merchant Name"
    static let TransactionDetPageDate = "Date and time"
    static let TransactionDetPageTransaction = "Transaction ID"
    static let TransactionDetPageUser = "User ID"
    static let TransactionDetPageRebate = "Rebate Entitled"
    static let TransactionDetPageFailMsg = "Merchant Insufficient Credit, Unable to Proceed"
    //user home
    static let items = ["Top Up Wallet", "Buy Voucher Point", "Share"]
    
    
    
    //F4D252 pagebg
    
    
    
    
    
    
}
