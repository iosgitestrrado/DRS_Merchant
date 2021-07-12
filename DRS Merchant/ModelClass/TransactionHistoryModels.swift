//
//  TransactionHistoryModels.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 6/16/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//


import Foundation
import SwiftyJSON

class TransactionHistoryModels {

    let httpcode: String?
    let status: String?
    let message: String?
    let transactionHistoryModelData: TransactionHistoryModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        transactionHistoryModelData = TransactionHistoryModelData(json["data"])
    }

}
class TransactionHistoryModelData {

    let transactionHistory: [TransactionHistory]?

    init(_ json: JSON) {
        transactionHistory = json["transaction_history"].arrayValue.map { TransactionHistory($0) }
    }

}

class TransactionHistory {

    let date: String?
    let transactionHistoryValue: [TransactionHistoryValue]?

    init(_ json: JSON) {
        date = json["date"].stringValue
        transactionHistoryValue = json["value"].arrayValue.map { TransactionHistoryValue($0) }
    }

}

class TransactionHistoryValue {

    let id: String?
    let transactionId: String?
    let date: String?
    let time: String?
    let paidOn: String?
    let amount: String?
    let paymentType: String?
    let status: String?

    init(_ json: JSON) {
        id = json["id"].stringValue
        transactionId = json["transaction_id"].stringValue
        date = json["date"].stringValue
        time = json["time"].stringValue
        paidOn = json["paid_on"].stringValue
        amount = json["amount"].stringValue
        paymentType = json["payment_type"].stringValue
        status = json["status"].stringValue
    }

}
