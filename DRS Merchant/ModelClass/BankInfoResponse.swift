//
//  BankInfoResponse.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/9/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class BankInfoResponse {

    let httpcode: String?
    let status: String?
    let message: String?
    let bankInfoData: BankInfoData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        bankInfoData = BankInfoData(json["data"])
    }

}
class BankInfoData {

    let bankInfo: BankInfo?

    init(_ json: JSON) {
        bankInfo = BankInfo(json["bank_info"])
    }

}

class BankInfo {

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
