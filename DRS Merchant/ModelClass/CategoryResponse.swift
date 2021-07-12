//
//  CategoryResponse.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/7/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON
class CategoryResponse {

    let httpcode: String?
    let status: String?
    let message: String?
    let categoryData: CategoryData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        categoryData = CategoryData(json["data"])
    }

}
class CategoryData {

    let categories: [Categories]?

    init(_ json: JSON) {
        categories = json["categories"].arrayValue.map { Categories($0) }
    }

}

class Categories {

    let id: Int?
    let categoryName: String?
    let description: String?
    let status: Int?

    init(_ json: JSON) {
        id = json["id"].intValue
        categoryName = json["category_name"].stringValue
        description = json["description"].stringValue
        status = json["status"].intValue
    }

}

