//
//  ProfitResponse.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/8/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//


import Foundation
import SwiftyJSON

class ProfitResponse {

    let httpcode: String?
    let status: String?
    let message: String?
    let profitData: ProfitData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        profitData = ProfitData(json["data"])
    }

}

class ProfitData {

    let profitList: [ProfitList]?

    init(_ json: JSON) {
        profitList = json["profit_list"].arrayValue.map { ProfitList($0) }
    }

}

class ProfitList {

    let id: Int?
    let title: String?
    let percent: Int?
    let status: Int?

    init(_ json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        percent = json["percent"].intValue
        status = json["status"].intValue
    }

}
