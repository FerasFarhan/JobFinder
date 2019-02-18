//
//  TBApi.swift
//  Techband
//
//  Created by Feras Farhan on 11/1/19.
//  Copyright © 2019 Techband. All rights reserved.
//

import Foundation

// MARK: Request types
let GET_REQUEST  = "GET"
let POST_REQUEST = "POST"

let GENERAL_ERROR_CODE = 30001
let TIMEOUT_ERROR_CODE = 30002
let API_ERROR_CODE     = 30003
let CUSTOM_ERROR_CODE  = 30004

// MARK: API CONFIGURATION
public func API_URL_GITHUB(query:String, lat:Double, lon:Double) -> String {
    let query = query.replacingOccurrences(of: " ", with: "+")
    return "https://jobs.github.com/positions.json?search=\(query)&lat=\(lat)&long=\(lon)"
}

public func API_URL_SEARCH_GOV(query:String, lat:Double, lon:Double) -> String {
    let lat_lon = "\(lat),\(lon)"
    let query = query.replacingOccurrences(of: " ", with: "+")
    return "https://jobs.search.gov/jobs/search.json?query=\(query)&lat_lon=\(lat_lon)"
}




