//
//  ForgotPwdResponse.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/4/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class ForgotPwdResponse: NSObject {
        let httpcode: String?
        let status: String?
        let message: String?
        let forgotPwdData: ForgotPwdData?

        init(_ json: JSON) {
            httpcode = json["httpcode"].stringValue
            status = json["status"].stringValue
            message = json["message"].stringValue
            forgotPwdData = ForgotPwdData(json["data"])
        }

    
}
class ForgotPwdData {

    let success: Success?

    init(_ json: JSON) {
        success = Success(json["success"])
    }

}

class Success {

    let msg: String?

    init(_ json: JSON) {
        msg = json["msg"].stringValue
    }

}
