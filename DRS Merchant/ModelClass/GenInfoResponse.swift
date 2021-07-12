//
//  GenInfoResponse.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/8/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class GenInfoResponse {

    let httpcode: String?
    let status: String?
    let message: String?
    let generalInfoData: GeneralInfoData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        generalInfoData = GeneralInfoData(json["data"])
    }

}

class GeneralInfoData {

    let generalInfo: GeneralInfo?

    init(_ json: JSON) {
        generalInfo = GeneralInfo(json["general_info"])
    }

}


class GeneralInfo {

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
