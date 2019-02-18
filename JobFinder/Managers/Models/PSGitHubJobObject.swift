//
//  PSGitHubJobObject.swift
//  JobFinder
//
//  Created by Feras Farhan on 2/17/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import UIKit
import EVReflection

class PSGitHubJobObject: EVObject {

    var id = ""
    var type = ""
    var url = ""
    var created_at = ""
    var company = ""
    var company_url = ""
    var location = ""
    var title = ""
    var desc = ""
    var how_to_apply = ""
    var company_logo = ""

    override func propertyMapping() -> [(keyInObject: String?, keyInResource: String?)] {
        return [(keyInObject: "id" , keyInResource: "id"),
                (keyInObject: "type" , keyInResource: "type"),
                (keyInObject: "url" , keyInResource: "url"),
                (keyInObject: "created_at" , keyInResource: "created_at"),
                (keyInObject: "company" , keyInResource: "company"),
                (keyInObject: "company_url" , keyInResource: "company_url"),
                (keyInObject: "location" , keyInResource: "location"),
                (keyInObject: "title" , keyInResource: "title"),
                (keyInObject: "desc" , keyInResource: "description"),
                (keyInObject: "how_to_apply" , keyInResource: "how_to_apply"),
                (keyInObject: "company_logo" , keyInResource: "company_logo")]
    }

    override func setValue(_ value: Any!, forUndefinedKey key: String) {
        TBLogManager.printLog("UndefinedKey", object: key as AnyObject, senderClass: self.self)
        TBLogManager.printLog("value", object: value as AnyObject, senderClass: self.self)
    }
}
