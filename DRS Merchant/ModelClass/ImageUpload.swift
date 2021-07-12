//
//  ImageUpload.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/18/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//


import Foundation
import SwiftyJSON

class ImageUpload {

    let httpcode: String?
    let status: String?
    let message: String?
    let imageUploadData: ImageUploadData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        imageUploadData = ImageUploadData(json["data"])
    }

}


class ImageUploadData {

    let message: String?

    init(_ json: JSON) {
        message = json["message"].stringValue
    }

}
