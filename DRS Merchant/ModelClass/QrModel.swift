//
//  LoginResponse.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/4/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class QrModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let qrModelData: QrModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        qrModelData = QrModelData(json["data"])
    }

}
class QrModelData {

    let payQrcode: String?

    init(_ json: JSON) {
        payQrcode = json["pay_qrcode"].stringValue
    }

}
