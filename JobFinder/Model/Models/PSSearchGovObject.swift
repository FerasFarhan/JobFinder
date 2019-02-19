//
//  PSSearchGovObject.swift
//  JobFinder
//
//  Created by Feras Farhan on 2/18/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import UIKit
import EVReflection

class PSSearchGovObject: EVObject {

    var id = ""
    var position_title = ""
    var organization_name = ""
    var rate_interval_code = ""
    var minimum = ""
    var maximum = ""
    var start_date = ""
    var end_date = ""
    var locations = [String]()
    var url = ""

    override func propertyMapping() -> [(keyInObject: String?, keyInResource: String?)] {
        return [(keyInObject: "id" , keyInResource: "id"),
                (keyInObject: "position_title" , keyInResource: "position_title"),
                (keyInObject: "organization_name" , keyInResource: "organization_name"),
                (keyInObject: "rate_interval_code" , keyInResource: "rate_interval_code"),
                (keyInObject: "minimum" , keyInResource: "minimum"),
                (keyInObject: "maximum" , keyInResource: "maximum"),
                (keyInObject: "start_date" , keyInResource: "start_date"),
                (keyInObject: "end_date" , keyInResource: "end_date"),
                (keyInObject: "locations" , keyInResource: "locations"),
                (keyInObject: "url" , keyInResource: "url")]
    }

    override func setValue(_ value: Any!, forUndefinedKey key: String) {
        TBLogManager.printLog("UndefinedKey", object: key as AnyObject, senderClass: self.self)
        TBLogManager.printLog("value", object: value as AnyObject, senderClass: self.self)
    }
}
