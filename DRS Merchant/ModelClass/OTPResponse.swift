//
//  OTPResponse.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/13/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class OTPResponse {

    let httpcode: String?
    let status: String?
    let message: String?
    let oTPData: OTPData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        oTPData = OTPData(json["data"])
    }

}

class OTPData {

    let verifyData: VerifyData?

    init(_ json: JSON) {
        verifyData = VerifyData(json["verify_data"])
    }

}

class VerifyData {

    let otpToken: Int?
    let phoneNumber: Int?

    init(_ json: JSON) {
        otpToken = json["otp_token"].intValue
        phoneNumber = json["phone_number"].intValue
    }

}
