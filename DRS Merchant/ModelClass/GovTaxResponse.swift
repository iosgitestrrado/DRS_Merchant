//
//  GovTaxResponse.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/8/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import Foundation
import SwiftyJSON


class  GovTaxResponse {

    let httpcode: String?
    let status: String?
    let message: String?
    let govTaxData: GovTaxData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        govTaxData = GovTaxData(json["data"])
    }

}

class GovTaxData {

    let govtaxList: [GovtaxList]?

    init(_ json: JSON) {
        govtaxList = json["govtax_list"].arrayValue.map { GovtaxList($0) }
    }

}

class GovtaxList {

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
