//
//  RegionResponse.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/7/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON
class RegionResponse {

    let httpcode: String?
    let status: String?
    let message: String?
    let regionData: RegionData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        regionData = RegionData(json["data"])
    }

}

class RegionData {

    let regionsList: [RegionsList]?

    init(_ json: JSON) {
        regionsList = json["regions_list"].arrayValue.map { RegionsList($0) }
    }

}

class RegionsList {

    let id: Int?
    let name: String?
    let status: Int?

    init(_ json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        status = json["status"].intValue
    }

}

