//
//  ServiceTaxResponse.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/8/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class ServiceTaxResponse {

    let httpcode: String?
    let status: String?
    let message: String?
    let serviceTaxData: ServiceTaxData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        serviceTaxData = ServiceTaxData(json["data"])
    }

}
class ServiceTaxData {

    let servicetaxList: [ServicetaxList]?

    init(_ json: JSON) {
        servicetaxList = json["servicetax_list"].arrayValue.map { ServicetaxList($0) }
    }

}


class ServicetaxList {

    let id: Int?
    let title: String?
    let percentage: Int?
    let status: Int?

    init(_ json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        percentage = json["percentage"].intValue
        status = json["status"].intValue
    }

}
