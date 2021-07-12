//
//  LoginResponse.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/4/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

import SwiftyJSON

class DashboardResponse {

    let httpcode: String?
    let status: String?
    let message: String?
    let dashData: DashData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        dashData = DashData(json["data"])
    }

}
class DashData {

    let dashboardData: DashboardData?

    init(_ json: JSON) {
        dashboardData = DashboardData(json["dashboard_data"])
    }

}

class DashboardData {

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
        greeting = json["greeting"].stringValue
    }

}
