//
//  AccountInfoDetailResponse.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/13/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class AccountInfoDetailResponse {

    let httpcode: String?
    let status: String?
    let message: String?
    let accountInfoDetData: AccountInfoDetData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        accountInfoDetData = AccountInfoDetData(json["data"])
    }

}
class AccountInfoDetData {

    let generalInfoDat: GeneralInfoDat?
    let businessInfoDat: BusinessInfoDat?
    let bankInfoDat: BankInfoDat?

    init(_ json: JSON) {
        generalInfoDat = GeneralInfoDat(json["general_info"])
        businessInfoDat = BusinessInfoDat(json["business_info"])
        bankInfoDat = BankInfoDat(json["bank_info"])
    }

}

class GeneralInfoDat {

    let loginId: String?
    let email: String?
    let drsUserid: String?
    let referalId: String?
    let paymentPincode: String?

    init(_ json: JSON) {
        loginId = json["login_id"].stringValue
        email = json["email"].stringValue
        drsUserid = json["drs_userid"].stringValue
        referalId = json["referal_id"].stringValue
        paymentPincode = json["payment_pincode"].stringValue
    }

}
class BusinessInfoDat {

    let businessName: String?
    let businessContactNumber: String?
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
    let offDaysLabel: String?
    
    let busCountryCode: String?
     let contactCountryCode: String?

    init(_ json: JSON) {
        busCountryCode = json["business_country_code"].stringValue
        contactCountryCode = json["contact_country_code"].stringValue
        businessName = json["business_name"].stringValue
        businessContactNumber = json["business_contact_number"].stringValue
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
        offDaysLabel = json["off_days_label"].stringValue
    }

}
class BankInfoDat {

    let bankId: String?
    let bankName: String?
    let branchAddress: String?
    let swiftCode: String?
    let accountHolder: String?
    let accountNumber: String?

    init(_ json: JSON) {
        bankId = json["bank_id"].stringValue
        bankName = json["bank_name"].stringValue
        branchAddress = json["branch_address"].stringValue
        swiftCode = json["swift_code"].stringValue
        accountHolder = json["account_holder"].stringValue
        accountNumber = json["account_number"].stringValue
    }

}
