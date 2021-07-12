//
//  AccountInfoResponse.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/7/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON


class AccountInfoResponse {

    let httpcode: String?
    let status: String?
    let message: String?
    let accountInfoData: AccountInfoData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        accountInfoData = AccountInfoData(json["data"])
    }

}
class AccountInfoData {

    let businessInfo: BusinessInfo?

    init(_ json: JSON) {
        businessInfo = BusinessInfo(json["business_info"])
    }

}

class BusinessInfo {

    let businessName: String?
    let businessContactNumber: Int?
    let businessAddress: String?
    let country: Int?
    let region: Int?
    let companyLogo: String?
    let category: Int?
    let operationStartTime: String?
    let operationEndTime: String?
    let offDays: String?
    let serviceTax: Int?
    let governmentTax: Int?
    let profitShare: Int?
    let specialCondition: String?
    let businessCertificate: String?
    let directorName: String?
    let directorIcnumber: String?
    let personIncharge: String?
    let contactNumber: String?
    let promoImage1: String?
    let promoImage2: String?
    let promoImage3: String?

    init(_ json: JSON) {
        businessName = json["business_name"].stringValue
        businessContactNumber = json["business_contact_number"].intValue
        businessAddress = json["business_address"].stringValue
        country = json["country"].intValue
        region = json["region"].intValue
        companyLogo = json["company_logo"].stringValue
        category = json["category"].intValue
        operationStartTime = json["operation_start_time"].stringValue
        operationEndTime = json["operation_end_time"].stringValue
        offDays = json["off_days"].stringValue
        serviceTax = json["service_tax"].intValue
        governmentTax = json["government_tax"].intValue
        profitShare = json["profit_share"].intValue
        specialCondition = json["special_condition"].stringValue
        businessCertificate = json["business_certificate"].stringValue
        directorName = json["director_name"].stringValue
        directorIcnumber = json["director_icnumber"].stringValue
        personIncharge = json["person_incharge"].stringValue
        contactNumber = json["contact_number"].stringValue
        promoImage1 = json["promo_image_1"].stringValue
        promoImage2 = json["promo_image_2"].stringValue
        promoImage3 = json["promo_image_3"].stringValue
    }

}

