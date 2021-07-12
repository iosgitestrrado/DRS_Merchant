//
//  DayResponse.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/7/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class DayResponse {

    let httpcode: String?
    let status: String?
    let message: String?
    let dayData: DayData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        dayData = DayData(json["data"])
    }

}
class DayData {

    let dayList: [DayList]?

    init(_ json: JSON) {
        dayList = json["day_list"].arrayValue.map { DayList($0) }
    }

}

class DayList {

    let id: Int?
    let day: String?
    let status: Int?

    init(_ json: JSON) {
        id = json["id"].intValue
        day = json["day"].stringValue
        status = json["status"].intValue
    }

}

