//
//  WithdrawalModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 6/10/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class WithdrawalModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let withdrawalModeldata: WithdrawalModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        withdrawalModeldata = WithdrawalModelData(json["data"])
    }

}
class WithdrawalModelData {

    
    let actions: String?
    let referalWithdrawalData: ReferalWithdrawalData?

    init(_ json: JSON) {
        actions = json["actions"].stringValue
        referalWithdrawalData = ReferalWithdrawalData(json["wallet_withdrawal_data"])
    }

}

class ReferalWithdrawalData {

    let amount: String?
    let refId: String?

    init(_ json: JSON) {
        
        amount = json["amount"].stringValue
        refId = json["ref_id"].stringValue
    }

}
