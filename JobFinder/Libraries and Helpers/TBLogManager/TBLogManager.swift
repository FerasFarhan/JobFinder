//
//  TBLogManager.swift
//  Techband
//
//  Created by Feras Farhan on 3/28/19.
//  Copyright © 2019 Techband. All rights reserved.
//

/*
 This class is a helper to enable and disable logs for the app level
 */

import UIKit

// MARK: LOG CONFIGURATION
let ENABLE_DEBUG_MODE = true

class TBLogManager: NSObject {
    
    class func printLog(_ message:String,
                        object:AnyObject?,
                        senderClass:AnyObject) {

        if ENABLE_DEBUG_MODE {
            if let obj = object {
                print("Log Date: \(Date()) ==== Sender Class ==== \(senderClass)\n\(message) : \(obj) \n")
            }
            else {
                print("Log Date: \(Date()) ==== Sender Class ==== \(senderClass)\n\(message)\n")
            }
        }
    }
    
    class func printURL(_ url:AnyObject?,
                        senderClass:AnyObject) {

        if ENABLE_DEBUG_MODE, let url = url {
            print("Log Date: \(Date()) ==== Sender Class ==== \(senderClass)\nurl: \(url)\n")
        }
    }
    
    class func printParameters(_ parameters:AnyObject,
                               senderClass:AnyObject) {

        if ENABLE_DEBUG_MODE {
            print("Log Date: \(Date()) ==== Sender Class ==== \(senderClass)\nParameters: \(parameters)\n")
        }
    }
    
    class func printResponse(_ resultArray:AnyObject,
                             url:AnyObject,
                             senderClass:AnyObject) {
        if ENABLE_DEBUG_MODE {
            print("Log Date: \(Date()) ==== Sender Class ==== \(senderClass)\nResponse: \(resultArray)\nUrl: \(url)\n")
        }
    }
}






