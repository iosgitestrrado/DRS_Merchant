//
//  LoginResponse.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/4/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class LoginResponse {

    let httpcode: String?
    let status: String?
    let message: String?
    let loginData: LoginData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        loginData = LoginData(json["data"])
    }

}
class LoginData {

    let userData: UserData?

    init(_ json: JSON) {
        userData = UserData(json["user_data"])
    }

}

class UserData {

    let businessName: String?
    let email: String?
    let phone: Int?
    let userRole: Int?
    let paymentPincode: String?
    let category: Int?
    let personIncharge: String?
    let companyLogo: String?
    let accountNumber: String?
    let accountBalance: String?
    let notificationCount: Int?
    let categoryName: String?
    let accessToken: String?
    let greeting: String?

    init(_ json: JSON) {
        businessName = json["business_name"].stringValue
        email = json["email"].stringValue
        phone = json["phone"].intValue
        userRole = json["user_role"].intValue
        paymentPincode = json["payment_pincode"].stringValue
        category = json["category"].intValue
        personIncharge = json["person_incharge"].stringValue
        companyLogo = json["company_logo"].stringValue
        accountNumber = json["account_Number"].stringValue
        accountBalance = json["account_balance"].stringValue
        notificationCount = json["notification_count"].intValue
        categoryName = json["category_name"].stringValue
        accessToken = json["access_token"].stringValue
        greeting = json["greeting"].stringValue
    }

}
