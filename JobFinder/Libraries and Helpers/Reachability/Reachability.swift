//
//  Reachability.swift
//  JobFinder
//
//  Created by Feras Farhan on 2/18/19.
//  Copyright © 2019 ProgressSoft. All rights reserved.
//

import UIKit
import AVFoundation
import SystemConfiguration
import Alamofire

open class Reachability {

    class func isConnectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in()

        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags = SCNetworkReachabilityFlags()

        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }

        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)

        return (isReachable && !needsConnection)
    }

    class func getInternetConnctivityType() -> String {
        if NetworkReachabilityManager()!.isReachableOnEthernetOrWiFi {
            return "WIFI"
        }

        if NetworkReachabilityManager()!.isReachableOnWWAN {
            return "MobileData"
        }

        return "NotConnected"
    }
}
