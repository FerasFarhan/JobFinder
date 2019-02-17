//
//  TBUserObject.swift
//  Techband
//
//  Created by Feras Farhan on 12/8/19.
//  Copyright © 2019 Techband. All rights reserved.
//

import UIKit
import EVReflection

class TBUserObject: EVObject {

    var currency_en = ""
    var currency_ar = ""
    var isHandicap = false

    override func propertyMapping() -> [(keyInObject: String?, keyInResource: String?)] {
        return [(keyInObject: "currency_en" , keyInResource: "currency_en"),
                (keyInObject: "currency_ar" , keyInResource: "currency_ar"),
                (keyInObject: "isHandicap" , keyInResource: "isHandicap")]
    }

    override func setValue(_ value: Any!, forUndefinedKey key: String) {
        TBLogManager.printLog("UndefinedKey", object: key as AnyObject, senderClass: self.self)
        TBLogManager.printLog("value", object: value as AnyObject, senderClass: self.self)
    }
}
