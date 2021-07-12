//
//  SignUpDropDownResponse.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/11/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class SignUpDropDownResponse {

    let httpcode: String?
    let status: String?
    let message: String?
    let signUpDpData: SignUpDpData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        signUpDpData = SignUpDpData(json["data"])
    }

}

class SignUpDpData {

    let categories: [CategoryLists]?
    let countryList: [CountryLists]?
   
    let dayList: [DayLists]?
    let profitList: [ProfitLists]?
    let servicetaxList: [ServicetaxLists]?
    let govtaxList: [GovtaxLists]?

    init(_ json: JSON) {
        categories = json["categories"].arrayValue.map { CategoryLists($0) }
        countryList = json["country_list"].arrayValue.map { CountryLists($0) }
       
        dayList = json["day_list"].arrayValue.map { DayLists($0) }
        profitList = json["profit_list"].arrayValue.map { ProfitLists($0) }
        servicetaxList = json["servicetax_list"].arrayValue.map { ServicetaxLists($0) }
        govtaxList = json["govtax_list"].arrayValue.map { GovtaxLists($0) }
    }

}

class CategoryLists {

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

class CountryLists {

    let id: Int?
    let name: String?
    let status: Int?

    init(_ json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        status = json["status"].intValue
    }

}

class DayLists {

    let id: Int?
    let day: String?
    let status: Int?

    init(_ json: JSON) {
        id = json["id"].intValue
        day = json["day"].stringValue
        status = json["status"].intValue
    }

}


class ProfitLists {

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

class ServicetaxLists {

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

class GovtaxLists {

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
