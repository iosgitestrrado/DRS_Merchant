//
//  TrasactionDetailModel.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 6/16/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class TrasactionDetailModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let trasactionDetailModelData: TrasactionDetailModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        trasactionDetailModelData = TrasactionDetailModelData(json["data"])
    }

}
class TrasactionDetailModelData {

    let transactionData: TransactionData?

    init(_ json: JSON) {
        transactionData = TransactionData(json["transaction_data"])
    }

}

class TransactionData {

    let id: Int?
    let total: String?
    let paymentType: String?
    let totalTaxation: String?
    let profitSharing: String?
    let profitSharingAmount: String?
    let dataTime: String?
    let transactionId: String?
    let userId: String?

    init(_ json: JSON) {
        id = json["id"].intValue
        total = json["total"].stringValue
        paymentType = json["payment_type"].stringValue
        totalTaxation = json["total_taxation"].stringValue
        profitSharing = json["profit_sharing"].stringValue
        profitSharingAmount = json["profit_sharing_amount"].stringValue
        dataTime = json["data_time"].stringValue
        transactionId = json["transaction_id"].stringValue
        userId = json["user_id"].stringValue
    }

}
