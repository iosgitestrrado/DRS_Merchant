//
//  SalesReportModel.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 6/17/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class SalesReportModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let salesReportModelData: SalesReportModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        salesReportModelData = SalesReportModelData(json["data"])
    }

}
class SalesReportModelData {

    let salesReport: SalesReport?

    init(_ json: JSON) {
        salesReport = SalesReport(json["sales_report"])
    }

}

class SalesReport {

    let cashPayment: Double?
    let walletPayment: Double?
    let totalPayment: Double?
    let currency: String?

    init(_ json: JSON) {
        cashPayment = json["cash_payment"].doubleValue
        walletPayment = json["wallet_payment"].doubleValue
        totalPayment = json["total_payment"].doubleValue
        currency = json["currency"].stringValue
    }

}
